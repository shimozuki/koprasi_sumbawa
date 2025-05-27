<?php

namespace App\Http\Controllers;

use App\Models\TransactionDetail;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Customer;

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
}
