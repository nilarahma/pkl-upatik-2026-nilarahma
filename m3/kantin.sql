CREATE DATABASE IF NOT EXISTS kantin;
USE kantin;
CREATE TABLE IF NOT EXISTS Stan (
    id_stan INT PRIMARY KEY AUTO_INCREMENT,
    nama_stan VARCHAR(100) NOT NULL,
    pemilik VARCHAR(100),
    lokasi VARCHAR(50),
    kontak VARCHAR(15),
    status ENUM('aktif','nonaktif') DEFAULT 'aktif'
);


CREATE TABLE IF NOT EXISTS Menu (
    id_menu INT PRIMARY KEY AUTO_INCREMENT,
    id_stan INT NOT NULL,
    nama_menu VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    deskripsi TEXT,
    status ENUM('tersedia','habis','tidak_tersedia') DEFAULT 'tersedia',
    FOREIGN KEY (id_stan) REFERENCES Stan(id_stan)
);


CREATE TABLE IF NOT EXISTS Siswa (
    id_siswa INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    nis VARCHAR(20) NOT NULL UNIQUE,
    kelas VARCHAR(20),
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('aktif','nonaktif') DEFAULT 'aktif'
);


CREATE TABLE IF NOT EXISTS OrangTua (
    id_ortu INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    telepon VARCHAR(15),
    email VARCHAR(100),
    password VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS SiswaOrangTua (
    id_siswa INT,
    id_ortu INT,
    PRIMARY KEY (id_siswa, id_ortu),
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa),
    FOREIGN KEY (id_ortu) REFERENCES OrangTua(id_ortu)
);


CREATE TABLE IF NOT EXISTS TopUp (
    id_topup INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT NOT NULL,
    id_ortu INT NOT NULL,
    nominal DECIMAL(10,2) NOT NULL,
    tanggal DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metode ENUM('transfer','cash','qris') NOT NULL,
    status ENUM('pending','success','failed') DEFAULT 'pending',
    bukti VARCHAR(255),
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa),
    FOREIGN KEY (id_ortu) REFERENCES OrangTua(id_ortu)
);


CREATE TABLE IF NOT EXISTS Transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT NOT NULL,
    id_stan INT NOT NULL,
    tanggal DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    saldo_sebelum DECIMAL(10,2) NOT NULL,
    saldo_sesudah DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa),
    FOREIGN KEY (id_stan) REFERENCES Stan(id_stan)
);


CREATE TABLE IF NOT EXISTS DetailTransaksi (
    id_transaksi INT,
    id_menu INT,
    kuantitas INT NOT NULL DEFAULT 1,
    harga_satuan DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_transaksi, id_menu),
    FOREIGN KEY (id_transaksi) REFERENCES Transaksi(id_transaksi),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu)
);






INSERT INTO Stan (id_stan, nama_stan, pemilik, lokasi, kontak, status) VALUES
(1, 'Kantin Sehat', 'Ibu Darmi', 'Lantai 1 - Depan', '081234567100', 'aktif'),
(2, 'Snack & Minum', 'Bpk. Joko', 'Lantai 1 - Belakang', '081234567101', 'aktif'),
(3, 'Burger Station', 'Bpk. Hendra', 'Lantai 2 - Kiri', '081234567102', 'aktif'),
(4, 'Mie & Pasta', 'Ibu Sari', 'Lantai 2 - Kanan', '081234567103', 'aktif'),
(5, 'Buah Segar', 'Bpk. Dodi', 'Lantai 1 - Tengah', '081234567104', 'aktif'),
(6, 'Nasi Box', 'Ibu Rini', 'Lantai 2 - Tengah', '081234567105', 'nonaktif');

