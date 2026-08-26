<?php
echo "<h1>Belajar Perulangan</h1>";

// ===== 1. FOR LOOP =====
echo "<h2>1. For Loop</h2>";
echo "<p>Menampilkan angka 1-10: ";
for ($i = 1; $i <= 10; $i++) {
    echo $i . " ";
}
echo "</p>";

echo "<p>Bilangan genap 2-20: ";
for ($i = 2; $i <= 20; $i += 2) {
    echo $i . " ";
}
echo "</p>";

echo "<p>Menghitung mundur 10-1: ";
for ($i = 10; $i >= 1; $i--) {
    echo $i . " ";
}
echo "</p>";

// ===== 2. WHILE LOOP =====
echo "<h2>2. While Loop</h2>";
$i = 1;
echo "<p>1-10 dengan while: ";
while ($i <= 10) {
    echo $i . " ";
    $i++;
}
echo "</p>";

// ===== 3. DO-WHILE LOOP =====
echo "<h2>3. Do-While Loop</h2>";
$i = 1;
echo "<p>1-10 dengan do-while: ";
do {
    echo $i . " ";
    $i++;
} while ($i <= 10);
echo "</p>";

// ===== 4. FOREACH LOOP =====
echo "<h2>4. Foreach Loop (khusus array)</h2>";

// Array sederhana
$buah = ["Apel", "Jeruk", "Mangga", "Pisang", "Durian", "Melon"];

echo "<p>Daftar Buah:</p>";
echo "<ul>";
foreach ($buah as $item) {
    echo "<li>$item</li>";
}
echo "</ul>";

// Dengan index
echo "<p>Daftar Buah (dengan nomor):</p>";
echo "<ul>";
$no = 1;
foreach ($buah as $item) {
    echo "<li>$no. $item</li>";
    $no++;
}
echo "</ul>";
?>