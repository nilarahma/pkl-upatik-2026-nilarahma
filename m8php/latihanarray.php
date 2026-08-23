<?php
echo "<h1>Belajar Array</h1>";
echo "<h2>1. Array Berindeks</h2>";

$buah = ["Apel", "Jeruk", "Mangga", "Pisang"];
echo "<p>Buah pertama: " . $buah[0] . "</p>";
echo "<p>Buah kedua: " . $buah[1] . "</p>";
echo "<p>Buah ketiga: " . $buah[2] . "</p>";
echo "<p>Buah keempat: " . $buah[3] . "</p>";

echo "<p>Semua buah:</p>";
echo "<ul>";
foreach ($buah as $b) {
    echo "<li>$b</li>";
}
echo "</ul>";

$buah[] = "Durian";
array_push($buah, "Rambutan");
echo "<p>Setelah ditambah: " . implode(", ", $buah) . "</p>";

// ===== 2. ARRAY ASOSIATIF =====
echo "<h2>2. Array Asosiatif</h2>";

$siswa = [
    "nama" => "Nila Rahmatan",
    "kelas" => "XII RPL",
    "nis" => "12345",
    "nilai" => 85
];

echo "<p>Nama: " . $siswa["nama"] . "</p>";
echo "<p>Kelas: " . $siswa["kelas"] . "</p>";
echo "<p>NIS: " . $siswa["nis"] . "</p>";
echo "<p>Nilai: " . $siswa["nilai"] . "</p>";

echo "<p>Data lengkap:</p>";
echo "<ul>";
foreach ($siswa as $key => $value) {
    echo "<li><strong>$key</strong>: $value</li>";
}
echo "</ul>";

// ===== 3. ARRAY MULTIDIMENSI =====
echo "<h2>3. Array Multidimensi (Array di dalam Array)</h2>";

$daftar_siswa = [
    [
        "nama" => "Nila Rahmatan",
        "kelas" => "XII RPL",
        "nilai" => 85
    ],
    [
        "nama" => "Budi Santoso",
        "kelas" => "XII RPL",
        "nilai" => 90
    ],
    [
        "nama" => "Ani Wijaya",
        "kelas" => "XII RPL",
        "nilai" => 78
    ]
];

echo "<table border='1' cellpadding='10'>";
echo "<tr><th>No</th><th>Nama</th><th>Kelas</th><th>Nilai</th></tr>";

$no = 1;
foreach ($daftar_siswa as $s) {
    echo "<tr>";
    echo "<td>$no</td>";
    echo "<td>{$s['nama']}</td>";
    echo "<td>{$s['kelas']}</td>";
    echo "<td>{$s['nilai']}</td>";
    echo "</tr>";
    $no++;
}
echo "</table>";
?>