INSERT INTO Menu (id_menu, id_stan, nama_menu, harga, deskripsi, status) VALUES
(1, 1, 'Nasi Ayam Geprek', 15000, 'Nasi putih + ayam geprek sambel', 'tersedia'),
(2, 1, 'Nasi Telur Dadar', 12000, 'Nasi putih + telur dadar sayur', 'tersedia'),
(3, 1, 'Soto Ayam', 13000, 'Soto ayam + perkedel', 'tersedia'),
(4, 1, 'Es Teh Manis', 3000, 'Es teh manis segar', 'tersedia'),
(5, 1, 'Es Jeruk', 4000, 'Es jeruk peras asli', 'tersedia'),
(6, 2, 'Kentang Goreng', 10000, 'Kentang goreng crispy', 'tersedia'),
(7, 2, 'Sosis Bakar', 8000, 'Sosis bakar saus tomat', 'tersedia'),
(8, 2, 'Mie Instan', 7000, 'Mie instan goreng', 'tersedia'),
(9, 2, 'Teh Botol', 5000, 'Teh botol kemasan', 'tersedia'),
(10, 2, 'Air Mineral', 3000, 'Air mineral 600ml', 'tersedia'),
(11, 3, 'Burger Ayam', 18000, 'Burger ayam + keju + sayur', 'tersedia'),
(12, 3, 'Burger Daging', 20000, 'Burger daging sapi + keju', 'tersedia'),
(13, 3, 'Burger Double Cheese', 25000, 'Burger 2 daging + 2 keju', 'tersedia'),
(14, 3, 'French Fries', 12000, 'Kentang goreng + saus', 'tersedia'),
(15, 3, 'Milkshake', 15000, 'Milkshake coklat/stroberi', 'tersedia'),
(16, 4, 'Mie Ayam', 15000, 'Mie ayam + pangsit', 'tersedia'),
(17, 4, 'Mie Goreng', 14000, 'Mie goreng seafood', 'tersedia'),
(18, 4, 'Spaghetti Bolognese', 22000, 'Spaghetti + saus daging', 'tersedia'),
(19, 4, 'Spaghetti Carbonara', 24000, 'Spaghetti + saus keju', 'tersedia'),
(20, 4, 'Cappuccino', 12000, 'Cappuccino panas', 'tersedia'),
(21, 5, 'Jus Alpukat', 8000, 'Jus alpukat + coklat', 'tersedia'),
(22, 5, 'Jus Strawberry', 10000, 'Jus stroberi segar', 'tersedia'),
(23, 5, 'Potongan Buah', 7000, 'Potongan buah campur', 'tersedia'),
(24, 5, 'Rujak Buah', 12000, 'Rujak buah + saus kacang', 'tersedia'),
(25, 5, 'Es Campur', 10000, 'Es campur segar', 'tersedia');

INSERT INTO OrangTua (id_ortu, nama, telepon, email, password) VALUES
(1, 'Bpk. Ahmad Hidayat', '081234567200', 'ahmad.hidayat@email.com', 'password123'),
(2, 'Ibu Dewi Kusuma', '081234567201', 'dewi.kusuma@email.com', 'password123'),
(3, 'Bpk. Hadi Susanto', '081234567202', 'hadi.susanto@email.com', 'password123'),
(4, 'Ibu Rini Anggraeni', '081234567203', 'rini.anggraeni@email.com', 'password123'),
(5, 'Bpk. Slamet Riyadi', '081234567204', 'slamet.riyadi@email.com', 'password123');

INSERT INTO Siswa (id_siswa, nama, nis, kelas, saldo, status) VALUES
(1, 'Andi Pratama', 'S001', 'X-MIA-1', 50000, 'aktif'),
(2, 'Siti Rahmawati', 'S002', 'X-MIA-2', 75000, 'aktif'),
(3, 'Budi Santoso', 'S003', 'X-MIA-1', 30000, 'aktif'),
(4, 'Anisa Putri', 'S004', 'X-MIA-2', 90000, 'aktif'),
(5, 'Dimas Pratama', 'S005', 'X-MIA-1', 45000, 'aktif'),
(6, 'Rina Lestari', 'S006', 'XI-MIA-1', 60000, 'aktif'),
(7, 'Hendra Wijaya', 'S007', 'XI-MIA-2', 35000, 'aktif'),
(8, 'Dewi Anggraini', 'S008', 'XI-MIA-1', 85000, 'aktif'),
(9, 'Rizki Fadillah', 'S009', 'XI-MIA-2', 40000, 'aktif'),
(10, 'Maya Sari', 'S010', 'XII-MIA-1', 70000, 'aktif'),
(11, 'Agus Salim', 'S011', 'XII-MIA-2', 25000, 'aktif'),
(12, 'Nina Kurnia', 'S012', 'XII-IIS-1', 55000, 'aktif'),
(13, 'Fajar Nugroho', 'S013', 'X-MIA-3', 65000, 'aktif'),
(14, 'Cindy Widya', 'S014', 'XI-IIS-1', 80000, 'aktif'),
(15, 'Eko Prasetyo', 'S015', 'X-MIA-3', 30000, 'aktif');

INSERT INTO SiswaOrangTua (id_siswa, id_ortu) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 1), (7, 2), (8, 3), (9, 4), (10, 5),
(11, 1), (12, 2), (13, 3), (14, 4), (15, 5);

