CREATE DATABASE IF NOT EXISTS perpustakaan;
USE perpustakaan;

CREATE TABLE IF NOT EXISTS Kelas (
    kode_kelas VARCHAR(10) PRIMARY KEY,
    nama_kelas VARCHAR(50) NOT NULL,
    wali_kelas VARCHAR(100)
);

-- 2. Tabel Kategori
CREATE TABLE IF NOT EXISTS Kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    deskripsi TEXT
);

-- 3. Tabel JudulBuku
CREATE TABLE IF NOT EXISTS JudulBuku (
    id_buku INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(200) NOT NULL,
    penulis VARCHAR(100),
    penerbit VARCHAR(100),
    tahun_terbit YEAR,
    id_kategori INT NOT NULL,
    FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori)
);

-- 4. Tabel Eksemplar
CREATE TABLE IF NOT EXISTS Eksemplar (
    id_eksemplar INT PRIMARY KEY AUTO_INCREMENT,
    id_judul INT NOT NULL,
    kode_eksemplar VARCHAR(20) NOT NULL UNIQUE,
    kondisi ENUM('baik','rusak_ringan','rusak_berat','hilang') NOT NULL DEFAULT 'baik',
    status ENUM('tersedia','dipinjam','perbaikan') NOT NULL DEFAULT 'tersedia',
    tanggal_masuk DATE NOT NULL,
    FOREIGN KEY (id_judul) REFERENCES JudulBuku(id_judul)
);

-- 5. Tabel Anggota
CREATE TABLE IF NOT EXISTS Anggota (
    id_anggota INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    jenis_anggota ENUM('siswa','guru') NOT NULL,
    nis_nip VARCHAR(20) NOT NULL UNIQUE,
    kelas_kode VARCHAR(10),
    alamat TEXT,
    telepon VARCHAR(15),
    tanggal_daftar DATE NOT NULL,
    status ENUM('aktif','nonaktif') DEFAULT 'aktif',
    FOREIGN KEY (kelas_kode) REFERENCES Kelas(kode_kelas)
);

-- 6. Tabel Petugas
CREATE TABLE IF NOT EXISTS Petugas (
    id_petugas INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    jabatan VARCHAR(50)
);

-- 7. Tabel Peminjaman
CREATE TABLE IF NOT EXISTS Peminjaman (
    id_peminjaman INT PRIMARY KEY AUTO_INCREMENT,
    id_anggota INT NOT NULL,
    id_eksemplar INT NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    tanggal_kembali DATE,
    status ENUM('dipinjam','dikembalikan','telat') NOT NULL,
    denda DECIMAL(10,2) DEFAULT 0,
    id_petugas INT,
    FOREIGN KEY (id_anggota) REFERENCES Anggota(id_anggota),
    FOREIGN KEY (id_eksemplar) REFERENCES Eksemplar(id_eksemplar),
    FOREIGN KEY (id_petugas) REFERENCES Petugas(id_petugas)
);

CREATE TABLE IF NOT EXISTS DetailPeminjaman (
    id_peminjaman INT,
    id_eksemplar INT,
    PRIMARY KEY (id_peminjaman, id_eksemplar),
    FOREIGN KEY (id_peminjaman) REFERENCES Peminjaman(id_peminjaman),
    FOREIGN KEY (id_eksemplar) REFERENCES Eksemplar(id_eksemplar)
);




INSERT INTO Kelas (kode_kelas, nama_kelas, wali_kelas) VALUES
('X-MIA-1', 'Kelas X MIA 1', 'Drs. Budi Santoso, M.Pd.'),
('X-MIA-2', 'Kelas X MIA 2', 'Dra. Ani Wijayanti, M.Pd.'),
('X-MIA-3', 'Kelas X MIA 3', 'Drs. Heri Susanto, M.Si.'),
('X-IIS-1', 'Kelas X IIS 1', 'Dra. Rina Puspita, M.Hum.'),
('XI-MIA-1', 'Kelas XI MIA 1', 'Drs. Agus Setiawan, M.Si.'),
('XI-MIA-2', 'Kelas XI MIA 2', 'Dra. Dewi Lestari, M.Pd.'),
('XI-IIS-1', 'Kelas XI IIS 1', 'Drs. Bambang Prasetyo, M.E.'),
('XII-MIA-1', 'Kelas XII MIA 1', 'Dra. Siti Rahayu, M.Pd.'),
('XII-MIA-2', 'Kelas XII MIA 2', 'Drs. Eko Purwanto, M.Si.'),
('XII-IIS-1', 'Kelas XII IIS 1', 'Dra. Maya Sari, M.Hum.');


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
(10, 'Olahraga', 'Buku-buku tentang olahraga dan kesehatan'),
(11, 'Teknologi', 'Buku-buku tentang teknologi dan komputer'),
(12, 'Psikologi', 'Buku-buku tentang psikologi dan pengembangan diri');

