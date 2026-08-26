SELECT 
    a.id_anggota,
    a.nama_anggota,
    CASE 
        WHEN p.id_anggota IS NOT NULL THEN 'PERNAH PINJAM'
        ELSE 'BELUM PERNAH'
    END AS status
FROM anggota a
LEFT JOIN (
    SELECT DISTINCT id_anggota 
    FROM peminjaman
) p ON a.id_anggota = p.id_anggota;



SELECT a.nama_anggota, p.id_pinjam
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota;