import React from 'react';
import { Head, router } from '@inertiajs/react';
import DashboardLayout from '@/Layouts/DashboardLayout';
import Table from '@/Components/Dashboard/Table';
import InputSelect from '@/Components/Dashboard/InputSelect';

export default function SalesReport({ details, filter }) {
    const filters = [
        { label: 'Harian', value: 'today' },
        { label: 'Mingguan', value: 'week' },
        { label: 'Bulanan', value: 'month' },
        { label: 'Tahunan', value: 'year' },
    ];

    const changeFilter = (val) => {
        router.get(route('reports.sales'), { filter: val });
    };

    const formatPrice = (price) =>
        price.toLocaleString('id-ID', { style: 'currency', currency: 'IDR' });

    return (
        <>
            <Head title="Laporan Penjualan" />
            <div className="flex justify-between items-center mb-4">
                <h1 className="text-2xl font-bold">Laporan Penjualan</h1>
                <InputSelect
                    data={filters}
                    selected={filters.find(f => f.value === filter)}
                    setSelected={(val) => changeFilter(val.value)}
                    displayKey="label"
                />
            </div>

            <Table>
                <Table.Thead>
                    <tr>
                        <Table.Th>No</Table.Th>
                        <Table.Th>Produk</Table.Th>
                        <Table.Th>Qty</Table.Th>
                        <Table.Th>Harga</Table.Th>
                        <Table.Th>Total</Table.Th>
                        <Table.Th>Tanggal</Table.Th>
                    </tr>
                </Table.Thead>
                <Table.Tbody>
  {details.map((item, index) => (
    <tr key={item.id}>
      <Table.Td>{index + 1}</Table.Td>
      <Table.Td>{item.product.title}</Table.Td>
      <Table.Td>{item.qty}</Table.Td>
      <Table.Td>{formatPrice(item.price)}</Table.Td>
      <Table.Td>{formatPrice(item.price * item.qty)}</Table.Td>
      <Table.Td>
        {new Date(item.created_at).toLocaleString('id-ID', {
          dateStyle: 'short',
          timeStyle: 'short',
        })}
      </Table.Td>
    </tr>
  ))}
</Table.Tbody>

            </Table>
        </>
    );
}

SalesReport.layout = page => <DashboardLayout children={page} />;