INSERT INTO JudulBuku (id_buku, judul, penulis, penerbit, tahun_terbit, id_kategori) VALUES
(1, 'Matematika SMA Kelas X', 'Sukino', 'Erlangga', 2023, 1),
(2, 'Matematika SMA Kelas XI', 'Sukino', 'Erlangga', 2023, 1),
(3, 'Matematika SMA Kelas XII', 'Sukino', 'Erlangga', 2023, 1),
(4, 'Kalkulus Dasar', 'Purcell', 'Gramedia', 2022, 1),
(5, 'Fisika Dasar', 'Halliday & Resnick', 'Gramedia', 2022, 2),
(6, 'Fisika SMA Kelas X', 'Marthen Kanginan', 'Yrama Widya', 2023, 2),
(7, 'Fisika SMA Kelas XI', 'Marthen Kanginan', 'Yrama Widya', 2023, 2),
(8, 'Fisika Modern', 'Beiser', 'Gramedia', 2021, 2),
(9, 'Kimia Organik', 'Ralph Fessenden', 'UI Press', 2022, 3),
(10, 'Kimia SMA Kelas X', 'Michael Purba', 'Erlangga', 2023, 3),
(11, 'Kimia SMA Kelas XI', 'Michael Purba', 'Erlangga', 2023, 3),
(12, 'Kimia Analisis', 'Vogel', 'Gramedia', 2021, 3),
(13, 'Biologi Molekuler', 'Campbell', 'Gramedia', 2022, 4),
(14, 'Biologi SMA Kelas XI', 'Irnaningtyas', 'Erlangga', 2023, 4),
(15, 'Biologi SMA Kelas XII', 'Irnaningtyas', 'Erlangga', 2023, 4),
(16, 'Anatomi Manusia', 'Gray', 'Gramedia', 2021, 4),
(17, 'Sejarah Indonesia', 'Sartono Kartodirdjo', 'Yudhistira', 2021, 5),
(18, 'Sejarah Dunia', 'J.M. Roberts', 'Tiga Serangkai', 2020, 5),
(19, 'Sejarah Peradaban Islam', 'Ira Lapidus', 'Yudhistira', 2021, 5),
(20, 'Sejarah Eropa', 'Norman Davies', 'Tiga Serangkai', 2020, 5),
(21, 'Geografi Fisik', 'Strahler', 'Erlangga', 2022, 6),
(22, 'Geografi SMA Kelas X', 'Nurul Huda', 'Yudhistira', 2023, 6),
(23, 'Geografi Regional', 'Haggett', 'Tiga Serangkai', 2021, 6),
(24, 'Ekonomi Mikro', 'Gregory Mankiw', 'Salemba', 2022, 7),
(25, 'Ekonomi SMA Kelas XI', 'Alam S', 'Erlangga', 2023, 7),
(26, 'Akuntansi Dasar', 'Hery', 'Yudhistira', 2022, 7),
(27, 'Bahasa Inggris', 'Betty Schrampfer', 'Oxford', 2022, 8),
(28, 'Bahasa Indonesia', 'Alwi', 'Balai Pustaka', 2021, 8),
(29, 'Pendidikan Agama Islam', 'Muhammad', 'Tiga Serangkai', 2023, 9),
(30, 'Bulu Tangkis', 'Rudy Hartono', 'Gramedia', 2020, 10);



DESCRIBE JudulBuku;
-- Cara 2: Cari dari INFORMATION_SCHEMA
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_NAME = 'Eksemplar'
    AND TABLE_SCHEMA = 'perpustakaan'
    AND REFERENCED_TABLE_NAME IS NOT NULL;







SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME = 'Kategori'
    AND TABLE_SCHEMA = 'perpustakaan';


