-- Tampilkan 5 buku yang sering dipinjam (bagian 1)
USE perpustakaan;
SELECT 
    j.id_buku,
    j.judul,
    j.penulis,
    COUNT(p.id_peminjaman) AS total_dipinjam
FROM peminjaman p
JOIN eksemplar e ON p.id_eksemplar = e.id_eksemplar
JOIN judulbuku j ON e.id_buku = j.id_buku
GROUP BY j.id_buku, j.judul, j.penulis
ORDER BY total_dipinjam DESC
LIMIT 5;

-- Tampilkan buku yang belum pernah dipinjam
SELECT 
    j.id_buku,
    j.judul,
    j.penulis,
    j.penerbit
FROM judulbuku j
LEFT JOIN eksemplar e ON j.id_buku = e.id_buku
LEFT JOIN peminjaman p ON e.id_eksemplar = p.id_eksemplar
WHERE p.id_peminjaman IS NULL
GROUP BY j.id_buku, j.judul, j.penulis, j.penerbit;


-- Cari buku peminjaman diatas rata rata
USE perpustakaan;
SELECT 
    j.id_buku,
    j.judul,
    COUNT(p.id_peminjaman) AS total_dipinjam
FROM peminjaman p
JOIN eksemplar e ON p.id_eksemplar = e.id_eksemplar
JOIN judulbuku j ON e.id_buku = j.id_buku
GROUP BY j.id_buku, j.judul
HAVING total_dipinjam > (
    SELECT AVG(jumlah_pinjam)
    FROM (
        SELECT COUNT(p2.id_peminjaman) AS jumlah_pinjam
        FROM peminjaman p2
        JOIN eksemplar e2 ON p2.id_eksemplar = e2.id_eksemplar
        GROUP BY e2.id_buku
    ) AS rata_rata
);

-- 1 view 1 query
USE perpustakaan;

CREATE VIEW v_buku_terpopuler AS
SELECT 
    j.id_buku,
    j.judul,
    j.penulis,
    COUNT(p.id_peminjaman) AS total_dipinjam
FROM peminjaman p
JOIN eksemplar e ON p.id_eksemplar = e.id_eksemplar
JOIN judulbuku j ON e.id_buku = j.id_buku
GROUP BY j.id_buku, j.judul, j.penulis
ORDER BY total_dipinjam DESC
LIMIT 5;

-- Cara menggunakan VIEW
SELECT * FROM v_buku_terpopuler;

-- SOAL 5: Index & EXPLAIN
USE perpustakaan;
CREATE INDEX idx_peminjaman_eksemplar ON peminjaman(id_eksemplar);

EXPLAIN SELECT 
    j.judul,
    COUNT(p.id_peminjaman) 
FROM peminjaman p
JOIN eksemplar e ON p.id_eksemplar = e.id_eksemplar
JOIN judulbuku j ON e.id_buku = j.id_buku
GROUP BY j.id_buku;






DESC judulbuku;
DESC eksemplar;
DESC peminjaman;