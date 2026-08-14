SELECT COUNT(*) FROM peminjaman;

SELECT id_anggota, COUNT(*) 
FROM peminjaman 
GROUP BY id_anggota;





SELECT COUNT(*) AS total_anggota
FROM anggota;

SELECT COUNT(*) AS total_buku
FROM buku;

SELECT COUNT(*) AS total_peminjaman
FROM peminjaman;

SELECT SUM(total_denda) AS total_denda_keseluruhan
FROM peminjaman;

SELECT AVG(total_denda) AS rata_rata_denda
FROM peminjaman;

SELECT
    MIN(DATEDIFF(tgl_kembali, tgl_pinjam)) AS tercepat,
    MAX(DATEDIFF(tgl_kembali, tgl_pinjam)) AS terlama
FROM peminjaman
WHERE tgl_kembali IS NOT NULL;

SELECT COUNT(*) AS semua_baris FROM peminjaman;

SELECT COUNT(tgl_kembali) AS sudah_kembali FROM peminjaman;

SELECT COUNT(DISTINCT id_anggota) AS anggota_pernah_pinjam 
FROM peminjaman;



SELECT 
    k.nama_kategori,
    COUNT(b.id_buku) AS jumlah_buku
FROM kategori k
LEFT JOIN buku b ON k.id_kategori = b.id_kategori
GROUP BY k.id_kategori, k.nama_kategori
ORDER BY jumlah_buku DESC;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
ORDER BY total_pinjam DESC;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    SUM(p.total_denda) AS total_denda
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
ORDER BY total_denda DESC;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    AVG(DATEDIFF(p.tgl_kembali, p.tgl_pinjam)) AS rata_hari
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
WHERE p.tgl_kembali IS NOT NULL
GROUP BY a.id_anggota, a.nama_anggota
ORDER BY rata_hari;

SELECT 
    status_peminjaman,
    COUNT(*) AS jumlah
FROM peminjaman
GROUP BY status_peminjaman;

SELECT 
    DATE_FORMAT(tgl_pinjam, '%Y-%m') AS bulan,
    COUNT(*) AS total_pinjam
FROM peminjaman
GROUP BY DATE_FORMAT(tgl_pinjam, '%Y-%m')
ORDER BY bulan;

SELECT 
    AVG(total_pinjam) AS rata_pinjam_per_anggota
FROM (
    SELECT 
        id_anggota,
        COUNT(*) AS total_pinjam
    FROM peminjaman
    GROUP BY id_anggota
) AS pinjam_per_anggota;





SELECT 
    a.id_anggota,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
HAVING COUNT(p.id_pinjam) > 1
ORDER BY total_pinjam DESC;

SELECT 
    k.nama_kategori,
    COUNT(b.id_buku) AS jumlah_buku
FROM kategori k
LEFT JOIN buku b ON k.id_kategori = b.id_kategori
GROUP BY k.id_kategori, k.nama_kategori
HAVING COUNT(b.id_buku) > 1
ORDER BY jumlah_buku DESC;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    SUM(p.total_denda) AS total_denda
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
HAVING SUM(p.total_denda) > 0
ORDER BY total_denda DESC;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam,
    SUM(p.total_denda) AS total_denda
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
HAVING COUNT(p.id_pinjam) > 0
   AND SUM(p.total_denda) = 0;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam,
    COUNT(DISTINCT DATE_FORMAT(p.tgl_pinjam, '%Y-%m')) AS bulan_aktif,
    COUNT(p.id_pinjam) / COUNT(DISTINCT DATE_FORMAT(p.tgl_pinjam, '%Y-%m')) AS rata_per_bulan
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
HAVING COUNT(p.id_pinjam) / COUNT(DISTINCT DATE_FORMAT(p.tgl_pinjam, '%Y-%m')) > 1;





SELECT 
    a.id_anggota,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
WHERE YEAR(p.tgl_pinjam) = 2026
GROUP BY a.id_anggota, a.nama_anggota
HAVING COUNT(p.id_pinjam) > 1
ORDER BY total_pinjam DESC;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam,
    SUM(p.total_denda) AS total_denda
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
WHERE YEAR(p.tgl_pinjam) = 2026
GROUP BY a.id_anggota, a.nama_anggota
HAVING SUM(p.total_denda) > 0
ORDER BY total_denda DESC;






SELECT 
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota
ORDER BY total_pinjam DESC
LIMIT 1;

SELECT 
    b.judul_buku,
    COUNT(p.id_pinjam) AS total_pinjam
FROM buku b
INNER JOIN eksemplar e ON b.id_buku = e.id_buku
INNER JOIN peminjaman p ON e.no_reg_eksemplar = p.no_reg_eksemplar
GROUP BY b.id_buku, b.judul_buku
ORDER BY total_pinjam DESC
LIMIT 1;

SELECT 
    b.judul_buku,
    COUNT(p.id_pinjam) AS total_pinjam
FROM buku b
INNER JOIN eksemplar e ON b.id_buku = e.id_buku
INNER JOIN peminjaman p ON e.no_reg_eksemplar = p.no_reg_eksemplar
GROUP BY b.id_buku, b.judul_buku
HAVING COUNT(p.id_pinjam) > (
    SELECT AVG(jumlah_pinjam)
    FROM (
        SELECT COUNT(*) AS jumlah_pinjam
        FROM peminjaman p2
        INNER JOIN eksemplar e2 ON p2.no_reg_eksemplar = e2.no_reg_eksemplar
        GROUP BY e2.id_buku
    ) AS rata_buku
)
ORDER BY total_pinjam DESC;