-- Cek semua Foreign Key di database

SHOW CREATE TABLE JudulBuku;


















ALTER TABLE judulbuku DROP FOREIGN KEY judulbuku_ibfk_1;
TRUNCATE TABLE kategori;
ALTER TABLE kategori AUTO_INCREMENT = 1;
INSERT INTO kategori (id_kategori, nama_kategori, deskripsi) VALUES
(1, 'Matematika', 'Buku-buku tentang matematika dan ilmu hitung'),
(2, 'Fisika', 'Buku-buku tentang fisika dan ilmu alam'),
(3, 'Kimia', 'Buku-buku tentang kimia dan ilmu bahan'),
(4, 'Biologi', 'Buku-buku tentang biologi dan ilmu hayati'),
(5, 'Sejarah', 'Buku-buku tentang sejarah dan peristiwa masa lalu'),
(6, 'Geografi', 'Buku-buku tentang geografi dan ilmu bumi'),
(7, 'Ekonomi', 'Buku-buku tentang ekonomi dan bisnis'),
(8, 'Bahasa', 'Buku-buku tentang bahasa dan sastra'),
(9, 'Agama', 'Buku-buku tentang agama dan spiritualitas'),
(10, 'Olahraga', 'Buku-buku tentang olahraga dan kesehatan'),
(11, 'Teknologi', 'Buku-buku tentang teknologi dan komputer'),
(12, 'Psikologi', 'Buku-buku tentang psikologi dan pengembangan diri');
ALTER TABLE judulbuku 
ADD CONSTRAINT judulbuku_ibfk_1 
FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori);
SELECT * FROM kategori;



INSERT INTO Kelas (kode_kelas, nama_kelas, wali_kelas) VALUES
('X-MIA-1', 'Kelas X MIA 1', 'Drs. Budi Santoso, M.Pd.'),
('X-MIA-2', 'Kelas X MIA 2', 'Dra. Ani Wijayanti, M.Pd.'),
('X-MIA-3', 'Kelas X MIA 3', 'Drs. Heri Susanto, M.Si.'),
('X-IIS-1', 'Kelas X IIS 1', 'Dra. Rina Puspita, M.Hum.'),
('XI-MIA-1', 'Kelas XI MIA 1', 'Drs. Agus Setiawan, M.Si.'),
('XI-MIA-2', 'Kelas XI MIA 2', 'Dra. Dewi Lestari, M.Pd.'),
('XI-IIS-1', 'Kelas XI IIS 1', 'Drs. Bambang Prasetyo, M.E.'),
('XII-MIA-1', 'Kelas XII MIA 1', 'Dra. Siti Rahayu, M.Pd.'),
('XII-MIA-2', 'Kelas XII MIA 2', 'Drs. Eko Purwanto, M.Si.'),
('XII-IIS-1', 'Kelas XII IIS 1', 'Dra. Maya Sari, M.Hum.');

