<?php
// ============================================
// HALAMAN TAMBAH SISWA (CREATE)
// ============================================

require_once 'koneksi.php';

$error = '';
$success = '';

// Proses form saat di-submit (POST)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari form
    $nama = trim($_POST['nama'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $kelas = trim($_POST['kelas'] ?? '');
    
    // ========== VALIDASI ==========
    $errors = [];
    
    // Validasi nama
    if (empty($nama)) {
        $errors[] = 'Nama wajib diisi';
    } elseif (strlen($nama) < 3) {
        $errors[] = 'Nama minimal 3 karakter';
    }
    
    // Validasi email
    if (empty($email)) {
        $errors[] = 'Email wajib diisi';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Format email tidak valid';
    }
    
    // Validasi kelas
    if (empty($kelas)) {
        $errors[] = 'Kelas wajib diisi';
    }
    
    // ========== SIMPAN KE DATABASE ==========
    if (empty($errors)) {
        try {
            // Cek email duplikat
            $stmt = $pdo->prepare("SELECT id FROM siswa WHERE email = ?");
            $stmt->execute([$email]);
            
            if ($stmt->fetch()) {
                $errors[] = 'Email sudah terdaftar! Gunakan email lain.';
            } else {
                // ✅ PREPARED STATEMENT UNTUK INSERT
                $stmt = $pdo->prepare("INSERT INTO siswa (nama, email, kelas) VALUES (?, ?, ?)");
                $stmt->execute([$nama, $email, $kelas]);
                
                // ✅ PRG PATTERN (Post-Redirect-Get)
                header('Location: daftar-siswa.php?success=1');
                exit;
            }
        } catch (PDOException $e) {
            $errors[] = 'Gagal menyimpan data: ' . $e->getMessage();
        }
    }
    
    // Jika ada error, tampilkan
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
    <title>Tambah Siswa</title>
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
        
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        
        .btn-simpan {
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
        
        .btn-simpan:hover {
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
        
        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #4caf50;
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
    </style>
</head>
<body>

<div class="container">
    <h1>➕ Tambah Siswa</h1>
    <p class="subtitle">Isi form di bawah untuk menambahkan data siswa baru</p>
    
    <!-- Tampilkan error jika ada -->
    <?php if ($error): ?>
        <div class="alert alert-error">
            <strong>⚠️ Error:</strong><br>
            <?= $error ?>
        </div>
    <?php endif; ?>
    
    <!-- Form Tambah -->
    <form method="POST">
        <div class="form-group">
            <label>Nama Lengkap <span class="required">*</span></label>
            <input type="text" name="nama" 
                   value="<?= htmlspecialchars($_POST['nama'] ?? '') ?>" 
                   placeholder="Masukkan nama lengkap" required>
        </div>
        
        <div class="form-group">
            <label>Email <span class="required">*</span></label>
            <input type="email" name="email" 
                   value="<?= htmlspecialchars($_POST['email'] ?? '') ?>" 
                   placeholder="Masukkan alamat email" required>
        </div>
        
        <div class="form-group">
            <label>Kelas <span class="required">*</span></label>
            <input type="text" name="kelas" 
                   value="<?= htmlspecialchars($_POST['kelas'] ?? '') ?>" 
                   placeholder="Contoh: XII RPL 1" required>
        </div>
        
        <div class="btn-group">
            <button type="submit" class="btn-simpan">💾 Simpan</button>
            <a href="daftar-siswa.php" class="btn-batal">✖ Batal</a>
        </div>
    </form>
    
    <a href="daftar-siswa.php" class="back-link">← Kembali ke Daftar Siswa</a>
</div>

</body>
</html>