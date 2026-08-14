USE perpustakaan;

SELECT * FROM Anggota WHERE id_anggota = 1;
UPDATE Anggota SET status = 'nonaktif' WHERE id_anggota = 1;
SELECT * FROM Anggota WHERE id_anggota = 1;

SELECT * FROM Anggota WHERE id_anggota = 30;
DELETE FROM Anggota WHERE id_anggota = 30;

CREATE TABLE percobaan_update (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(50),
    saldo INT DEFAULT 0
);
INSERT INTO percobaan_update (nama, saldo) VALUES
('Andi', 100000),
('Budi', 50000),
('Cici', 75000);
SELECT * FROM percobaan_update;
UPDATE percobaan_update SET saldo = 0;
SELECT * FROM percobaan_update;


UPDATE Anggota SET nama = 'Salah' WHERE id_anggota = 1;
SELECT * FROM Anggota WHERE id_anggota = 1;
UPDATE Anggota SET nama = 'Andi Pratama' WHERE id_anggota = 1;