INSERT INTO JudulBuku (id_buku, judul, penulis, penerbit, tahun_terbit, id_kategori) VALUES
(1, 'Matematika SMA Kelas X', 'Sukino', 'Erlangga', 2023, 1),
(2, 'Matematika SMA Kelas XI', 'Sukino', 'Erlangga', 2023, 1),
(3, 'Matematika SMA Kelas XII', 'Sukino', 'Erlangga', 2023, 1),
(4, 'Kalkulus Dasar', 'Purcell', 'Gramedia', 2022, 1),
(5, 'Fisika Dasar', 'Halliday & Resnick', 'Gramedia', 2022, 2),
(6, 'Fisika SMA Kelas X', 'Marthen Kanginan', 'Yrama Widya', 2023, 2),
(7, 'Fisika SMA Kelas XI', 'Marthen Kanginan', 'Yrama Widya', 2023, 2),
(8, 'Fisika Modern', 'Beiser', 'Gramedia', 2021, 2),
(9, 'Kimia Organik', 'Ralph Fessenden', 'UI Press', 2022, 3),
(10, 'Kimia SMA Kelas X', 'Michael Purba', 'Erlangga', 2023, 3),
(11, 'Kimia SMA Kelas XI', 'Michael Purba', 'Erlangga', 2023, 3),
(12, 'Kimia Analisis', 'Vogel', 'Gramedia', 2021, 3),
(13, 'Biologi Molekuler', 'Campbell', 'Gramedia', 2022, 4),
(14, 'Biologi SMA Kelas XI', 'Irnaningtyas', 'Erlangga', 2023, 4),
(15, 'Biologi SMA Kelas XII', 'Irnaningtyas', 'Erlangga', 2023, 4),
(16, 'Anatomi Manusia', 'Gray', 'Gramedia', 2021, 4),
(17, 'Sejarah Indonesia', 'Sartono Kartodirdjo', 'Yudhistira', 2021, 5),
(18, 'Sejarah Dunia', 'J.M. Roberts', 'Tiga Serangkai', 2020, 5),
(19, 'Sejarah Peradaban Islam', 'Ira Lapidus', 'Yudhistira', 2021, 5),
(20, 'Sejarah Eropa', 'Norman Davies', 'Tiga Serangkai', 2020, 5),
(21, 'Geografi Fisik', 'Strahler', 'Erlangga', 2022, 6),
(22, 'Geografi SMA Kelas X', 'Nurul Huda', 'Yudhistira', 2023, 6),
(23, 'Geografi Regional', 'Haggett', 'Tiga Serangkai', 2021, 6),
(24, 'Ekonomi Mikro', 'Gregory Mankiw', 'Salemba', 2022, 7),
(25, 'Ekonomi SMA Kelas XI', 'Alam S', 'Erlangga', 2023, 7),
(26, 'Akuntansi Dasar', 'Hery', 'Yudhistira', 2022, 7),
(27, 'Bahasa Inggris', 'Betty Schrampfer', 'Oxford', 2022, 8),
(28, 'Bahasa Indonesia', 'Alwi', 'Balai Pustaka', 2021, 8),
(29, 'Pendidikan Agama Islam', 'Muhammad', 'Tiga Serangkai', 2023, 9),
(30, 'Bulu Tangkis', 'Rudy Hartono', 'Gramedia', 2020, 10);

DESCRIBE Eksemplar;
ALTER TABLE Eksemplar CHANGE id_judul id_buku INT;

