<?php

namespace App\Http\Controllers;

use App\Models\TransactionDetail;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Carbon\CarbonPeriod;

class ReportController extends Controller
{
    public function salesReport(Request $request)
    {
        $filter = $request->input('filter', 'today');

        $query = TransactionDetail::with(['transaction', 'product']);

        switch ($filter) {
            case 'today':
                $query->whereDate('created_at', Carbon::today());
                break;

            case 'week':
                $query->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);
                break;

            case 'month':
                $query->whereMonth('created_at', Carbon::now()->month);
                break;

            case 'year':
                $query->whereYear('created_at', Carbon::now()->year);
                break;

            default:
                // fallback to all
                break;
        }

        $details = $query->latest()->get();

        return inertia('Reports/SalesReport', [
            'details' => $details,
            'filter' => $filter,
        ]);
    }
}
