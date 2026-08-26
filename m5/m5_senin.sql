SELECT a.nama_anggota, p.nama_peran, p.maks_pinjam
FROM anggota a
INNER JOIN peran_anggota p ON a.id_peran = p.id_peran;


SELECT b.judul_buku, k.nama_kategori
FROM buku b
INNER JOIN kategori k ON b.id_kategori = k.id_kategori;


SELECT e.no_reg_eksemplar, b.judul_buku, e.kondisi, e.status_ketersediaan
FROM eksemplar e
INNER JOIN buku b ON e.id_buku = b.id_buku;


SELECT p.id_pinjam, a.nama_anggota, p.tgl_pinjam, p.tgl_jatuh_tempo
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota;


SELECT p.id_pinjam, e.no_reg_eksemplar, e.kondisi, p.tgl_pinjam
FROM peminjaman p
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar;


SELECT e.no_reg_eksemplar, b.judul_buku, k.nama_kategori, e.kondisi
FROM eksemplar e
INNER JOIN buku b ON e.id_buku = b.id_buku
INNER JOIN kategori k ON b.id_kategori = k.id_kategori;


SELECT p.id_pinjam, a.nama_anggota, r.nama_peran, p.tgl_pinjam
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN peran_anggota r ON a.id_peran = r.id_peran;


SELECT p.id_pinjam, a.nama_anggota, p.tgl_pinjam, p.tgl_kembali
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
WHERE p.tgl_kembali IS NOT NULL;








SELECT 
    p.id_pinjam,
    a.nama_anggota,
    b.judul_buku,
    e.no_reg_eksemplar,
    p.tgl_pinjam,
    p.tgl_jatuh_tempo,
    p.status_peminjaman
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku;


SELECT 
    p.id_pinjam,
    a.nama_anggota,
    r.nama_peran,
    b.judul_buku,
    e.no_reg_eksemplar,
    e.kondisi,
    p.tgl_pinjam,
    p.tgl_jatuh_tempo,
    p.tgl_kembali,
    p.total_denda,
    p.status_peminjaman
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN peran_anggota r ON a.id_peran = r.id_peran
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku;


SELECT 
    p.id_pinjam,
    a.nama_anggota,
    b.judul_buku,
    k.nama_kategori,
    p.tgl_pinjam,
    p.status_peminjaman
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
INNER JOIN kategori k ON b.id_kategori = k.id_kategori;









SELECT 
    a.nama_anggota,
    b.judul_buku,
    p.tgl_pinjam,
    p.tgl_jatuh_tempo,
    DATEDIFF(CURDATE(), p.tgl_pinjam) AS hari_terlambat
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
WHERE p.tgl_kembali IS NULL 
  AND p.status_peminjaman = 'Dipinjam';


SELECT 
    b.judul_buku,
    COUNT(p.id_pinjam) AS jumlah_peminjaman
FROM peminjaman p
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
GROUP BY b.judul_buku
ORDER BY jumlah_peminjaman DESC;


SELECT 
    a.nama_anggota,
    r.nama_peran,
    COUNT(p.id_pinjam) AS total_pinjam
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN peran_anggota r ON a.id_peran = r.id_peran
GROUP BY a.nama_anggota, r.nama_peran
ORDER BY total_pinjam desc;


SELECT 
    a.nama_anggota,
    b.judul_buku,
    p.tgl_pinjam,
    p.tgl_jatuh_tempo,
    p.tgl_kembali,
    DATEDIFF(p.tgl_kembali, p.tgl_jatuh_tempo) AS hari_telat,
    p.total_denda
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
WHERE p.tgl_kembali > p.tgl_jatuh_tempo;


SELECT 
    a.nama_anggota,
    COUNT(p.id_pinjam) AS jumlah_pinjam,
    SUM(p.total_denda) AS total_denda
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
WHERE p.total_denda > 0
GROUP BY a.nama_anggota
ORDER BY total_denda DESC;


SELECT 
    b.judul_buku,
    e.no_reg_eksemplar,
    e.kondisi
FROM eksemplar e
INNER JOIN buku b ON e.id_buku = b.id_buku
WHERE e.status_ketersediaan = TRUE
  AND e.no_reg_eksemplar NOT IN (
      SELECT no_reg_eksemplar 
      FROM peminjaman 
      WHERE tgl_kembali IS NULL
  );


SELECT 
    k.nama_kategori,
    COUNT(p.id_pinjam) AS jumlah_peminjaman
FROM peminjaman p
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
INNER JOIN kategori k ON b.id_kategori = k.id_kategori
GROUP BY k.nama_kategori
ORDER BY jumlah_peminjaman DESC;



SELECT 
    a.nama_anggota,
    b.judul_buku,
    p.tgl_pinjam,
    p.status_peminjaman
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
WHERE DATE(p.tgl_pinjam) = CURDATE();