INSERT INTO TopUp (id_topup, id_siswa, id_ortu, nominal, tanggal, metode, status, bukti) VALUES
(1, 1, 1, 100000, '2024-07-01 08:00:00', 'transfer', 'success', 'bukti_001.jpg'),
(2, 2, 2, 50000, '2024-07-02 09:00:00', 'cash', 'success', NULL),
(3, 3, 3, 50000, '2024-07-03 10:00:00', 'qris', 'success', 'bukti_003.jpg'),
(4, 4, 4, 100000, '2024-07-04 11:00:00', 'transfer', 'success', 'bukti_004.jpg'),
(5, 5, 5, 50000, '2024-07-05 13:00:00', 'cash', 'success', NULL),
(6, 6, 1, 75000, '2024-07-06 14:00:00', 'transfer', 'success', 'bukti_006.jpg'),
(7, 7, 2, 50000, '2024-07-07 08:30:00', 'qris', 'success', 'bukti_007.jpg'),
(8, 8, 3, 100000, '2024-07-08 09:30:00', 'transfer', 'success', 'bukti_008.jpg'),
(9, 9, 4, 50000, '2024-07-09 10:30:00', 'cash', 'success', NULL),
(10, 10, 5, 75000, '2024-07-10 11:30:00', 'transfer', 'success', 'bukti_010.jpg'),
(11, 11, 1, 50000, '2024-07-11 12:00:00', 'qris', 'success', 'bukti_011.jpg'),
(12, 12, 2, 50000, '2024-07-12 13:30:00', 'transfer', 'success', 'bukti_012.jpg'),
(13, 13, 3, 100000, '2024-07-13 14:30:00', 'cash', 'success', NULL),
(14, 14, 4, 50000, '2024-07-14 08:00:00', 'transfer', 'success', 'bukti_014.jpg'),
(15, 15, 5, 50000, '2024-07-15 09:00:00', 'qris', 'success', 'bukti_015.jpg'),
(16, 1, 1, 50000, '2024-07-20 10:00:00', 'transfer', 'success', 'bukti_016.jpg'),
(17, 3, 3, 75000, '2024-07-25 11:00:00', 'cash', 'success', NULL),
(18, 5, 5, 100000, '2024-08-01 09:00:00', 'transfer', 'success', 'bukti_018.jpg'),
(19, 7, 2, 50000, '2024-08-05 10:00:00', 'qris', 'success', 'bukti_019.jpg'),
(20, 9, 4, 75000, '2024-08-10 11:00:00', 'transfer', 'success', 'bukti_020.jpg');

UPDATE Siswa SET saldo = 50000 WHERE id_siswa = 1;
UPDATE Siswa SET saldo = 75000 WHERE id_siswa = 2;
UPDATE Siswa SET saldo = 30000 WHERE id_siswa = 3;
UPDATE Siswa SET saldo = 90000 WHERE id_siswa = 4;
UPDATE Siswa SET saldo = 45000 WHERE id_siswa = 5;
UPDATE Siswa SET saldo = 60000 WHERE id_siswa = 6;
UPDATE Siswa SET saldo = 35000 WHERE id_siswa = 7;
UPDATE Siswa SET saldo = 85000 WHERE id_siswa = 8;
UPDATE Siswa SET saldo = 40000 WHERE id_siswa = 9;
UPDATE Siswa SET saldo = 70000 WHERE id_siswa = 10;
UPDATE Siswa SET saldo = 25000 WHERE id_siswa = 11;
UPDATE Siswa SET saldo = 55000 WHERE id_siswa = 12;
UPDATE Siswa SET saldo = 65000 WHERE id_siswa = 13;
UPDATE Siswa SET saldo = 80000 WHERE id_siswa = 14;
UPDATE Siswa SET saldo = 30000 WHERE id_siswa = 15;

INSERT INTO Transaksi (id_transaksi, id_siswa, id_stan, tanggal, total, saldo_sebelum, saldo_sesudah) VALUES
(1, 1, 1, '2024-07-01 11:30:00', 15000, 50000, 35000),
(2, 2, 2, '2024-07-01 12:00:00', 10000, 75000, 65000),
(3, 3, 3, '2024-07-02 11:15:00', 18000, 30000, 12000),
(4, 4, 4, '2024-07-02 12:30:00', 15000, 90000, 75000),
(5, 5, 5, '2024-07-03 11:00:00', 8000, 45000, 37000),
(6, 6, 1, '2024-07-03 12:00:00', 12000, 60000, 48000),
(7, 7, 2, '2024-07-04 11:30:00', 7000, 35000, 28000),
(8, 8, 3, '2024-07-04 12:15:00', 20000, 85000, 65000),
(9, 9, 4, '2024-07-05 11:00:00', 14000, 40000, 26000),
(10, 10, 5, '2024-07-05 12:30:00', 10000, 70000, 60000),
(11, 11, 1, '2024-07-06 11:15:00', 13000, 25000, 12000),
(12, 12, 2, '2024-07-06 12:00:00', 8000, 55000, 47000),
(13, 13, 3, '2024-07-07 11:30:00', 25000, 65000, 40000),
(14, 14, 4, '2024-07-07 12:15:00', 22000, 80000, 58000),
(15, 15, 5, '2024-07-08 11:00:00', 7000, 30000, 23000),
(16, 1, 2, '2024-07-08 12:30:00', 5000, 35000, 30000),
(17, 2, 3, '2024-07-09 11:15:00', 18000, 65000, 47000),
(18, 3, 4, '2024-07-09 12:00:00', 24000, 12000, -12000),
(19, 4, 5, '2024-07-10 11:30:00', 12000, 75000, 63000),
(20, 5, 1, '2024-07-10 12:15:00', 15000, 37000, 22000),
(21, 6, 2, '2024-08-01 11:00:00', 10000, 48000, 38000),
(22, 7, 3, '2024-08-01 12:30:00', 15000, 28000, 13000),
(23, 8, 4, '2024-08-02 11:15:00', 14000, 65000, 51000),
(24, 9, 5, '2024-08-02 12:00:00', 10000, 26000, 16000),
(25, 10, 1, '2024-08-03 11:30:00', 12000, 60000, 48000),
(26, 11, 2, '2024-08-03 12:15:00', 8000, 12000, 4000),
(27, 12, 3, '2024-08-04 11:00:00', 20000, 47000, 27000),
(28, 13, 4, '2024-08-04 12:30:00', 15000, 40000, 25000),
(29, 14, 5, '2024-08-05 11:15:00', 10000, 58000, 48000),
(30, 15, 1, '2024-08-05 12:00:00', 13000, 23000, 10000);

