<?php
function hitungRataRata($data) {
    $total = 0;
    foreach ($data as $siswa) {
        $total += $siswa['nilai'];
    }
    return $total / count($data);
}

function cariNilaiTertinggi($data) {
    $tertinggi = $data[0];
    foreach ($data as $siswa) {
        if ($siswa['nilai'] > $tertinggi['nilai']) {
            $tertinggi = $siswa;
        }
    }
    return $tertinggi;
}

function cariNilaiTerendah($data) {
    $terendah = $data[0];
    foreach ($data as $siswa) {
        if ($siswa['nilai'] < $terendah['nilai']) {
            $terendah = $siswa;
        }
    }
    return $terendah;
}

function tentukanStatus($nilai) {
    return $nilai >= 75 ? 'Lulus' : 'Tidak Lulus';
}

function getGrade($nilai) {
    if ($nilai >= 90) return 'A';
    if ($nilai >= 80) return 'B';
    if ($nilai >= 70) return 'C';
    if ($nilai >= 60) return 'D';
    return 'E';
}

function getWarnaGrade($grade) {
    $warna = [
        'A' => '#27ae60',
        'B' => '#2ecc71',
        'C' => '#f39c12',
        'D' => '#e67e22',
        'E' => '#e74c3c'
    ];
    return $warna[$grade] ?? '#333';
}

function hitungLulus($data) {
    $lulus = 0;
    foreach ($data as $siswa) {
        if ($siswa['nilai'] >= 75) {
            $lulus++;
        }
    }
    return $lulus;
}

function hitungTidakLulus($data) {
    return count($data) - hitungLulus($data);
}
?>