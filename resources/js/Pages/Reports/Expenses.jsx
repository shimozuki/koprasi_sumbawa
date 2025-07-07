import React, { useState } from 'react';
import { Head, router, usePage } from '@inertiajs/react';
import DashboardLayout from '@/Layouts/DashboardLayout';
import Table from '@/Components/Dashboard/Table';

export default function Expenses() {
    const { expenses, total, saldo, auth } = usePage().props;
    const role = auth?.user?.role;

    const [startDate, setStartDate] = useState('');
    const [endDate, setEndDate] = useState('');
    const [showModal, setShowModal] = useState(false);

    const [form, setForm] = useState({
        id: null, // tambahkan juga id kalau perlu edit
        tanggal: '',
        kategori: '',
        deskripsi: '', // pastikan ini ada
        jumlah: '',
    });

    const applyFilter = () => {
        router.get(route('reports.expenses'), {
            start_date: startDate,
            end_date: endDate,
        });
    };

    const formatPrice = (value) =>
        Number(value).toLocaleString('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0,
        });

    const handleFormChange = (e) => {
        setForm({ ...form, [e.target.name]: e.target.value });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        if (form.id) {
            router.put(route('expenses.update', form.id), form, {
                onSuccess: () => {
                    setForm({ tanggal: '', kategori: '', deskripsi: '', jumlah: '' });
                    setShowModal(false);
                    router.reload({ only: ['expenses', 'total', 'saldo'] });
                },
            });
        } else {
            router.post(route('expenses.store'), form, {
                onSuccess: () => {
                    setForm({ tanggal: '', kategori: '', deskripsi: '', jumlah: '' });
                    setShowModal(false);
                    router.reload({ only: ['expenses', 'total', 'saldo'] });
                },
            });
        }
    };

    // ⬇️ Pindahkan fungsi ini ke luar handleSubmit
    const openEditModal = (item) => {
        setForm({
            id: item.id,
            tanggal: item.tanggal,
            kategori: item.kategori,
            deskripsi: item.deskripsi ?? '',  // fallback jika null
            jumlah: item.jumlah ?? '',        // fallback jika null
        });
        setShowModal(true);
    };


    return (
        <>
            <Head title="Laporan Pengeluaran" />

            <div className="flex justify-between items-center mb-4">
                <h1 className="text-2xl font-bold text-black">Laporan Pengeluaran</h1>
            </div>

            <div className="flex flex-wrap items-end gap-4 mb-6">
                <div>
                    <label className="block text-sm text-black mb-1">Dari Tanggal</label>
                    <input
                        type="date"
                        value={startDate}
                        onChange={(e) => setStartDate(e.target.value)}
                        className="border p-2 rounded w-full bg-white text-black"
                    />
                </div>

                <div>
                    <label className="block text-sm text-black mb-1">Sampai Tanggal</label>
                    <input
                        type="date"
                        value={endDate}
                        onChange={(e) => setEndDate(e.target.value)}
                        className="border p-2 rounded w-full bg-white text-black"
                    />
                </div>

                <div>
                    <button
                        onClick={applyFilter}
                        className="mt-6 px-4 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700"
                    >
                        Terapkan
                    </button>
                </div>

                <button
                    onClick={() => {
                        router.get(route('reports.expenses.pdf'), {
                            start_date: startDate,
                            end_date: endDate,
                        }, { preserveScroll: true });
                    }}
                    className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 ml-4 mt-6"
                >
                    Cetak Laporan (PDF) {role}
                </button>
            </div>

            <button
                onClick={() => setShowModal(true)}
                className="mb-4 px-4 py-2 bg-emerald-600 text-white rounded hover:bg-emerald-700"
            >
                + Tambah Pengeluaran Manual
            </button>

            <Table>
                <Table.Thead>
                    <tr>
                        <Table.Th>No</Table.Th>
                        <Table.Th>Pengeluaran</Table.Th>
                        <Table.Th>Tanggal</Table.Th>
                        <Table.Th>Total</Table.Th>
                        <Table.Th>Aksi</Table.Th>
                    </tr>
                </Table.Thead>

                <Table.Tbody>
                    {expenses.map((item, index) => (
                        <tr key={index}>
                            <Table.Td>{index + 1}</Table.Td>
                            <Table.Td>{item.kategori}</Table.Td>
                            <Table.Td>
                                {new Date(item.tanggal).toLocaleDateString('id-ID', {
                                    day: '2-digit',
                                    month: '2-digit',
                                    year: '2-digit',
                                })}
                            </Table.Td>
                            <Table.Td className="text-green-700">{formatPrice(item.total)}</Table.Td>
                            <Table.Td>
                                {item.kategori !== 'Pembelian Barang' ? (
                                    <button
                                        className="text-blue-600 hover:underline"
                                        onClick={() => openEditModal(item)}
                                    >
                                        Edit
                                    </button>
                                ) : (
                                    <span className="text-gray-400 italic">-</span>
                                )}
                            </Table.Td>
                        </tr>
                    ))}
                </Table.Tbody>

                <Table.Tfoot>
                    <tr>
                        <Table.Td colSpan={3} className="text-right font-semibold">Total Pengeluaran</Table.Td>
                        <Table.Td className="font-bold text-green-700">{formatPrice(total)}</Table.Td>
                        <Table.Td></Table.Td>
                    </tr>
                    <tr>
                        <Table.Td colSpan={3} className="text-right font-semibold">Saldo</Table.Td>
                        <Table.Td className="font-bold text-blue-700">{formatPrice(saldo)}</Table.Td>
                        <Table.Td></Table.Td>
                    </tr>
                </Table.Tfoot>
            </Table>


            {/* Modal Input Pengeluaran Manual */}
            {showModal && (
                <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                    <div className="bg-white p-6 rounded shadow-md w-[90%] max-w-lg">
                        <h2 className="text-lg font-bold mb-4 text-gray-800">Input Pengeluaran Manual</h2>

                        <form onSubmit={handleSubmit} className="space-y-4">
                            <div>
                                <label className="block mb-1 text-black">Tanggal</label>
                                <input
                                    type="date"
                                    name="tanggal"
                                    value={form.tanggal}
                                    onChange={handleFormChange}
                                    className="w-full border p-2 rounded text-black"
                                    required
                                />
                            </div>
                            <div>
                                <label className="block mb-1 text-black">Kategori</label>
                                <input
                                    type="text"
                                    name="kategori"
                                    value={form.kategori}
                                    onChange={handleFormChange}
                                    className="w-full border p-2 rounded text-black"
                                    required
                                />
                            </div>
                            <div>
                                <label className="block mb-1 text-black">Deskripsi</label>
                                <textarea
                                    name="deskripsi"
                                    value={form.deskripsi}
                                    onChange={handleFormChange}
                                    className="w-full border p-2 rounded text-black"
                                    rows="2"
                                />
                            </div>
                            <div>
                                <label className="block mb-1 text-black">Jumlah</label>
                                <input
                                    type="number"
                                    name="jumlah"
                                    value={form.jumlah}
                                    onChange={handleFormChange}
                                    className="w-full border p-2 rounded text-black"
                                    required
                                />
                            </div>

                            <div className="flex justify-end gap-2">
                                <button
                                    type="button"
                                    onClick={() => setShowModal(false)}
                                    className="px-4 py-2 bg-gray-300 rounded hover:bg-gray-400"
                                >
                                    Batal
                                </button>
                                <button
                                    type="submit"
                                    className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
                                >
                                    Simpan
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </>
    );
}

Expenses.layout = page => <DashboardLayout children={page} />;
