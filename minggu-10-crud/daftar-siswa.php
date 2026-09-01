<?php
require_once 'koneksi.php';

$success = isset($_GET['success']) ? $_GET['success'] : '';
$updated = isset($_GET['updated']) ? $_GET['updated'] : '';
$deleted = isset($_GET['deleted']) ? $_GET['deleted'] : '';
$error = isset($_GET['error']) ? $_GET['error'] : '';

try {
    $stmt = $pdo->query("SELECT * FROM siswa ORDER BY id DESC");
    $siswa = $stmt->fetchAll();
} catch(PDOException $e) {
    die("Error: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Daftar Siswa</title>
    <style>
        .alert {
            padding: 12px 18px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
    </style>
</head>
<body>
    <h1>Daftar Siswa</h1>
    <a href="tambah.php">Tambah Siswa</a>
    
    <?php if ($success == '1'): ?>
        <div class="alert alert-success">
            ✅ Data siswa berhasil ditambahkan!
        </div>
    <?php endif; ?>
    
    <?php if ($updated == '1'): ?>
        <div class="alert alert-success">
            ✅ Data siswa berhasil diperbarui!
        </div>
    <?php endif; ?>
    
    <?php if ($deleted == '1'): ?>
        <div class="alert alert-info">
            🗑️ Data siswa berhasil dihapus!
        </div>
    <?php endif; ?>
    
    <?php if ($error): ?>
        <div class="alert alert-danger">
            ⚠️ Terjadi kesalahan: <?= htmlspecialchars($error) ?>
        </div>
    <?php endif; ?>    
    <table border="1" cellpadding="10">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nama</th>
                <th>Email</th>
                <th>Kelas</th>
                <th>Tanggal Daftar</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($siswa as $s): ?>
            <tr>
                <td><?= htmlspecialchars($s['id']) ?></td>
                <td><?= htmlspecialchars($s['nama']) ?></td>
                <td><?= htmlspecialchars($s['email']) ?></td>
                <td><?= htmlspecialchars($s['kelas']) ?></td>
                <td><?= htmlspecialchars($s['tgl_daftar']) ?></td>
                <td>
                    <a href="edit.php?id=<?= $s['id'] ?>">Edit</a>
                    <a href="hapus.php?id=<?= $s['id'] ?>" onclick="return confirm('Yakin hapus?')">Hapus</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>