<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'koneksi.php';

$error = '';
$siswa = null;
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($id <= 0) {
    die('❌ ID tidak valid!');
}

try {
    $stmt = $pdo->prepare("SELECT * FROM siswa WHERE id = ?");
    $stmt->execute([$id]);
    $siswa = $stmt->fetch();
    
    // Jika data tidak ditemukan
    if (!$siswa) {
        die('❌ Data siswa dengan ID ' . $id . ' tidak ditemukan!');
    }
} catch (PDOException $e) {
    die('❌ Gagal mengambil data: ' . $e->getMessage());
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = trim($_POST['nama'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $kelas = trim($_POST['kelas'] ?? '');
    
    $errors = [];
    
    if (empty($nama)) {
        $errors[] = 'Nama wajib diisi';
    } elseif (strlen($nama) < 3) {
        $errors[] = 'Nama minimal 3 karakter';
    }
    
    if (empty($email)) {
        $errors[] = 'Email wajib diisi';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Format email tidak valid';
    }
    
    if (empty($kelas)) {
        $errors[] = 'Kelas wajib diisi';
    }
    
    
    if (empty($errors)) {
        try {
    
            $stmt = $pdo->prepare("SELECT id FROM siswa WHERE email = ? AND id != ?");
            $stmt->execute([$email, $id]);
            
            if ($stmt->fetch()) {
                $errors[] = 'Email sudah digunakan oleh siswa lain!';
            } else {
                
                $stmt = $pdo->prepare("UPDATE siswa SET nama = ?, email = ?, kelas = ? WHERE id = ?");
                $stmt->execute([$nama, $email, $kelas, $id]);
                
            
                header('Location: daftar-siswa.php?updated=1');
                exit;
            }
        } catch (PDOException $e) {
            $errors[] = 'Gagal update data: ' . $e->getMessage();
        }
    }
    
    if (!empty($errors)) {
        $error = implode('<br>', $errors);
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Siswa</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            padding: 40px 20px;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        h1 {
            color: #1a237e;
            font-size: 28px;
            margin-bottom: 8px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
            font-size: 14px;
        }
        
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
        }
        
        input:focus {
            border-color: #1a237e;
            outline: none;
        }
        
        input:disabled {
            background: #f5f5f5;
            color: #999;
        }
        
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        
        .btn-update {
            background: #1a237e;
            color: white;
            padding: 12px 32px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .btn-update:hover {
            background: #0d1445;
        }
        
        .btn-batal {
            background: #e0e0e0;
            color: #333;
            padding: 12px 32px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn-batal:hover {
            background: #c0c0c0;
        }
        
        .alert {
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .alert-error {
            background: #ffebee;
            color: #c62828;
            border-left: 4px solid #f44336;
        }
        
        .required {
            color: #f44336;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #1a237e;
            text-decoration: none;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .info-id {
            background: #e8eaf6;
            color: #1a237e;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 13px;
            display: inline-block;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>✏️ Edit Siswa</h1>
    <p class="subtitle">Perbarui data siswa yang sudah terdaftar</p>
    
    <div class="info-id">
        🆔 ID: #<?= $siswa['id'] ?> | <?= htmlspecialchars($siswa['nama']) ?>
    </div>
    
    <!-- Tampilkan error jika ada -->
    <?php if ($error): ?>
        <div class="alert alert-error">
            <strong>⚠️ Error:</strong><br>
            <?= $error ?>
        </div>
    <?php endif; ?>
    
    
    <form method="POST">
        <div class="form-group">
            <label>Nama Lengkap <span class="required">*</span></label>
            <input type="text" name="nama" 
                   value="<?= htmlspecialchars($siswa['nama']) ?>" 
                   placeholder="Masukkan nama lengkap" required>
        </div>
        
        <div class="form-group">
            <label>Email <span class="required">*</span></label>
            <input type="email" name="email" 
                   value="<?= htmlspecialchars($siswa['email']) ?>" 
                   placeholder="Masukkan alamat email" required>
        </div>
        
        <div class="form-group">
            <label>Kelas <span class="required">*</span></label>
            <input type="text" name="kelas" 
                   value="<?= htmlspecialchars($siswa['kelas']) ?>" 
                   placeholder="Contoh: XII RPL 1" required>
        </div>
        
        <div class="btn-group">
            <button type="submit" class="btn-update">💾 Update</button>
            <a href="daftar-siswa.php" class="btn-batal">✖ Batal</a>
        </div>
    </form>
    
    <a href="daftar-siswa.php" class="back-link">← Kembali ke Daftar Siswa</a>
</div>

</body>
</html>