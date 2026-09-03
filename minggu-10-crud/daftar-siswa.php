<?php
require_once 'koneksi.php';

$success = isset($_GET['success']) ? $_GET['success'] : '';
$updated = isset($_GET['updated']) ? $_GET['updated'] : '';
$deleted = isset($_GET['deleted']) ? $_GET['deleted'] : '';
$error = isset($_GET['error']) ? $_GET['error'] : '';

try {
    $stmt = $pdo->query("SELECT * FROM siswa ORDER BY id DESC");
    $siswa = $stmt->fetchAll();
    $total_siswa = count($siswa);
} catch(PDOException $e) {
    die("Error: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Daftar Siswa</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            padding: 40px 20px;
        }
        
        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        h1 { color: #1a237e; font-size: 28px; margin-bottom: 8px; }
        .subtitle { color: #666; margin-bottom: 25px; font-size: 14px; }
        
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .btn-tambah {
            background: #1a237e;
            color: white;
            padding: 10px 24px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
            display: inline-block;
        }
        
        .btn-tambah:hover { background: #0d1445; }
        
        .badge {
            background: #e8eaf6;
            color: #1a237e;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .alert {
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
        }
        
        .alert-error {
            background: #ffebee;
            color: #c62828;
            border-left: 4px solid #f44336;
        }
        
        .alert-info {
            background: #e3f2fd;
            color: #0d47a1;
            border-left: 4px solid #2196f3;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        
        thead {
            background: #f8f9fa;
            border-bottom: 2px solid #e0e0e0;
        }
        
        th {
            text-align: left;
            padding: 14px 12px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        
        td {
            padding: 14px 12px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        
        tr:hover { background: #f8f9fa; }
        
        .aksi-link {
            text-decoration: none;
            padding: 6px 14px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
            display: inline-block;
            margin-right: 4px;
        }
        
        .aksi-edit {
            color: #1565c0;
            background: #e3f2fd;
        }
        
        .aksi-edit:hover { background: #bbdefb; }
        
        .aksi-hapus {
            color: #c62828;
            background: #ffebee;
            border: none;
            cursor: pointer;
        }
        
        .aksi-hapus:hover { background: #ffcdd2; }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .empty-state .icon { font-size: 48px; margin-bottom: 10px; }
        
        .footer-info {
            margin-top: 20px;
            padding-top: 16px;
            border-top: 1px solid #e0e0e0;
            color: #666;
            font-size: 13px;
            text-align: center;
        }
        
        .back-link { color: #1a237e; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
        
        @media (max-width: 768px) {
            .container { padding: 15px; }
            table { font-size: 13px; }
            th, td { padding: 10px 8px; }
            .header-actions { flex-direction: column; align-items: stretch; }
            .btn-tambah { text-align: center; }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>📋 Daftar Siswa</h1>
    <p class="subtitle">Data siswa yang terdaftar di database</p>
    
    <?php if ($success == '1'): ?>
        <div class="alert alert-success">✅ Data siswa berhasil ditambahkan!</div>
    <?php endif; ?>
    
    <?php if ($updated == '1'): ?>
        <div class="alert alert-success">✅ Data siswa berhasil diperbarui!</div>
    <?php endif; ?>
    
    <?php if ($deleted == '1'): ?>
        <div class="alert alert-info">🗑️ Data siswa berhasil dihapus!</div>
    <?php endif; ?>
    
    <?php if ($error): ?>
        <div class="alert alert-error">⚠️ <?= htmlspecialchars($error) ?></div>
    <?php endif; ?>
    
    <div class="header-actions">
        <span class="badge">📊 Total: <?= $total_siswa ?> siswa</span>
        <a href="tambah.php" class="btn-tambah">➕ Tambah Siswa</a>
    </div>
    
    <?php if ($total_siswa > 0): ?>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nama</th>
                    <th>Email</th>
                    <th>Kelas</th>
                    <th>Tanggal Daftar</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                <?php $no = 1; foreach ($siswa as $s): ?>
                <tr>
                    <td><?= $no++ ?></td>
                    <td><strong><?= htmlspecialchars($s['nama']) ?></strong></td>
                    <td><?= htmlspecialchars($s['email']) ?></td>
                    <td>
                        <span style="background:#e8eaf6;padding:2px 12px;border-radius:12px;font-size:12px;">
                            <?= htmlspecialchars($s['kelas']) ?>
                        </span>
                    </td>
                    <td><?= date('d/m/Y H:i', strtotime($s['tgl_daftar'])) ?></td>
                    <td>
                        <a href="edit.php?id=<?= $s['id'] ?>" class="aksi-link aksi-edit"> Edit</a>
                        
                        <form method="POST" action="hapus.php" 
                              style="display:inline-block;" 
                              onsubmit="return confirm('⚠️ Yakin ingin menghapus siswa <?= htmlspecialchars($s['nama']) ?>?')">
                            <input type="hidden" name="id" value="<?= $s['id'] ?>">
                            <button type="submit" class="aksi-link aksi-hapus" style="border:none;cursor:pointer;">
                                 Hapus
                            </button>
                        </form>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <div class="empty-state">
            <div class="icon">📭</div>
            <h3>Belum ada data siswa</h3>
            <p style="color:#999;margin-top:8px;">Klik "Tambah Siswa" untuk menambahkan data pertama</p>
        </div>
    <?php endif; ?>
    
    <div class="footer-info">
        <strong>💡 CRUD Selesai!</strong> 
        Total <?= $total_siswa ?> siswa | 
        <a href="tambah.php" class="back-link">Tambah</a> | 
        <a href="edit.php?id=1" class="back-link">Edit</a> | 
        <a href="hapus.php?id=1" class="back-link">Hapus</a>
    </div>
</div>

</body>
</html>