<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Expense;
use Inertia\Inertia;

class ExpenseController extends Controller
{
    public function index()
    {
        $expenses = Expense::latest()->get();
        return Inertia::render('Expenses/Index', [
            'expenses' => $expenses,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'tanggal' => 'required|date',
            'kategori' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'jumlah' => 'required|numeric|min:0',
        ]);

        Expense::create($validated);

        return redirect()->route('report.Expenses')->with('success', 'Pengeluaran berhasil ditambahkan.');
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'tanggal' => 'required|date',
            'kategori' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'jumlah' => 'required|numeric|min:0',
        ]);

        $expense = Expense::findOrFail($id);
        $expense->update($validated);

        return redirect()->route('reports.expenses')->with('success', 'Pengeluaran berhasil diperbarui.');
    }
}
