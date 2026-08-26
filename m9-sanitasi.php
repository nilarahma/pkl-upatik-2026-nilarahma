<?php

$input_rentan = '';
$input_aman = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['input_rentan'])) {
        $input_rentan = $_POST['input_rentan'];
    }
    
    if (isset($_POST['input_aman'])) {
        $input_aman = $_POST['input_aman'];
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Demo XSS - Sanitasi Output</title>
    <style>
        body { font-family: Arial; max-width: 800px; margin: 20px auto; padding: 20px; }
        .box { padding: 15px; margin: 15px 0; border-radius: 5px; }
        .danger { background: #f8d7da; border: 2px solid #dc3545; }
        .safe { background: #d4edda; border: 2px solid #28a745; }
        .warning { background: #fff3cd; border: 2px solid #ffc107; }
        input[type="text"] { width: 100%; padding: 10px; margin: 5px 0; box-sizing: border-box; }
        button { padding: 10px 20px; margin: 5px; cursor: pointer; }
        .btn-danger { background: #dc3545; color: white; border: none; }
        .btn-safe { background: #28a745; color: white; border: none; }
        .output-box { background: white; padding: 10px; border: 1px solid #ddd; min-height: 30px; }
        code { background: #f4f4f4; padding: 2px 5px; }
    </style>
</head>
<body>
    <h1>⚠️ Demo XSS (Cross-Site Scripting)</h1>
    
    <div class="box warning">
        <h3>🧪 Cobain input ini:</h3>
        <ul>
            <li><code>&lt;b&gt;tebal&lt;/b&gt;</code> → jadi tebal di versi rentan</li>
            <li><code>&lt;script&gt;alert('XSS')&lt;/script&gt;</code> → muncul popup di versi rentan</li>
            <li><code>&lt;img src=x onerror=alert('Hack!')&gt;</code> → muncul popup</li>
        </ul>
    </div>
    
    <div class="box danger">
        <h3>❌ VERSI RENTAN (Tanpa Sanitasi)</h3>
        <form method="POST" action="">
            <input type="text" name="input_rentan" placeholder="Ketik sesuatu... (rentan XSS)">
            <button type="submit" class="btn-danger">Kirim (Rentan)</button>
        </form>
        
        <?php if (!empty($input_rentan)): ?>
            <div style="margin-top: 10px;">
                <strong>Output (RENTAN):</strong>
                <div class="output-box" style="border-color: red;">
                    <?php echo $input_rentan; // <-- INI BERBAHAYA! ?>
                </div>
                <small style="color: red;">⚠️ Input langsung ditampilkan → bisa mengeksekusi kode!</small>
            </div>
        <?php endif; ?>
    </div>
    
    <div class="box safe">
        <h3>✅ VERSI AMAN (Pakai htmlspecialchars)</h3>
        <form method="POST" action="">
            <input type="text" name="input_aman" placeholder="Ketik sesuatu... (aman XSS)">
            <button type="submit" class="btn-safe">Kirim (Aman)</button>
        </form>
        
        <?php if (!empty($input_aman)): ?>
            <div style="margin-top: 10px;">
                <strong>Output (AMAN):</strong>
                <div class="output-box" style="border-color: green;">
                    <?php echo htmlspecialchars($input_aman, ENT_QUOTES, 'UTF-8'); ?>
                </div>
                <small style="color: green;">✅ htmlspecialchars mengubah &lt; menjadi &amp;lt; → aman!</small>
            </div>
        <?php endif; ?>
    </div>
    
    <hr>
    <h3>📖 ATURAN SEUMUR HIDUP:</h3>
    <div style="background: #e7f3ff; padding: 15px; border-radius: 5px; font-size: 18px;">
        <strong>🔒 VALIDASI saat menerima input</strong><br>
        <strong>🧹 SANITASI saat menampilkan output</strong>
    </div>
</body>
</html>