INSERT INTO Eksemplar (id_eksemplar, id_buku, kode_eksemplar, kondisi, status, tanggal_masuk) VALUES
(1, 1, 'B001-01', 'baik', 'tersedia', '2024-07-01'),
(2, 1, 'B001-02', 'baik', 'dipinjam', '2024-07-01'),
(3, 1, 'B001-03', 'rusak_ringan', 'tersedia', '2024-07-15'),
(4, 2, 'B002-01', 'baik', 'tersedia', '2024-07-01'),
(5, 2, 'B002-02', 'baik', 'tersedia', '2024-07-01'),
(6, 2, 'B002-03', 'baik', 'perbaikan', '2024-07-15'),
(7, 3, 'B003-01', 'baik', 'tersedia', '2024-08-01'),
(8, 3, 'B003-02', 'baik', 'dipinjam', '2024-08-01'),
(9, 4, 'B004-01', 'baik', 'tersedia', '2024-07-01'),
(10, 4, 'B004-02', 'baik', 'tersedia', '2024-07-01'),
(11, 4, 'B004-03', 'baik', 'dipinjam', '2024-07-15'),
(12, 5, 'B005-01', 'baik', 'tersedia', '2024-07-01'),
(13, 5, 'B005-02', 'baik', 'dipinjam', '2024-07-01'),
(14, 5, 'B005-03', 'rusak_ringan', 'tersedia', '2024-07-15'),
(15, 6, 'B006-01', 'baik', 'tersedia', '2024-08-01'),
(16, 6, 'B006-02', 'baik', 'tersedia', '2024-08-01'),
(17, 6, 'B006-03', 'baik', 'dipinjam', '2024-08-15'),
(18, 7, 'B007-01', 'baik', 'tersedia', '2024-07-01'),
(19, 7, 'B007-02', 'baik', 'tersedia', '2024-07-01'),
(20, 8, 'B008-01', 'baik', 'tersedia', '2024-08-01'),
(21, 8, 'B008-02', 'baik', 'tersedia', '2024-08-01'),
(22, 9, 'B009-01', 'baik', 'tersedia', '2024-07-01'),
(23, 9, 'B009-02', 'baik', 'dipinjam', '2024-07-15'),
(24, 9, 'B009-03', 'rusak_ringan', 'tersedia', '2024-07-15'),
(25, 10, 'B010-01', 'baik', 'tersedia', '2024-07-01'),
(26, 10, 'B010-02', 'baik', 'tersedia', '2024-07-01'),
(27, 10, 'B010-03', 'baik', 'dipinjam', '2024-07-15'),
(28, 11, 'B011-01', 'baik', 'tersedia', '2024-08-01'),
(29, 11, 'B011-02', 'baik', 'tersedia', '2024-08-01'),
(30, 12, 'B012-01', 'baik', 'tersedia', '2024-07-01'),
(31, 12, 'B012-02', 'baik', 'tersedia', '2024-07-01'),
(32, 13, 'B013-01', 'baik', 'tersedia', '2024-08-01'),
(33, 13, 'B013-02', 'baik', 'tersedia', '2024-08-01'),
(34, 13, 'B013-03', 'baik', 'dipinjam', '2024-08-15'),
(35, 14, 'B014-01', 'baik', 'tersedia', '2024-07-01'),
(36, 14, 'B014-02', 'baik', 'dipinjam', '2024-07-15'),
(37, 14, 'B014-03', 'baik', 'tersedia', '2024-07-15'),
(38, 15, 'B015-01', 'baik', 'tersedia', '2024-08-01'),
(39, 15, 'B015-02', 'baik', 'tersedia', '2024-08-01'),
(40, 16, 'B016-01', 'baik', 'tersedia', '2024-07-01'),
(41, 16, 'B016-02', 'baik', 'tersedia', '2024-07-01'),
(42, 17, 'B017-01', 'baik', 'tersedia', '2024-07-01'),
(43, 17, 'B017-02', 'baik', 'tersedia', '2024-07-15'),
(44, 17, 'B017-03', 'rusak_berat', 'perbaikan', '2024-07-15'),
(45, 18, 'B018-01', 'baik', 'tersedia', '2024-08-01'),
(46, 18, 'B018-02', 'baik', 'tersedia', '2024-08-01'),
(47, 20, 'B020-01', 'baik', 'tersedia', '2024-07-01'),
(48, 20, 'B020-02', 'baik', 'tersedia', '2024-07-01'),
(49, 22, 'B022-01', 'baik', 'tersedia', '2024-08-01'),
(50, 22, 'B022-02', 'baik', 'tersedia', '2024-08-01'),
(51, 24, 'B024-01', 'baik', 'tersedia', '2024-07-01'),
(52, 24, 'B024-02', 'baik', 'dipinjam', '2024-07-15'),
(53, 24, 'B024-03', 'baik', 'tersedia', '2024-07-15'),
(54, 25, 'B025-01', 'baik', 'tersedia', '2024-08-01'),
(55, 25, 'B025-02', 'baik', 'tersedia', '2024-08-01'),
(56, 26, 'B026-01', 'baik', 'tersedia', '2024-07-01'),
(57, 26, 'B026-02', 'baik', 'tersedia', '2024-07-01'),
(58, 27, 'B027-01', 'baik', 'tersedia', '2024-08-01'),
(59, 27, 'B027-02', 'baik', 'tersedia', '2024-08-01'),
(60, 27, 'B027-03', 'baik', 'dipinjam', '2024-08-15'),
(61, 28, 'B028-01', 'baik', 'tersedia', '2024-07-01'),
(62, 28, 'B028-02', 'baik', 'tersedia', '2024-07-01'),
(63, 29, 'B029-01', 'baik', 'tersedia', '2024-08-01'),
(64, 29, 'B029-02', 'baik', 'tersedia', '2024-08-01'),
(65, 30, 'B030-01', 'baik', 'tersedia', '2024-07-15'),
(66, 30, 'B030-02', 'baik', 'tersedia', '2024-07-15'),
(67, 30, 'B030-03', 'baik', 'tersedia', '2024-07-15');

