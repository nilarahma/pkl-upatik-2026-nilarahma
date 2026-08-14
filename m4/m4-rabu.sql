USE perpustakaan;
INSERT INTO Kategori (id_kategori, nama_kategori, deskripsi) VALUES
(1, 'Matematika', 'Buku-buku tentang matematika dan ilmu hitung'),
(2, 'Fisika', 'Buku-buku tentang fisika dan ilmu alam'),
(3, 'Kimia', 'Buku-buku tentang kimia dan ilmu bahan'),
(4, 'Biologi', 'Buku-buku tentang biologi dan ilmu hayati'),
(5, 'Sejarah', 'Buku-buku tentang sejarah dan peristiwa masa lalu'),
(6, 'Geografi', 'Buku-buku tentang geografi dan ilmu bumi'),
(7, 'Ekonomi', 'Buku-buku tentang ekonomi dan bisnis'),
(8, 'Bahasa', 'Buku-buku tentang bahasa dan sastra'),
(9, 'Agama', 'Buku-buku tentang agama dan spiritualitas'),
(10, 'Olahraga', 'Buku-buku tentang olahraga dan kesehatan');





SELECT nama, nis_nip, jenis_anggota FROM Anggota;
SELECT * FROM Kategori;
SELECT * FROM Anggota WHERE jenis_anggota = 'siswa';
SELECT * FROM Peminjaman WHERE denda > 0;
SELECT * FROM Eksemplar WHERE status = 'tersedia' AND kondisi = 'baik';
SELECT * FROM Peminjaman WHERE tanggal_pinjam BETWEEN '2024-07-01' AND '2024-07-31';
SELECT * FROM Anggota WHERE jenis_anggota IN ('siswa', 'guru');
SELECT * FROM Anggota WHERE nama LIKE '%Pratama%';
SELECT * FROM JudulBuku WHERE judul LIKE 'Fisika%';


SELECT * FROM Anggota ORDER BY nama ASC;
SELECT * FROM Peminjaman ORDER BY tanggal_pinjam DESC;
SELECT * FROM Peminjaman ORDER BY status ASC, tanggal_pinjam DESC;
SELECT * FROM Anggota LIMIT 5;
SELECT * FROM Peminjaman ORDER BY tanggal_pinjam DESC LIMIT 5;
SELECT DISTINCT status FROM Eksemplar;
SELECT DISTINCT jenis_anggota FROM Anggota;