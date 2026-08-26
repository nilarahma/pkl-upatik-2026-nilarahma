USE perpustakaan;
CREATE TABLE IF NOT EXISTS JudulBuku (
    id_buku INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(200) NOT NULL,
    penulis VARCHAR(100),
    penerbit VARCHAR(100),
    tahun_terbit YEAR,
    id_kategori INT NOT NULL,
    FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori)
);


CREATE TABLE IF NOT EXISTS Eksemplar (
    id_eksemplar INT PRIMARY KEY AUTO_INCREMENT,
    id_buku INT NOT NULL,
    kode_eksemplar VARCHAR(20) NOT NULL UNIQUE,
    kondisi ENUM('baik','rusak_ringan','rusak_berat','hilang') NOT NULL DEFAULT 'baik',
    status ENUM('tersedia','dipinjam','perbaikan') NOT NULL DEFAULT 'tersedia',
    tanggal_masuk DATE NOT NULL,
    FOREIGN KEY (id_buku) REFERENCES JudulBuku(id_buku)
);


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








INSERT INTO Anggota (nama, jenis_anggota, nis_nip, kelas_kode, tanggal_daftar)
VALUES ('Test', 'siswa', 'TEST001', 'KELAS-TIDAK-ADA', '2024-01-01');

INSERT INTO Eksemplar (id_buku, kode_eksemplar, tanggal_masuk)
VALUES (999, 'TEST-001', '2024-01-01');

INSERT INTO Peminjaman (id_anggota, id_eksemplar, tanggal_pinjam, tanggal_jatuh_tempo, status)
VALUES (999, 1, '2024-01-01', '2024-01-08', 'dipinjam');








DROP DATABASE IF EXISTS perpustakaan;
CREATE DATABASE perpustakaan;
USE perpustakaan;

CREATE TABLE Kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    deskripsi TEXT
);

CREATE TABLE Kelas (
    kode_kelas VARCHAR(10) PRIMARY KEY,
    nama_kelas VARCHAR(50) NOT NULL,
    wali_kelas VARCHAR(100)
);

CREATE TABLE Petugas (
    id_petugas INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    jabatan VARCHAR(50)
);


CREATE TABLE JudulBuku (
    id_buku INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(200) NOT NULL,
    penulis VARCHAR(100),
    penerbit VARCHAR(100),
    tahun_terbit YEAR,
    id_kategori INT NOT NULL,
    FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori)
);

CREATE TABLE Eksemplar (
    id_eksemplar INT PRIMARY KEY AUTO_INCREMENT,
    id_buku INT NOT NULL,
    kode_eksemplar VARCHAR(20) NOT NULL UNIQUE,
    kondisi ENUM('baik','rusak_ringan','rusak_berat','hilang') NOT NULL DEFAULT 'baik',
    status ENUM('tersedia','dipinjam','perbaikan') NOT NULL DEFAULT 'tersedia',
    tanggal_masuk DATE NOT NULL,
    FOREIGN KEY (id_buku) REFERENCES JudulBuku(id_buku)
);

CREATE TABLE Anggota (
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


CREATE TABLE Peminjaman (
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

SHOW TABLES;