INSERT INTO Anggota (id_anggota, nama, jenis_anggota, nis_nip, kelas_kode, alamat, telepon, tanggal_daftar, status) VALUES
(1, 'Andi Pratama', 'siswa', 'S001', 'X-MIA-1', 'Jl. Mawar No. 1, Malang', '081234567001', '2024-07-01', 'aktif'),
(2, 'Siti Rahmawati', 'siswa', 'S002', 'X-MIA-2', 'Jl. Melati No. 2, Malang', '081234567002', '2024-07-01', 'aktif'),
(3, 'Budi Santoso', 'siswa', 'S003', 'X-MIA-1', 'Jl. Anggrek No. 3, Malang', '081234567003', '2024-07-01', 'aktif'),
(4, 'Anisa Putri', 'siswa', 'S004', 'X-MIA-2', 'Jl. Kenanga No. 4, Malang', '081234567004', '2024-07-01', 'aktif'),
(5, 'Dimas Pratama', 'siswa', 'S005', 'X-MIA-1', 'Jl. Dahlia No. 5, Malang', '081234567005', '2024-07-01', 'aktif'),
(6, 'Rina Lestari', 'siswa', 'S006', 'XI-MIA-1', 'Jl. Flamboyan No. 6, Malang', '081234567006', '2024-07-01', 'aktif'),
(7, 'Hendra Wijaya', 'siswa', 'S007', 'XI-MIA-2', 'Jl. Cemara No. 7, Malang', '081234567007', '2024-07-01', 'aktif'),
(8, 'Dewi Anggraini', 'siswa', 'S008', 'XI-MIA-1', 'Jl. Pinus No. 8, Malang', '081234567008', '2024-07-01', 'aktif'),
(9, 'Rizki Fadillah', 'siswa', 'S009', 'XI-MIA-2', 'Jl. Mahoni No. 9, Malang', '081234567009', '2024-07-01', 'aktif'),
(10, 'Maya Sari', 'siswa', 'S010', 'XII-MIA-1', 'Jl. Jati No. 10, Malang', '081234567010', '2024-07-01', 'aktif'),
(11, 'Agus Salim', 'siswa', 'S011', 'XII-MIA-2', 'Jl. Beringin No. 11, Malang', '081234567011', '2024-07-01', 'aktif'),
(12, 'Nina Kurnia', 'siswa', 'S012', 'XII-IIS-1', 'Jl. Kamboja No. 12, Malang', '081234567012', '2024-07-01', 'aktif'),
(13, 'Fajar Nugroho', 'siswa', 'S013', 'X-MIA-3', 'Jl. Teratai No. 13, Malang', '081234567013', '2024-07-01', 'aktif'),
(14, 'Cindy Widya', 'siswa', 'S014', 'XI-IIS-1', 'Jl. Sakura No. 14, Malang', '081234567014', '2024-07-01', 'aktif'),
(15, 'Eko Prasetyo', 'siswa', 'S015', 'X-MIA-3', 'Jl. Nusa Indah No. 15, Malang', '081234567015', '2024-07-01', 'aktif'),
(16, 'Diana Kusuma', 'siswa', 'S016', 'X-MIA-1', 'Jl. Alamanda No. 16, Malang', '081234567016', '2024-07-01', 'aktif'),
(17, 'Rama Wijaya', 'siswa', 'S017', 'XI-MIA-1', 'Jl. Kenari No. 17, Malang', '081234567017', '2024-07-01', 'aktif'),
(18, 'Tina Wulandari', 'siswa', 'S018', 'XII-MIA-1', 'Jl. Angsana No. 18, Malang', '081234567018', '2024-07-01', 'aktif'),
(19, 'Yudi Hermawan', 'siswa', 'S019', 'X-MIA-2', 'Jl. Taman No. 19, Malang', '081234567019', '2024-07-01', 'aktif'),
(20, 'Lina Sari', 'siswa', 'S020', 'XI-MIA-2', 'Jl. Kencana No. 20, Malang', '081234567020', '2024-07-01', 'aktif'),
(21, 'Arief Rahman', 'siswa', 'S021', 'XII-IIS-1', 'Jl. Pahlawan No. 21, Malang', '081234567021', '2024-07-01', 'aktif'),
(22, 'Nadia Putri', 'siswa', 'S022', 'X-MIA-3', 'Jl. Veteran No. 22, Malang', '081234567022', '2024-07-01', 'aktif'),
(23, 'Rizky Maulana', 'siswa', 'S023', 'XI-IIS-1', 'Jl. Merdeka No. 23, Malang', '081234567023', '2024-07-01', 'aktif'),
(24, 'Sarah Aulia', 'siswa', 'S024', 'XII-MIA-2', 'Jl. Sudirman No. 24, Malang', '081234567024', '2024-07-01', 'aktif'),
(25, 'Fikri Hidayat', 'siswa', 'S025', 'X-MIA-1', 'Jl. Diponegoro No. 25, Malang', '081234567025', '2024-07-01', 'aktif'),
(26, 'Drs. Budi Santoso, M.Pd.', 'guru', 'G001', NULL, 'Jl. Pendidikan No. 1, Malang', '081234567026', '2024-07-01', 'aktif'),
(27, 'Dra. Ani Wijayanti, M.Pd.', 'guru', 'G002', NULL, 'Jl. Guru No. 2, Malang', '081234567027', '2024-07-01', 'aktif'),
(28, 'Drs. Heri Susanto, M.Si.', 'guru', 'G003', NULL, 'Jl. Ilmu No. 3, Malang', '081234567028', '2024-07-01', 'aktif'),
(29, 'Dra. Rina Puspita, M.Hum.', 'guru', 'G004', NULL, 'Jl. Pengetahuan No. 4, Malang', '081234567029', '2024-07-01', 'aktif'),
(30, 'Drs. Agus Setiawan, M.Si.', 'guru', 'G005', NULL, 'Jl. Kebijakan No. 5, Malang', '081234567030', '2024-07-01', 'aktif');

