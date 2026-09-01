<?php

$errors = [];
$data = [];
$daftar_pendaftar = [];

$file_data = 'data_pendaftar.json';

if (file_exists($file_data)) {
    $json_content = file_get_contents($file_data);
    $daftar_pendaftar = json_decode($json_content, true);
    if (!is_array($daftar_pendaftar)) {
        $daftar_pendaftar = [];
    }
}

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
        $errors['nama'] = 'Nama hanya boleh huruf';
    }
    
    if (empty($email)) {
        $errors['email'] = 'Email wajib diisi';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Email tidak valid';
    }
    
    if (empty($umur)) {
        $errors['umur'] = 'Umur wajib diisi';
    } elseif (!is_numeric($umur) || $umur < 1 || $umur > 100) {
        $errors['umur'] = 'Umur harus 1-100';
    }
    
    if (empty($kelas)) {
        $errors['kelas'] = 'Kelas wajib diisi';
    }
    
    if (empty($errors)) {
        $data_baru = [
            'nama' => $nama,
            'email' => $email,
            'umur' => $umur,
            'kelas' => $kelas,
            'waktu_daftar' => date('Y-m-d H:i:s')
        ];
        
        $daftar_pendaftar[] = $data_baru;
        
        $json_data = json_encode($daftar_pendaftar, JSON_PRETTY_PRINT);
        file_put_contents($file_data, $json_data);
        
        $data = $data_baru;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Pendaftaran - Simpan ke File</title>
    <style>
        body { font-family: Arial; max-width: 900px; margin: 20px auto; padding: 20px; }
        .form-group { margin: 15px 0; }
        label { display: block; font-weight: bold; }
        input { padding: 8px; width: 100%; box-sizing: border-box; border: 1px solid #ddd; border-radius: 4px; }
        .error-text { color: red; font-size: 14px; }
        button { padding: 10px 30px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .success { background: #d4edda; padding: 15px; border-radius: 4px; margin: 20px 0; }
        .error-summary { background: #f8d7da; padding: 15px; border-radius: 4px; margin: 10px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background: #4CAF50; color: white; }
        tr:hover { background: #f5f5f5; }
    </style>
</head>
<body>
    <h1>📋 Form Pendaftaran (Simpan ke File)</h1>
    
    <?php if (!empty($errors)): ?>
        <div class="error-summary">
            <strong>❌ Ada kesalahan:</strong>
            <ul>
                <?php foreach ($errors as $message): ?>
                    <li><?php echo $message; ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endif; ?>
    
    <?php if (!empty($data)): ?>
        <div class="success">
            <strong>✅ Pendaftaran berhasil!</strong>
            <p>Data tersimpan di file <code><?php echo $file_data; ?></code></p>
        </div>
    <?php endif; ?>
    
    <form method="POST" action="">
        <div class="form-group">
            <label>Nama Lengkap *</label>
            <input type="text" name="nama" value="<?php echo isset($_POST['nama']) ? htmlspecialchars($_POST['nama']) : ''; ?>">
            <?php if (isset($errors['nama'])): ?>
                <div class="error-text"><?php echo $errors['nama']; ?></div>
            <?php endif; ?>
        </div>
        <div class="form-group">
            <label>Email *</label>
            <input type="email" name="email" value="<?php echo isset($_POST['email']) ? htmlspecialchars($_POST['email']) : ''; ?>">
            <?php if (isset($errors['email'])): ?>
                <div class="error-text"><?php echo $errors['email']; ?></div>
            <?php endif; ?>
        </div>
        <div class="form-group">
            <label>Umur *</label>
            <input type="number" name="umur" value="<?php echo isset($_POST['umur']) ? htmlspecialchars($_POST['umur']) : ''; ?>">
            <?php if (isset($errors['umur'])): ?>
                <div class="error-text"><?php echo $errors['umur']; ?></div>
            <?php endif; ?>
        </div>
        <div class="form-group">
            <label>Kelas *</label>
            <input type="text" name="kelas" value="<?php echo isset($_POST['kelas']) ? htmlspecialchars($_POST['kelas']) : ''; ?>">
            <?php if (isset($errors['kelas'])): ?>
                <div class="error-text"><?php echo $errors['kelas']; ?></div>
            <?php endif; ?>
        </div>
        <button type="submit">Daftar</button>
    </form>
    
    <hr>
    <h2>📊 Daftar Pendaftar (<?php echo count($daftar_pendaftar); ?>)</h2>
    
    <?php if (!empty($daftar_pendaftar)): ?>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nama</th>
                    <th>Email</th>
                    <th>Umur</th>
                    <th>Kelas</th>
                    <th>Waktu Daftar</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($daftar_pendaftar as $index => $p): ?>
                    <tr>
                        <td><?php echo $index + 1; ?></td>
                        <td><?php echo htmlspecialchars($p['nama']); ?></td>
                        <td><?php echo htmlspecialchars($p['email']); ?></td>
                        <td><?php echo htmlspecialchars($p['umur']); ?></td>
                        <td><?php echo htmlspecialchars($p['kelas']); ?></td>
                        <td><?php echo htmlspecialchars($p['waktu_daftar']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>Belum ada pendaftar</p>
    <?php endif; ?>
    
    <hr>
    <div style="background: #fff3cd; padding: 15px; border-radius: 5px;">
        <h3>⚠️ Keterangan