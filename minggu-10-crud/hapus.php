<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'koneksi.php';

// ==========================================
// 1. CEK METODE POST (LEBIH AMAN)
// ==========================================
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    // Jika bukan POST, redirect ke daftar
    header('Location: daftar-siswa.php?error=Metode tidak diizinkan');
    exit;
}

// ==========================================
// 2. AMBIL DAN VALIDASI ID
// ==========================================
$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;

if ($id <= 0) {
    header('Location: daftar-siswa.php?error=ID tidak valid');
    exit;
}

// ==========================================
// 3. PROSES HAPUS
// ==========================================
try {
    // Cek apakah data dengan ID tersebut ada
    $stmt = $pdo->prepare("SELECT id, nama FROM siswa WHERE id = ?");
    $stmt->execute([$id]);
    $siswa = $stmt->fetch();
    
    // Jika data tidak ditemukan
    if (!$siswa) {
        header('Location: daftar-siswa.php?error=Data tidak ditemukan');
        exit;
    }
    
    // ========== DELETE DENGAN PREPARED STATEMENT ==========
    // ⚠️ PERHATIKAN WHERE nya! DELETE tanpa WHERE = semua data lenyap!
    $stmt = $pdo->prepare("DELETE FROM siswa WHERE id = ?");
    $stmt->execute([$id]);
    
    // ========== PRG PATTERN ==========
    header('Location: daftar-siswa.php?deleted=1');
    exit;
    
} catch (PDOException $e) {
    // Jika error, redirect dengan pesan error
    header('Location: daftar-siswa.php?error=Gagal menghapus data: ' . $e->getMessage());
    exit;
}
?>