INSERT INTO DetailTransaksi (id_transaksi, id_menu, kuantitas, harga_satuan, subtotal) VALUES
(1, 1, 1, 15000, 15000),
(2, 6, 1, 10000, 10000),
(3, 11, 1, 18000, 18000),
(4, 16, 1, 15000, 15000),
(5, 21, 1, 8000, 8000),
(6, 2, 1, 12000, 12000),
(7, 8, 1, 7000, 7000),
(8, 12, 1, 20000, 20000),
(9, 17, 1, 14000, 14000),
(10, 22, 1, 10000, 10000),
(11, 3, 1, 13000, 13000),
(12, 7, 1, 8000, 8000),
(13, 13, 1, 25000, 25000),
(14, 18, 1, 22000, 22000),
(15, 23, 1, 7000, 7000),
(16, 10, 1, 3000, 3000),
(16, 9, 1, 5000, 5000),
(17, 11, 1, 18000, 18000),
(18, 19, 1, 24000, 24000),
(19, 24, 1, 12000, 12000),
(20, 1, 1, 15000, 15000),
(21, 6, 1, 10000, 10000),
(22, 15, 1, 15000, 15000),
(23, 17, 1, 14000, 14000),
(24, 22, 1, 10000, 10000),
(25, 2, 1, 12000, 12000),
(26, 8, 1, 7000, 7000),
(27, 12, 1, 20000, 20000),
(28, 16, 1, 15000, 15000),
(29, 22, 1, 10000, 10000),
(30, 3, 1, 13000, 13000);


INSERT INTO Transaksi (id_transaksi, id_siswa, id_stan, tanggal, total, saldo_sebelum, saldo_sesudah) VALUES
(31, 1, 1, '2024-08-06 11:30:00', 27000, 30000, 3000),
(32, 4, 5, '2024-08-06 12:00:00', 22000, 63000, 41000),
(33, 6, 4, '2024-08-07 11:15:00', 36000, 38000, 2000),
(34, 10, 3, '2024-08-07 12:30:00', 45000, 48000, 3000),
(35, 13, 2, '2024-08-08 11:00:00', 15000, 25000, 10000);

INSERT INTO DetailTransaksi (id_transaksi, id_menu, kuantitas, harga_satuan, subtotal) VALUES
(31, 1, 1, 15000, 15000),
(31, 3, 1, 12000, 12000),
(32, 22, 1, 10000, 10000),
(32, 24, 1, 12000, 12000),
(33, 18, 1, 22000, 22000),
(33, 20, 1, 14000, 14000),
(34, 12, 1, 20000, 20000),
(34, 13, 1, 25000, 25000),
(35, 6, 1, 10000, 10000),
(35, 9, 1, 5000, 5000);


SELECT 'Stan' AS Tabel, COUNT(*) AS Jumlah FROM Stan
UNION ALL
SELECT 'Menu', COUNT(*) FROM Menu
UNION ALL
SELECT 'Siswa', COUNT(*) FROM Siswa
UNION ALL
SELECT 'OrangTua', COUNT(*) FROM OrangTua
UNION ALL
SELECT 'SiswaOrangTua', COUNT(*) FROM SiswaOrangTua
UNION ALL
SELECT 'TopUp', COUNT(*) FROM TopUp
UNION ALL
SELECT 'Transaksi', COUNT(*) FROM Transaksi
UNION ALL
SELECT 'DetailTransaksi', COUNT(*) FROM DetailTransaksi;