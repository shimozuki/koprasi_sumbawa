import Card from '@/Components/Dashboard/Card';
import Table from '@/Components/Dashboard/Table';
import TransactionCharts from '@/Components/Dashboard/TransactionCharts';
import Widget from '@/Components/Dashboard/Widget';
import DashboardLayout from '@/Layouts/DashboardLayout';
import { Head, usePage } from '@inertiajs/react';
import { IconBox, IconCategory, IconMoneybag, IconUsers } from '@tabler/icons-react';
import { useEffect } from 'react';
export default function Dashboard({dailyTransactions, monthlyTransactions, yearlyTransactions}) {
    useEffect(()=>{
        console.log(dailyTransactions)
        console.log(monthlyTransactions)
        console.log(yearlyTransactions)
    },[dailyTransactions, monthlyTransactions, yearlyTransactions]);
    return (
        <>
            <Head title='Dashboard' />
            <div className='grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4'>
                <Widget
                    title={'Kategori'}
                    subtitle={'Total Kategori'}
                    color={'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200'}
                    icon={<IconCategory size={'20'} strokeWidth={'1.5'} />}
                    total={20}
                />
                <Widget
                    title={'Produk'}
                    subtitle={'Total Produk'}
                    color={'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200'}
                    icon={<IconBox size={'20'} strokeWidth={'1.5'} />}
                    total={30}
                />
                <Widget
                    title={'Transaksi'}
                    subtitle={'Total Transaksi'}
                    color={'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200'}
                    icon={<IconMoneybag size={'20'} strokeWidth={'1.5'} />}
                    total={45}
                />
                <Widget
                    title={'Pengguna'}
                    subtitle={'Total Pengguna'}
                    color={'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200'}
                    icon={<IconUsers size={'20'} strokeWidth={'1.5'} />}
                    total={2}
                />
            </div>
            <TransactionCharts dailyTransactions={dailyTransactions} monthlyTransactions={monthlyTransactions} yearlyTransactions={yearlyTransactions}></TransactionCharts>
        </>
    );
}

Dashboard.layout = page => <DashboardLayout children={page} />