INSERT INTO Petugas (id_petugas, nama, username, password, jabatan) VALUES
(1, 'Ibu Siti Fatimah, S.IP.', 'siti_fatimah', 'password123', 'Kepala Perpustakaan'),
(2, 'Bpk. Ahmad Ridwan, S.Kom.', 'ahmad_ridwan', 'password123', 'Staf Perpustakaan'),
(3, 'Ibu Rina Anggraeni, S.Sos.', 'rina_anggraeni', 'password123', 'Staf Perpustakaan'),
(4, 'Bpk. Mochamad Ali, S.Pd.', 'moch_ali', 'password123', 'Staf Perpustakaan');

INSERT INTO Peminjaman (id_peminjaman, id_anggota, id_eksemplar, tanggal_pinjam, tanggal_jatuh_tempo, tanggal_kembali, status, denda, id_petugas) VALUES
(1, 1, 2, '2024-07-01', '2024-07-08', '2024-07-08', 'dikembalikan', 0, 1),
(2, 2, 5, '2024-07-01', '2024-07-08', '2024-07-07', 'dikembalikan', 0, 1),
(3, 3, 8, '2024-07-02', '2024-07-09', '2024-07-09', 'dikembalikan', 0, 2),
(4, 4, 10, '2024-07-03', '2024-07-10', '2024-07-09', 'dikembalikan', 0, 2),
(5, 5, 13, '2024-07-04', '2024-07-11', '2024-07-10', 'dikembalikan', 0, 3),
(6, 6, 16, '2024-07-05', '2024-07-12', '2024-07-12', 'dikembalikan', 0, 1),
(7, 7, 19, '2024-07-06', '2024-07-13', '2024-07-13', 'dikembalikan', 0, 1),
(8, 8, 22, '2024-07-07', '2024-07-14', '2024-07-14', 'dikembalikan', 0, 2),
(9, 9, 25, '2024-07-08', '2024-07-15', '2024-07-14', 'dikembalikan', 0, 2),
(10, 10, 28, '2024-07-09', '2024-07-16', '2024-07-16', 'dikembalikan', 0, 3),
(11, 11, 31, '2024-07-10', '2024-07-17', '2024-07-16', 'dikembalikan', 0, 1),
(12, 12, 35, '2024-07-11', '2024-07-18', '2024-07-18', 'dikembalikan', 0, 1),
(13, 13, 38, '2024-07-12', '2024-07-19', '2024-07-19', 'dikembalikan', 0, 2),
(14, 14, 40, '2024-07-13', '2024-07-20', '2024-07-19', 'dikembalikan', 0, 2),
(15, 15, 42, '2024-07-14', '2024-07-21', '2024-07-21', 'dikembalikan', 0, 3),
(16, 16, 1, '2024-07-01', '2024-07-08', '2024-07-12', 'telat', 4000, 1),
(17, 17, 4, '2024-07-02', '2024-07-09', '2024-07-15', 'telat', 6000, 2),
(18, 18, 7, '2024-07-03', '2024-07-10', '2024-07-17', 'telat', 7000, 2),
(19, 19, 9, '2024-07-04', '2024-07-11', '2024-07-16', 'telat', 5000, 3),
(20, 20, 12, '2024-07-05', '2024-07-12', '2024-07-20', 'telat', 8000, 1),
(21, 21, 15, '2024-07-06', '2024-07-13', '2024-07-18', 'telat', 5000, 1),
(22, 22, 18, '2024-07-07', '2024-07-14', '2024-07-22', 'telat', 8000, 2),
(23, 23, 21, '2024-07-08', '2024-07-15', '2024-07-19', 'telat', 4000, 2),
(24, 24, 24, '2024-07-09', '2024-07-16', '2024-07-23', 'telat', 7000, 3),
(25, 25, 27, '2024-07-10', '2024-07-17', '2024-07-24', 'telat', 7000, 1),
(26, 26, 3, '2024-07-15', '2024-07-22', NULL, 'dipinjam', 0, 1),
(27, 27, 6, '2024-07-16', '2024-07-23', NULL, 'dipinjam', 0, 1),
(28, 28, 11, '2024-07-17', '2024-07-24', NULL, 'dipinjam', 0, 2),
(29, 29, 14, '2024-07-18', '2024-07-25', NULL, 'dipinjam', 0, 2),
(30, 30, 17, '2024-07-19', '2024-07-26', NULL, 'dipinjam', 0, 3),
(31, 1, 20, '2024-07-20', '2024-07-27', NULL, 'dipinjam', 0, 1),
(32, 2, 23, '2024-07-21', '2024-07-28', NULL, 'dipinjam', 0, 1),
(33, 3, 26, '2024-07-22', '2024-07-29', NULL, 'dipinjam', 0, 2),
(34, 4, 29, '2024-07-23', '2024-07-30', NULL, 'dipinjam', 0, 2),
(35, 5, 32, '2024-07-24', '2024-07-31', NULL, 'dipinjam', 0, 3),
(36, 6, 34, '2024-08-01', '2024-08-08', NULL, 'dipinjam', 0, 1),
(37, 7, 36, '2024-08-01', '2024-08-08', NULL, 'dipinjam', 0, 1),
(38, 8, 39, '2024-08-02', '2024-08-09', NULL, 'dipinjam', 0, 2),
(39, 9, 41, '2024-08-02', '2024-08-09', NULL, 'dipinjam', 0, 2),
(40, 10, 43, '2024-08-03', '2024-08-10', NULL, 'dipinjam', 0, 3),
(41, 11, 45, '2024-08-03', '2024-08-10', NULL, 'dipinjam', 0, 3),
(42, 12, 46, '2024-08-04', '2024-08-11', NULL, 'dipinjam', 0, 1),
(43, 13, 47, '2024-08-04', '2024-08-11', NULL, 'dipinjam', 0, 1),
(44, 14, 48, '2024-08-05', '2024-08-12', NULL, 'dipinjam', 0, 2),
(45, 15, 49, '2024-08-05', '2024-08-12', NULL, 'dipinjam', 0, 2),
(46, 16, 50, '2024-08-06', '2024-08-13', NULL, 'dipinjam', 0, 3),
(47, 17, 51, '2024-08-06', '2024-08-13', NULL, 'dipinjam', 0, 3),
(48, 18, 52, '2024-08-07', '2024-08-14', NULL, 'dipinjam', 0, 1),
(49, 19, 53, '2024-08-07', '2024-08-14', NULL, 'dipinjam', 0, 1),
(50, 20, 54, '2024-08-08', '2024-08-15', NULL, 'dipinjam', 0, 2);


SELECT 'Kelas' AS Tabel, COUNT(*) AS Jumlah FROM Kelas
UNION ALL
SELECT 'Kategori', COUNT(*) FROM Kategori
UNION ALL
SELECT 'JudulBuku', COUNT(*) FROM JudulBuku
UNION ALL
SELECT 'Eksemplar', COUNT(*) FROM Eksemplar
UNION ALL
SELECT 'Anggota', COUNT(*) FROM Anggota
UNION ALL
SELECT 'Petugas', COUNT(*) FROM Petugas
UNION ALL
SELECT 'Peminjaman', COUNT(*) FROM Peminjaman;