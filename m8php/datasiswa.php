<?php
$siswa = [
    ["nama" => "Nila Rahmatan", "kelas" => "XII RPL 1", "nilai" => 85, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Budi Santoso", "kelas" => "XII RPL 1", "nilai" => 90, "jenis_kelamin" => "Laki-laki"],
    ["nama" => "Ani Wijaya", "kelas" => "XII RPL 2", "nilai" => 78, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Dedi Kurniawan", "kelas" => "XII RPL 2", "nilai" => 88, "jenis_kelamin" => "Laki-laki"],
    ["nama" => "Eka Putri", "kelas" => "XII RPL 1", "nilai" => 92, "jenis_kelamin" => "Perempuan"]
];

$total_nilai = 0;
$nilai_tertinggi = $siswa[0];
$nilai_terendah = $siswa[0];
$jumlah_lulus = 0;

foreach ($siswa as $s) {
    $total_nilai += $s['nilai'];
    
    if ($s['nilai'] > $nilai_tertinggi['nilai']) {
        $nilai_tertinggi = $s;
    }
    
    if ($s['nilai'] < $nilai_terendah['nilai']) {
        $nilai_terendah = $s;
    }
    
    if ($s['nilai'] >= 75) {
        $jumlah_lulus++;
    }
}

$rata_rata = $total_nilai / count($siswa);
$jumlah_siswa = count($siswa);
$jumlah_tidak_lulus = $jumlah_siswa - $jumlah_lulus;
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Data Siswa - XII RPL</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background: #f0f4f8;
        }
        .container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #2c3e50;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin: 20px 0;
        }
        .stat-box {
            background: #ecf0f1;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-box .number {
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
        }
        .stat-box .label {
            font-size: 14px;
            color: #7f8c8d;
            margin-top: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background: #2c3e50;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .lulus { color: green; font-weight: bold; }
        .tidak-lulus { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Data Siswa XII RPL</h1>
        <p style="text-align: center; color: #7f8c8d;">SMK Negeri 1 Jakarta - Tahun 2026</p>

        <!-- STATISTIK -->
        <div class="stats">
            <div class="stat-box">
                <div class="number"><?= $jumlah_siswa ?></div>
                <div class="label">Jumlah Siswa</div>
            </div>
            <div class="stat-box">
                <div class="number"><?= number_format($rata_rata, 2) ?></div>
                <div class="label">Rata-rata Nilai</div>
            </div>
            <div class="stat-box">
                <div class="number" style="color: green;"><?= $jumlah_lulus ?></div>
                <div class="label">✅ Lulus</div>
            </div>
            <div class="stat-box">
                <div class="number" style="color: red;"><?= $jumlah_tidak_lulus ?></div>
                <div class="label">❌ Tidak Lulus</div>
            </div>
        </div>

        <!-- TABEL SISWA -->
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Nama</th>
                    <th>Kelas</th>
                    <th>Jenis Kelamin</th>
                    <th>Nilai</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <?php $no = 1; foreach ($siswa as $s): ?>
                    <tr>
                        <td><?= $no++ ?></td>
                        <td><?= $s['nama'] ?></td>
                        <td><?= $s['kelas'] ?></td>
                        <td><?= $s['jenis_kelamin'] ?></td>
                        <td><?= $s['nilai'] ?></td>
                        <td class="<?= $s['nilai'] >= 75 ? 'lulus' : 'tidak-lulus' ?>">
                            <?= $s['nilai'] >= 75 ? '✅ Lulus' : '❌ Tidak Lulus' ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>

        <!-- INFORMASI TAMBAHAN -->
        <div style="margin-top: 20px; padding: 15px; background: #eaf2f8; border-radius: 8px;">
            <h3>🏆 Informasi Tambahan</h3>
            <p><strong>Nilai Tertinggi:</strong> <?= $nilai_tertinggi['nama'] ?> (<?= $nilai_tertinggi['nilai'] ?>)</p>
            <p><strong>Nilai Terendah:</strong> <?= $nilai_terendah['nama'] ?> (<?= $nilai_terendah['nilai'] ?>)</p>
        </div>

        <p style="text-align: center; color: #7f8c8d; margin-top: 20px; font-size: 14px;">
            Data diperbarui: <?= date('d F Y H:i:s') ?>
        </p>
    </div>
</body>
</html>