import React from 'react';
import { Head, router } from '@inertiajs/react';
import DashboardLayout from '@/Layouts/DashboardLayout';
import Table from '@/Components/Dashboard/Table';
import InputSelect from '@/Components/Dashboard/InputSelect';
import { useState } from 'react';

export default function SalesReport({ details, filter, start_date, end_date, status, jenis_customer }) {
    const filters = [
        { label: 'Harian', value: 'today' },
        { label: 'Mingguan', value: 'week' },
        { label: 'Bulanan', value: 'month' },
        { label: 'Tahunan', value: 'year' },
    ];

    const [startDate, setStartDate] = useState(start_date || '');
    const [endDate, setEndDate] = useState(end_date || '');
    const [statusFilter, setStatusFilter] = useState(status || '');
    const [customerType, setCustomerType] = useState(jenis_customer || '');

    const applyFilter = () => {
        router.get(route('reports.sales'), {
            filter,
            start_date: startDate,
            end_date: endDate,
            status: statusFilter,
            is_anggota: customerType,
        });
    };
    const changeFilter = (val) => {
        router.get(route('reports.sales'), {
            filter: val,
            start_date: startDate,
            end_date: endDate,
            status: statusFilter,
            is_anggota: customerType,
        });
    };


    const formatPrice = (price) =>
        price.toLocaleString('id-ID', { style: 'currency', currency: 'IDR' });
    const totalPendapatan = details.reduce((total, item) => {
        return total + (item.price * item.qty);
    }, 0);
    const totalQty = details.reduce((sum, item) => sum + item.qty, 0);

    return (
        <>
            <Head title="Laporan Penjualan" />
            <div className="flex justify-between items-center mb-4">
                <h1 className="text-2xl font-bold text-black">Laporan Penjualan</h1>
                <InputSelect
                    data={filters}
                    selected={filters.find(f => f.value === filter)}
                    setSelected={(val) => changeFilter(val.value)}
                    displayKey="label"
                />
            </div>
            <div className="flex flex-wrap items-end gap-4 mb-6">
                <div>
                    <label className="block text-sm text-black mb-1">Dari Tanggal</label>
                    <input type="date" value={startDate} onChange={(e) => setStartDate(e.target.value)} className="border p-2 rounded w-full bg-white dark:bg-gray-900 text-black dark:text-white" />
                </div>
                <div>
                    <label className="block text-sm text-black mb-1">Sampai Tanggal</label>
                    <input type="date"
                        value={endDate}
                        onChange={(e) => setEndDate(e.target.value)}
                        className="border p-2 rounded w-full bg-white dark:bg-gray-900 text-black dark:text-white"
                    />
                </div>
                <div>
                    <label className="block text-sm text-black mb-1">Status</label>
                    <select
                        value={statusFilter}
                        onChange={(e) => setStatusFilter(e.target.value)}
                        className="border p-2 rounded w-full bg-white dark:bg-gray-900 text-black dark:text-white"
                    >
                        <option value="">Semua</option>
                        <option value="lunas">Lunas</option>
                        <option value="belum lunas">Belum Lunas</option>
                    </select>
                </div>
                <div>
                    <label className="block text-sm text-black mb-1">Jenis Customer</label>
                    <select
                        value={customerType}
                        onChange={(e) => setCustomerType(e.target.value)}
                        className="border p-2 rounded w-full bg-white dark:bg-gray-900 text-black dark:text-white"
                    >
                        <option value="">Semua</option>
                        <option value="0">Tamu</option>
                        <option value="1">Anggota</option>
                        <option value="2">Pegawai</option>
                    </select>
                </div>
                <div>
                    <button
                        onClick={applyFilter}
                        className="mt-6 px-4 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700">
                        Terapkan
                    </button>
                </div>
            </div>

            <Table>
                <Table.Thead>
                    <tr>
                        <Table.Th>No</Table.Th>
                        {(customerType === '2' || statusFilter === 'belum lunas') && <Table.Th>Nama</Table.Th>}
                        <Table.Th>Produk</Table.Th>
                        <Table.Th>Qty</Table.Th>
                        <Table.Th>Harga</Table.Th>
                        <Table.Th>Total</Table.Th>
                        <Table.Th>Status Pembayaran</Table.Th>
                        <Table.Th>Tanggal</Table.Th>
                    </tr>
                </Table.Thead>

                <Table.Tbody>
                    {details.map((item, index) => (
                        <tr key={item.id}>
                            <Table.Td>{index + 1}</Table.Td>
                            {(customerType === '2' || (customerType === '1' && statusFilter === 'belum lunas')) && (
                                <Table.Td>{item.transaction.customer?.name || '-'}</Table.Td>
                            )}
                            <Table.Td>{item.product.title}</Table.Td>
                            <Table.Td>{item.qty}</Table.Td>
                            <Table.Td>{formatPrice(item.price)}</Table.Td>
                            <Table.Td>{formatPrice(item.price * item.qty)}</Table.Td>
                            <Table.Td>{item.transaction.paid_status}</Table.Td>
                            <Table.Td>
                                {new Date(item.created_at).toLocaleString('id-ID', {
                                    dateStyle: 'short',
                                    timeStyle: 'short',
                                })}
                            </Table.Td>
                        </tr>
                    ))}
                </Table.Tbody>

                <Table.Tfoot>
                    <tr>
                        <Table.Td colSpan={6}></Table.Td>
                        <Table.Td className="text-right font-semibold">Total</Table.Td>
                        <Table.Td className="font-bold text-green-600">{formatPrice(totalPendapatan)}</Table.Td>
                    </tr>
                </Table.Tfoot>
            </Table>

        </>
    );
}

SalesReport.layout = page => <DashboardLayout children={page} />;
