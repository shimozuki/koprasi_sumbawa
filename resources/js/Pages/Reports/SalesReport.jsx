import React from 'react';
import { Head, router } from '@inertiajs/react';
import DashboardLayout from '@/Layouts/DashboardLayout';
import Table from '@/Components/Dashboard/Table';
import InputSelect from '@/Components/Dashboard/InputSelect';
import { useState } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { usePage } from '@inertiajs/react'; // pastikan ini diimpor



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
    const [showModal, setShowModal] = useState(false);
    const [selectedId, setSelectedId] = useState(null);
    const [inputCash, setInputCash] = useState(0);
    const { auth } = usePage().props;

    const getSelectedTransaction = () => {
        return details.find(item => item.transaction.id === selectedId);
    };

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

    const openConfirmModal = (id) => {
        const trx = details.find(item => item.transaction.id === id);
        if (trx) {
            setInputCash(trx.transaction.cash || 0);
        }
        setSelectedId(id);
        setShowModal(true);
    };


    const confirmMarkAsPaid = () => {
        if (!selectedId) {
            toast.error('Transaksi tidak ditemukan');
            return;
        }

        toast.dismiss(); // pastikan tidak ada toast tertumpuk sebelumnya

        router.put(route('transactions.markAsPaid', selectedId), {
            cash: inputCash
        }, {
            preserveScroll: true,
            onSuccess: () => {
                setShowModal(false);
                toast.success('Status berhasil diubah menjadi lunas');
                setTimeout(() => {
                    router.reload({ only: ['details'] });
                }, 800);
            },
            onError: (error) => {
                const msg = error?.response?.data?.message || 'Gagal mengubah status';
                toast.error(msg);
            }
        });
    };



    const formatPrice = (price) => {
        const num = typeof price === 'string' ? parseFloat(price) : price;
        return num.toLocaleString('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0,
        });
    };
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
                        <option value="3">Tamu</option>
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
                <button
                    onClick={() => {
                        router.get(route('reports.sales.pdf'), {
                            start_date: startDate,
                            end_date: endDate,
                            status: statusFilter,
                            is_anggota: customerType,
                        }, { preserveScroll: true });
                    }}
                    className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 ml-4"
                >
                    Cetak PDF
                </button>
            </div>

            <Table>
                <Table.Thead>
                    <tr>
                        <Table.Th>No</Table.Th>
                        <Table.Th>Nama Anggota</Table.Th>
                        <Table.Th>Produk</Table.Th>
                        <Table.Th>Qty</Table.Th>
                        <Table.Th>Tanggal</Table.Th>
                        <Table.Th>Status Pembayaran</Table.Th>
                        <Table.Th>Harga</Table.Th>
                        <Table.Th>Total</Table.Th>
                    </tr>
                </Table.Thead>


                <Table.Tbody>
                    {details.map((item, index) => (
                        <tr key={item.id}>
                            <Table.Td>{index + 1}</Table.Td>
                            <Table.Td>{item.transaction.customer?.name || '-'}</Table.Td>
                            <Table.Td>{item.product.title}</Table.Td>
                            <Table.Td>{item.qty}</Table.Td>
                            <Table.Td>
                                {new Date(item.created_at).toLocaleString('id-ID', {
                                    dateStyle: 'short',
                                    timeStyle: 'short',
                                })}
                            </Table.Td>
                            <Table.Td>
                                <button
                                    onClick={() => openConfirmModal(item.transaction.id)}
                                    disabled={item.transaction.paid_status === 'lunas'}
                                    className={`px-2 py-1 rounded text-white text-sm ${item.transaction.paid_status === 'lunas'
                                        ? 'bg-green-500 cursor-not-allowed'
                                        : 'bg-blue-600 hover:bg-blue-700'
                                        }`}
                                >
                                    {item.transaction.paid_status === 'lunas' ? 'Lunas' : 'Belum Lunas'}
                                </button>
                            </Table.Td>
                            <Table.Td>{formatPrice(item.price)}</Table.Td>
                            <Table.Td>{formatPrice(item.price * item.qty)}</Table.Td>

                        </tr>
                    ))}
                </Table.Tbody>

                <Table.Tfoot>
                    <tr>
                        {/* <Table.Td colSpan={6}></Table.Td> */}
                        <Table.Td colSpan={7} className="text-right font-semibold">Total</Table.Td>
                        <Table.Td className="font-bold text-green-600">{formatPrice(totalPendapatan)}</Table.Td>
                        {/* <Table.Td></Table.Td> */}
                    </tr>
                </Table.Tfoot>
            </Table>

            {showModal && (() => {
                const trx = getSelectedTransaction();
                if (!trx) return null;

                const total = trx.transaction.grand_total;
                const change = inputCash - total;

                return (
                    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                        <div className="bg-white p-6 rounded shadow-md w-[90%] max-w-md">
                            <h2 className="text-lg font-bold mb-4 text-gray-800">Konfirmasi</h2>

                            <p className="mb-2 text-gray-700">
                                Total Bayar: <strong>{formatPrice(total)}</strong>
                            </p>

                            <label className="block mb-2 text-gray-700">Uang Pelanggan:</label>
                            <input
                                type="number"
                                value={inputCash}
                                onChange={(e) => setInputCash(parseInt(e.target.value) || 0)}
                                className="w-full p-2 text-black border rounded mb-3"
                            />

                            <p className={`mb-4 ${change < 0 ? 'text-red-600' : 'text-green-600'}`}>
                                {change < 0
                                    ? `Kurang: ${formatPrice(Math.abs(change))}`
                                    : `Kembalian: ${formatPrice(change)}`}
                            </p>

                            <p className="mb-4 text-gray-700">
                                Apakah Anda yakin ingin mengubah status transaksi menjadi <strong>Lunas</strong>?
                            </p>

                            <div className="flex justify-end space-x-2">
                                <button
                                    onClick={() => setShowModal(false)}
                                    className="px-4 py-2 bg-gray-300 text-gray-800 rounded hover:bg-gray-400"
                                >
                                    Batal
                                </button>
                                <button
                                    onClick={confirmMarkAsPaid}
                                    className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
                                >
                                    Ya, Ubah
                                </button>
                            </div>
                        </div>
                    </div>
                );
            })()}



        </>
    );
}

SalesReport.layout = page => <DashboardLayout children={page} />;
