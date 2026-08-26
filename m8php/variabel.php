<?php
echo "<h1>Belajar Variabel PHP</h1>";

// ===== 1. STRING =====
$nama = "Nila Rahmatan";
echo "<p><strong>Nama:</strong> $nama</p>";

// ===== 2. INTEGER (Angka Bulat) =====
$umur = 18;
echo "<p><strong>Umur:</strong> $umur tahun</p>";

// ===== 3. FLOAT (Angka Desimal) =====
$tinggi = 147;
echo "<p><strong>Tinggi:</strong> $tinggi cm</p>";

// ===== 4. BOOLEAN (Benar/Salah) =====
$status_aktif = true;
echo "<p><strong>Status:</strong> " . ($status_aktif ? 'Aktif' : 'Tidak Aktif') . "</p>";

// ===== 5. MENGGABUNGKAN STRING =====
$sekolah = "SMK Negeri 1 Kertosono";
$kalimat = "Saya " . $nama . ", siswa kelas XII RPL di " . $sekolah;
echo "<p>$kalimat</p>";

// ===== 6. MENAMPILKAN TIPE DATA =====
echo "<h2>Debugging Tipe Data</h2>";
echo "<pre>";
var_dump($nama);
var_dump($umur);
var_dump($tinggi);
var_dump($status_aktif);
echo "</pre>";
?>