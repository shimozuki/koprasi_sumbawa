<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Laporan Pengeluaran</title>
    <style>
        body {
            font-family: sans-serif;
            font-size: 12px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            border: 1px solid #000;
            padding: 6px;
            text-align: left;
        }

        th {
            background-color: #eee;
        }
    </style>
</head>

<body>
    <h2>Laporan Pengeluaran</h2>
    @if($start_date && $end_date)
    <p>Periode: {{ $start_date }} s/d {{ $end_date }}</p>
    @endif

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Kategori</th>
                <th>Jumlah</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($expenses as $index => $item)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ \Carbon\Carbon::parse($item->tanggal)->format('d/m/Y') }}</td>
                <td>{{ $item->kategori }}</td>
                <td>Rp {{ number_format($item->total, 0, ',', '.') }}</td>
            </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr>
                <th colspan="3" style="text-align: right;">Total</th>
                <th>Rp {{ number_format($total, 0, ',', '.') }}</th>
            </tr>
        </tfoot>
    </table>
</body>

</html>