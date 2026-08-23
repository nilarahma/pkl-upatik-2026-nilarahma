<?php
include 'fungsi.php';

// ===== DATA SISWA (10 siswa) =====
$siswa = [
    ["nama" => "Nila Rahmatan", "kelas" => "XII RPL 1", "nilai" => 85, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Budi Santoso", "kelas" => "XII RPL 1", "nilai" => 90, "jenis_kelamin" => "Laki-laki"],
    ["nama" => "Ani Wijaya", "kelas" => "XII RPL 2", "nilai" => 78, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Dedi Kurniawan", "kelas" => "XII RPL 2", "nilai" => 88, "jenis_kelamin" => "Laki-laki"],
    ["nama" => "Eka Putri", "kelas" => "XII RPL 1", "nilai" => 92, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Fajar Nugroho", "kelas" => "XII RPL 2", "nilai" => 70, "jenis_kelamin" => "Laki-laki"],
    ["nama" => "Gita Permata", "kelas" => "XII RPL 1", "nilai" => 65, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Hadi Saputra", "kelas" => "XII RPL 2", "nilai" => 95, "jenis_kelamin" => "Laki-laki"],
    ["nama" => "Indah Lestari", "kelas" => "XII RPL 1", "nilai" => 82, "jenis_kelamin" => "Perempuan"],
    ["nama" => "Joko Susilo", "kelas" => "XII RPL 2", "nilai" => 55, "jenis_kelamin" => "Laki-laki"]
];

// ===== PANGGIL FUNGSI =====
$rata_rata = hitungRataRata($siswa);
$tertinggi = cariNilaiTertinggi($siswa);
$terendah = cariNilaiTerendah($siswa);
$jumlah_lulus = hitungLulus($siswa);
$jumlah_tidak_lulus = hitungTidakLulus($siswa);
$jumlah_siswa = count($siswa);

// ===== INCLUDE HEADER =====
include 'header.php';
?>

        <!-- ===== JUDUL ===== -->
        <h1 class="header-title">📊 Data Nilai Siswa</h1>
        <p class="header-subtitle">SMK Negeri 1 Jakarta - Tahun Ajaran 2026/2027</p>
        <hr class="header-divider">

        <!-- ===== STATISTIK ===== -->
        <div class="stats">
            <div class="stat-box">
                <div class="number blue"><?= $jumlah_siswa ?></div>
                <div class="label">👥 Jumlah Siswa</div>
            </div>
            <div class="stat-box">
                <div class="number"><?= number_format($rata_rata, 2) ?></div>
                <div class="label">📊 Rata-rata Nilai</div>
            </div>
            <div class="stat-box">
                <div class="number green"><?= $jumlah_lulus ?></div>
                <div class="label">✅ Lulus</div>
            </div>
            <div class="stat-box">
                <div class="number red"><?= $jumlah_tidak_lulus ?></div>
                <div class="label">❌ Tidak Lulus</div>
            </div>
            <div class="stat-box">
                <div class="number orange"><?= $tertinggi['nilai'] ?></div>
                <div class="label">🏆 Nilai Tertinggi</div>
            </div>
            <div class="stat-box">
                <div class="number red"><?= $terendah['nilai'] ?></div>
                <div class="label">📉 Nilai Terendah</div>
            </div>
        </div>

        <!-- ===== TABEL SISWA ===== -->
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Nama</th>
                        <th>Kelas</th>
                        <th>Jenis Kelamin</th>
                        <th>Nilai</th>
                        <th>Grade</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $no = 1; foreach ($siswa as $s): 
                        $grade = getGrade($s['nilai']);
                        $warnaGrade = getWarnaGrade($grade);
                        $status = tentukanStatus($s['nilai']);
                        $classStatus = $status == 'Lulus' ? 'status-lulus' : 'status-tidak-lulus';
                    ?>
                        <tr>
                            <td><?= $no++ ?></td>
                            <td><strong><?= $s['nama'] ?></strong></td>
                            <td><?= $s['kelas'] ?></td>
                            <td><?= $s['jenis_kelamin'] ?></td>
                            <td><?= $s['nilai'] ?></td>
                            <td>
                                <span class="grade grade-<?= $grade ?>" style="background: <?= $warnaGrade ?>;">
                                    <?= $grade ?>
                                </span>
                            </td>
                            <td class="<?= $classStatus ?>">
                                <?= $status == 'Lulus' ? '✅ Lulus' : '❌ Tidak Lulus' ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <!-- ===== INFO TAMBAHAN ===== -->
        <div style="margin-top: 25px; padding: 20px; background: #eaf2f8; border-radius: 10px; border-left: 4px solid #667eea;">
            <h3 style="color: #2c3e50;">🏆 Informasi Tambahan</h3>
            <p><strong>Nilai Tertinggi:</strong> <?= $tertinggi['nama'] ?> (<?= $tertinggi['nilai'] ?>)</p>
            <p><strong>Nilai Terendah:</strong> <?= $terendah['nama'] ?> (<?= $terendah['nilai'] ?>)</p>
            <p><strong>Jumlah Siswa Lulus:</strong> <?= $jumlah_lulus ?> siswa</p>
            <p><strong>Jumlah Siswa Tidak Lulus:</strong> <?= $jumlah_tidak_lulus ?> siswa</p>
            <p><strong>Rata-rata Kelas:</strong> <?= number_format($rata_rata, 2) ?></p>
        </div>

<?php
// ===== INCLUDE FOOTER =====
include 'footer.php';
?>