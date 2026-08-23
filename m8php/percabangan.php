<?php
echo "<h1>Belajar Percabangan</h1>";

$nilai = 85;

if ($nilai >= 90) {
    $grade = "A (Sangat Baik)";
} elseif ($nilai >= 80) {
    $grade = "B (Baik)";
} elseif ($nilai >= 70) {
    $grade = "C (Cukup)";
} elseif ($nilai >= 60) {
    $grade = "D (Kurang)";
} else {
    $grade = "E (Gagal)";
}

echo "<p>Nilai: $nilai</p>";
echo "<p>Grade: $grade</p>";
?>