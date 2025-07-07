<?php

namespace App\Http\Controllers;

use App\Models\TransactionDetail;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Customer;
use App\Models\Expense;
use App\Models\Product;
use App\Models\Transaction;
use Barryvdh\DomPDF\Facade\Pdf;
use Inertia\Inertia;

class ReportController extends Controller
{
    public function salesReport(Request $request)
    {
        $filter = $request->input('filter');
        $start_date = $request->input('start_date');
        $end_date = $request->input('end_date');
        $status = $request->input('status');
        $jenis_customer = $request->input('is_anggota');

        $query = TransactionDetail::with(['transaction.customer', 'product']) // tambahkan 'customer'
            ->whereHas('transaction', function ($q) use ($filter, $start_date, $end_date, $status, $jenis_customer) {
                if ($filter) {
                    switch ($filter) {
                        case 'today':
                            $q->whereDate('created_at', Carbon::today());
                            break;
                        case 'week':
                            $q->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);
                            break;
                        case 'month':
                            $q->whereMonth('created_at', Carbon::now()->month);
                            break;
                        case 'year':
                            $q->whereYear('created_at', Carbon::now()->year);
                            break;
                    }
                }

                if ($start_date && $end_date) {
                    $q->whereBetween('created_at', [
                        Carbon::parse($start_date)->startOfDay(),
                        Carbon::parse($end_date)->endOfDay()
                    ]);
                }

                if ($status && in_array($status, ['lunas', 'belum lunas'])) {
                    $q->where('paid_status', $status);
                }

                if ($jenis_customer !== null && $jenis_customer !== '') {
                    $q->whereHas('customer', function ($c) use ($jenis_customer) {
                        $c->where('is_anggota', $jenis_customer);
                    });
                }
            });

        $details = $query->latest()->get();

