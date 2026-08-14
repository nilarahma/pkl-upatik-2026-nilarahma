CREATE DATABASE IF NOT EXISTS perpustakaan;
USE perpustakaan;
CREATE TABLE IF NOT EXISTS Kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    deskripsi TEXT
);

CREATE TABLE IF NOT EXISTS Kelas (
    kode_kelas VARCHAR(10) PRIMARY KEY,
    nama_kelas VARCHAR(50) NOT NULL,
    wali_kelas VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Petugas (
    id_petugas INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    jabatan VARCHAR(50)
);



ALTER TABLE Kategori ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE Kategori ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
DESCRIBE Kategori;

ALTER TABLE Kategori MODIFY deskripsi VARCHAR(255);
DESCRIBE Kategori;

ALTER TABLE Kategori DROP COLUMN created_at;
ALTER TABLE Kategori DROP COLUMN updated_at;
DESCRIBE Kategori;



-- Sengaja error
ALTER TABLE Kategori ADD COLUMN id_kategori INT;
ALTER TABLE Kategori MODIFY id_kategori VARCHAR(10);
ALTER TABLE Kategori DROP COLUMN kolom_aneh;

-- DROP TABLE vs TRUNCATE — Apa Bedanya?
CREATE TABLE IF NOT EXISTS percobaan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(50)
);
INSERT INTO percobaan (nama) VALUES ('Andi'), ('Budi'), ('Cici');
SELECT * FROM percobaan;


CREATE TABLE IF NOT EXISTS Siswa (
    id_siswa INT PRIMARY KEY AUTO_INCREMENT,
    nis VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    kelas VARCHAR(20),
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('aktif','nonaktif') DEFAULT 'aktif'
);