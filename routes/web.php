<?php

use App\Http\Controllers\Apps\CategoryController;
use App\Http\Controllers\Apps\CustomerController;
use App\Http\Controllers\Apps\ProductController;
use App\Http\Controllers\Apps\TransactionController;
use App\Http\Controllers\ExpenseController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return redirect()->route('login');
});

Route::group(['prefix' => 'dashboard', 'middleware' => ['auth']], function () {
    Route::get('/', [TransactionController::class, 'getTransactionStats'])->middleware(['auth', 'verified'])->name('dashboard');
    Route::get('/permissions', [PermissionController::class, 'index'])->name('permissions.index');
    // roles route
    Route::resource('/roles', RoleController::class)->except(['create', 'edit', 'show']);
    // users route
    Route::resource('/users', UserController::class)->except('show');

    Route::resource('categories', CategoryController::class);
    Route::resource('products', ProductController::class);
    Route::resource('customers', CustomerController::class);
    //route transaction
    Route::get('/transactions', [\App\Http\Controllers\Apps\TransactionController::class, 'index'])->name('transactions.index');

    //route transaction searchProduct
    Route::post('/transactions/searchProduct', [\App\Http\Controllers\Apps\TransactionController::class, 'searchProduct'])->name('transactions.searchProduct');

    //route transaction addToCart
    Route::post('/transactions/addToCart', [\App\Http\Controllers\Apps\TransactionController::class, 'addToCart'])->name('transactions.addToCart');
    Route::get('/transactions/stats', [\App\Http\Controllers\Apps\TransactionController::class, 'getTransactionStats'])->name('transactions.stats');


    //route transaction destroyCart
    Route::delete('/transactions/{cart_id}/destroyCart', [\App\Http\Controllers\Apps\TransactionController::class, 'destroyCart'])->name('transactions.destroyCart');

    //route transaction store
    Route::post('/transactions/store', [\App\Http\Controllers\Apps\TransactionController::class, 'store'])->name('transactions.store');
    Route::get('/transactions/{invoice}/print', [\App\Http\Controllers\Apps\TransactionController::class, 'print'])->name('transactions.print');


    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get('/dashboard/reports/sales', [ReportController::class, 'salesReport'])
        ->name('reports.sales');
    Route::put('/transaction/{id}/mark-as-paid', [ReportController::class, 'markAsPaid'])
        ->name('transactions.markAsPaid');
    Route::get('/dashboard/reports/sales/pdf', [ReportController::class, 'exportPdf'])
        ->name('reports.sales.pdf');
    Route::get('/dashboard/reports/expenses', [ReportController::class, 'expenses'])->name('reports.expenses');
    Route::post('/expenses', [ExpenseController::class, 'store'])->name('expenses.store');
    Route::put('/expenses/{id}', [ExpenseController::class, 'update'])->name('expenses.update');
    Route::get('/dashboard/reports/expenses/pdf', [ReportController::class, 'exportPdfE'])->name('reports.expenses.pdf');
});

require __DIR__ . '/auth.php';
