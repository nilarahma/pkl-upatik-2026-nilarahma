<?php

$nama = $email = $kelas = '';
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = isset($_POST['nama']) ? $_POST['nama'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $kelas = isset($_POST['kelas']) ? $_POST['kelas'] : '';
    
    $cari = isset($_GET['cari']) ? $_GET['cari'] : '';
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Form Dasar - GET vs POST</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input[type="text"], input[type="email"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        button { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #0056b3; }
        .result { margin-top: 20px; padding: 15px; background: #f0f8ff; border-radius: 4px; border-left: 4px solid #007bff; }
        .search-section { margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>📝 Form Pendaftaran (POST)</h1>
    
    <form method="post" action="">
        <div class="form-group">
            <label for="nama">Nama Lengkap:</label>
            <input type="text" id="nama" name="nama" value="<?= htmlspecialchars($nama) ?>" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<?= htmlspecialchars($email) ?>" required>
        </div>
        <div class="form-group">
            <label for="kelas">Kelas:</label>
            <input type="text" id="kelas" name="kelas" value="<?= htmlspecialchars($kelas) ?>" required>
        </div>
        <button type="submit">Daftar</button>
    </form>

    <?php if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($nama)): ?>
    <div class="result">
        <h3>✅ Data Pendaftaran:</h3>
        <p><strong>Nama:</strong> <?= htmlspecialchars($nama) ?></p>
        <p><strong>Email:</strong> <?= htmlspecialchars($email) ?></p>
        <p><strong>Kelas:</strong> <?= htmlspecialchars($kelas) ?></p>
        <p><small>Data dikirim via POST - tidak terlihat di URL</small></p>
    </div>
    <?php endif; ?>

    <div class="search-section">
        <h3>🔍 Pencarian (GET)</h3>
        <form method="get" action="">
            <div class="form-group">
                <input type="text" name="cari" value="<?= htmlspecialchars($cari) ?>" placeholder="Cari data...">
                <button type="submit">Cari</button>
            </div>
        </form>
        <?php if (!empty($cari)): ?>
        <p>Hasil pencarian untuk: <strong><?= htmlspecialchars($cari) ?></strong></p>
        <p><small>Data terlihat di URL: <?= $_SERVER['QUERY_STRING'] ?></small></p>
        <?php endif; ?>
    </div>
</body>
</html>