        return inertia('Reports/SalesReport', [
            'details' => $details,
            'filter' => $filter,
            'start_date' => $start_date,
            'end_date' => $end_date,
            'status' => $status,
            'jenis_customer' => $jenis_customer, // <- penting
        ]);
    }

    public function markAsPaid(Request $request, $id)
    {
        $trx = Transaction::findOrFail($id);
        $cash = $request->input('cash');
        $grand_total = $trx->grand_total;

        // Validasi cash
        if ($cash < $grand_total) {
            // Cek apakah ini request dari Inertia (SPA)
            if ($request->expectsJson()) {
                return response()->json([
                    'message' => 'Jumlah pembayaran kurang dari total tagihan'
                ], 422);
            }

            return back()->with('error', 'Jumlah pembayaran kurang dari total tagihan');
        }

        $trx->cash = $cash;
        $trx->change = $cash - $grand_total;
        $trx->paid_status = 'lunas';
        $trx->save();

        if ($request->expectsJson()) {
            return response()->json([
                'message' => 'Transaksi berhasil dibayar'
            ]);
        }

        return back()->with('success', 'Transaksi berhasil dibayar');
    }

    public function exportPdf(Request $request)
    {

        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $status = $request->status;
        $jenis_customer = $request->is_anggota;

        $query = TransactionDetail::with(['transaction.customer', 'product']);

        if ($start_date && $end_date) {
            $query->whereBetween('created_at', [$start_date, $end_date]);
        }

        if ($status) {
            $query->whereHas('transaction', fn($q) => $q->where('paid_status', $status));
        }

        if ($jenis_customer) {
            $query->whereHas('transaction.customer', fn($q) => $q->where('jenis', $jenis_customer));
        }

        $details = $query->get();

        $pdf = Pdf::loadView('reports.sales_pdf', compact('details', 'start_date', 'end_date', 'status', 'jenis_customer'));
        return $pdf->stream('laporan-penjualan.pdf', [
            'Attachment' => false,
        ]);
    }


    public function expenses(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        // 🔹 1. Pembelian Barang
        $produk = Product::select(
            \DB::raw('null as id'),
            \DB::raw('"Pembelian Barang" as kategori'),
            \DB::raw('SUM(buy_price * stock) as total'),
            \DB::raw('MAX(updated_at) as tanggal'),
            \DB::raw('null as deskripsi'),
            \DB::raw('null as jumlah')
        )
            ->when($start_date && $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('updated_at', [
                    Carbon::parse($start_date)->startOfDay(),
                    Carbon::parse($end_date)->endOfDay()
                ]);
            })
            ->first();

        // 🔹 2. Pengeluaran Manual (ambil semua data untuk kebutuhan edit)
        $pengeluaranManual = Expense::select(
            'id',
            'kategori',
            'jumlah as total',
            'tanggal',
            'deskripsi',
            'jumlah'
        )
            ->when($start_date && $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('tanggal', [
                    Carbon::parse($start_date)->startOfDay(),
                    Carbon::parse($end_date)->endOfDay()
                ]);
            })
            ->get();

        // 🔹 Gabungkan
        $pengeluaransGabungan = collect([$produk])->merge($pengeluaranManual);

        // 🔹 Total semua pengeluaran
        $totalPengeluaran = $pengeluaransGabungan->sum('total');

        // 🔹 Hitung kas masuk
        $kasMasuk = TransactionDetail::join('transactions', 'transaction_details.transaction_id', '=', 'transactions.id')
            ->where('transactions.paid_status', 'lunas')
            ->when($start_date && $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('transaction_details.created_at', [
                    Carbon::parse($start_date)->startOfDay(),
                    Carbon::parse($end_date)->endOfDay()
                ]);
            })
            ->select(\DB::raw('SUM(transaction_details.qty * transaction_details.price) as total'))
            ->value('total');

        $saldo = $kasMasuk - $totalPengeluaran;

        return Inertia::render('Reports/Expenses', [
            'expenses' => $pengeluaransGabungan,
            'total' => $totalPengeluaran,
            'saldo' => $saldo,
            'start_date' => $start_date,
            'end_date' => $end_date,
        ]);
    }

    public function exportPdfE(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;

        // 1. Pembelian Barang
        $produk = Product::select(
            \DB::raw('null as id'),
            \DB::raw('"Pembelian Barang" as kategori'),
            \DB::raw('SUM(buy_price * stock) as total'),
            \DB::raw('MAX(updated_at) as tanggal'),
            \DB::raw('null as deskripsi'),
            \DB::raw('null as jumlah')
        )
            ->when($start_date && $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('updated_at', [
                    Carbon::parse($start_date)->startOfDay(),
                    Carbon::parse($end_date)->endOfDay()
                ]);
            })
            ->first();

        // 2. Pengeluaran Manual
        $pengeluaranManual = Expense::select(
            'id',
            'kategori',
            'jumlah as total',
            'tanggal',
            'deskripsi',
            'jumlah'
        )
            ->when($start_date && $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('tanggal', [
                    Carbon::parse($start_date)->startOfDay(),
                    Carbon::parse($end_date)->endOfDay()
                ]);
            })
            ->get();

        // Gabungkan
        $pengeluaransGabungan = collect([$produk])->merge($pengeluaranManual);

        // Total pengeluaran
        $total = $pengeluaransGabungan->sum('total');

        // Kas Masuk
        $kasMasuk = TransactionDetail::join('transactions', 'transaction_details.transaction_id', '=', 'transactions.id')
            ->where('transactions.paid_status', 'lunas')
            ->when($start_date && $end_date, function ($query) use ($start_date, $end_date) {
                return $query->whereBetween('transaction_details.created_at', [
                    Carbon::parse($start_date)->startOfDay(),
                    Carbon::parse($end_date)->endOfDay()
                ]);
            })
            ->select(\DB::raw('SUM(transaction_details.qty * transaction_details.price) as total'))
            ->value('total');

        $saldo = $kasMasuk - $total;

        $pdf = Pdf::loadView('reports.expenses_pdf', [
            'expenses' => $pengeluaransGabungan,
            'total' => $total,
            'saldo' => $saldo,
            'start_date' => $start_date,
            'end_date' => $end_date,
        ]);

        return $pdf->stream('laporan-pengeluaran.pdf');
    }
}
