<?php

$errors = [];
$data = [];

$nama = $email = $umur = $kelas = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = isset($_POST['nama']) ? $_POST['nama'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $umur = isset($_POST['umur']) ? $_POST['umur'] : '';
    $kelas = isset($_POST['kelas']) ? $_POST['kelas'] : '';
    
    if (empty($nama)) {
        $errors['nama'] = 'Nama wajib diisi';
    } elseif (strlen($nama) < 3) {
        $errors['nama'] = 'Nama minimal 3 karakter';
    } elseif (!preg_match('/^[a-zA-Z\s]+$/', $nama)) {
        $errors['nama'] = 'Nama hanya boleh huruf dan spasi';
    }
    
    if (empty($email)) {
        $errors['email'] = 'Email wajib diisi';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Format email tidak valid (contoh: user@domain.com)';
    }
    
    if (empty($umur)) {
        $errors['umur'] = 'Umur wajib diisi';
    } elseif (!is_numeric($umur)) {
        $errors['umur'] = 'Umur harus berupa angka';
    } elseif ($umur < 1 || $umur > 100) {
        $errors['umur'] = 'Umur harus antara 1 - 100 tahun';
    }
    
    if (empty($kelas)) {
        $errors['kelas'] = 'Kelas wajib diisi';
    }
    
    if (empty($errors)) {
        $data['nama'] = $nama;
        $data['email'] = $email;
        $data['umur'] = $umur;
        $data['kelas'] = $kelas;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Form Validasi - Minggu 9</title>
    <style>
        body { font-family: Arial; max-width: 600px; margin: 20px auto; padding: 20px; }
        .form-group { margin: 15px 0; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input { padding: 8px; width: 100%; box-sizing: border-box; border: 1px solid #ddd; border-radius: 4px; }
        input.error { border-color: red; }
        .error-text { color: red; font-size: 14px; margin-top: 3px; }
        button { padding: 10px 30px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #45a049; }
        .success { background: #d4edda; color: #155724; padding: 15px; border-radius: 4px; margin: 20px 0; }
        .error-summary { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 4px; margin: 10px 0; }
    </style>
</head>
<body>
    <h1>📋 Form Pendaftaran</h1>
    <p><small>Semua field wajib diisi dengan benar</small></p>
    
    <?php if (!empty($errors)): ?>
        <div class="error-summary">
            <strong>❌ Ada kesalahan:</strong>
            <ul>
                <?php foreach ($errors as $field => $message): ?>
                    <li><?php echo $message; ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endif; ?>
    
    <!-- Tampilkan sukses kalau data valid -->
    <?php if (!empty($data) && empty($errors)): ?>
        <div class="success">
            <strong>✅ Pendaftaran berhasil!</strong>
            <p>Data Anda:</p>
            <ul>
                <li>Nama: <?php echo $data['nama']; ?></li>
                <li>Email: <?php echo $data['email']; ?></li>
                <li>Umur: <?php echo $data['umur']; ?></li>
                <li>Kelas: <?php echo $data['kelas']; ?></li>
            </ul>
        </div>
    <?php endif; ?>
    
    <!-- FORM -->
    <form method="POST" action="">
        <div class="form-group">
            <label>Nama Lengkap *</label>
            <input type="text" name="nama" value="<?php echo htmlspecialchars($nama); ?>" 
                   class="<?php echo isset($errors['nama']) ? 'error' : ''; ?>">
            <?php if (isset($errors['nama'])): ?>
                <div class="error-text"><?php echo $errors['nama']; ?></div>
            <?php endif; ?>
        </div>
        
        <div class="form-group">
            <label>Email *</label>
            <input type="email" name="email" value="<?php echo htmlspecialchars($email); ?>"
                   class="<?php echo isset($errors['email']) ? 'error' : ''; ?>">
            <?php if (isset($errors['email'])): ?>
                <div class="error-text"><?php echo $errors['email']; ?></div>
            <?php endif; ?>
        </div>
        
        <div class="form-group">
            <label>Umur (1-100) *</label>
            <input type="number" name="umur" value="<?php echo htmlspecialchars($umur); ?>"
                   class="<?php echo isset($errors['umur']) ? 'error' : ''; ?>">
            <?php if (isset($errors['umur'])): ?>
                <div class="error-text"><?php echo $errors['umur']; ?></div>
            <?php endif; ?>
        </div>
        
        <div class="form-group">
            <label>Kelas *</label>
            <input type="text" name="kelas" value="<?php echo htmlspecialchars($kelas); ?>"
                   class="<?php echo isset($errors['kelas']) ? 'error' : ''; ?>">
            <?php if (isset($errors['kelas'])): ?>
                <div class="error-text"><?php echo $errors['kelas']; ?></div>
            <?php endif; ?>
        </div>
        
        <button type="submit">Daftar</button>
    </form>
    
    <hr>
    <h3>🧪 UJI COBA VALIDASI:</h3>
    <ul>
        <li>Submit kosong → semua field error</li>
        <li>Nama "A" → error minimal 3 karakter</li>
        <li>Email "budi@" → error format email</li>
        <li>Umur "150" → error rentang</li>
        <li>Isi semua benar → sukses 🎉</li>
    </ul>
</body>
</html>