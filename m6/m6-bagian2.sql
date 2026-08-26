-- Tabelkan setiap anggota beserta jumlah buku yang pernah dipinjam ( bagian 2)
USE perpustakaan;
SELECT 
    a.id_anggota,
    a.nama,
    a.jenis_anggota,
    a.kelas_kode,
    COUNT(p.id_peminjaman) AS jumlah_peminjaman
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama, a.jenis_anggota, a.kelas_kode
ORDER BY a.id_anggota;


-- Tabelkan anggota yang belum pernah meminjam
SELECT 
    a.id_anggota,
    a.nama,
    a.jenis_anggota,
    a.kelas_kode,
    a.alamat,
    a.telepon
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
WHERE p.id_peminjaman IS NULL;

-- Cari anggota jumlah peminjaman diatas rata rata anggota lain
SELECT 
    a.id_anggota,
    a.nama,
    a.jenis_anggota,
    COUNT(p.id_peminjaman) AS total_pinjam
FROM anggota a
JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama, a.jenis_anggota
HAVING total_pinjam > (
    SELECT AVG(jumlah)
    FROM (
        SELECT COUNT(p2.id_peminjaman) AS jumlah
        FROM peminjaman p2
        GROUP BY p2.id_anggota
    ) AS rata_pinjam
);



-- Urutkan anggota dari paling banyak meminjam
SELECT 
    a.id_anggota,
    a.nama,
    a.jenis_anggota,
    COUNT(p.id_peminjaman) AS total_pinjam
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama, a.jenis_anggota
ORDER BY total_pinjam DESC;


-- 1 view untuk laporan tersebut
CREATE VIEW v_laporan_anggota AS
SELECT 
    a.id_anggota,
    a.nama,
    a.jenis_anggota,
    a.kelas_kode,
    a.telepon,
    COUNT(p.id_peminjaman) AS total_peminjaman,
    CASE 
        WHEN COUNT(p.id_peminjaman) = 0 THEN 'Belum Pernah Pinjam'
        WHEN COUNT(p.id_peminjaman) <= 2 THEN 'Rendah'
        WHEN COUNT(p.id_peminjaman) <= 5 THEN 'Sedang'
        ELSE 'Tinggi'
    END AS kategori_peminjam
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama, a.jenis_anggota, a.kelas_kode, a.telepon;



-- Pilih satu kolom yang cocock diberi index lalu bandingkan dengan explain
-- 1. Cek sebelum index
EXPLAIN SELECT * FROM peminjaman WHERE id_anggota = 1;
-- 2. Buat index
CREATE INDEX idx_peminjaman_anggota ON peminjaman(id_anggota);
-- 3. Cek setelah index
EXPLAIN SELECT * FROM peminjaman WHERE id_anggota = 1;
