\# Tugas Relasi Database Northwind



\## Definisi Konsep (Versi Saya)



\- \*\*Primary Key\*\*: Kolom (atau gabungan kolom) yang nilainya unik untuk setiap baris, berfungsi sebagai identitas utama sebuah tabel.

\- \*\*Foreign Key\*\*: Kolom di satu tabel yang merujuk ke Primary Key tabel lain, berfungsi sebagai "penghubung" antartabel dan menjaga integritas data.

\- \*\*One-to-Many\*\*: Relasi di mana satu data di tabel A bisa terkait dengan banyak data di tabel B, tapi satu data di tabel B hanya terkait dengan satu data di tabel A.

\- \*\*Many-to-Many\*\*: Relasi di mana satu data di tabel A bisa terkait dengan banyak data di tabel B, dan sebaliknya. Diimplementasikan pakai tabel perantara (junction table).



\---



\## Daftar Relasi Northwind (≥8)



| Sisi Satu | Sisi Banyak | Melalui Kolom Foreign Key |

| :--- | :--- | :--- |

| `Customers` | `Orders` | `Orders.CustomerID` |

| `Employees` | `Orders` | `Orders.EmployeeID` |

| `Shippers` | `Orders` | `Orders.ShipperID` |

| `Orders` | `Order Details` | `Order Details.OrderID` |

| `Products` | `Order Details` | `Order Details.ProductID` |

| `Suppliers` | `Products` | `Products.SupplierID` |

| `Employees` | `Employee Privileges` | `Employee Privileges.EmployeeID` |

| `Privileges` | `Employee Privileges` | `Employee Privileges.PrivilegeID` |



\---



\## Jawaban 3 Pertanyaan tentang `Order Details`



1\. Apa Primary Key tabel ini?

Bukan satu kolom\*\*, tapi \*\*gabungan (Composite Key)\*\* dari dua kolom: \*\*`OrderID` dan `ProductID`\*\*. Karena satu Order bisa berisi banyak produk, dan satu produk bisa muncul di banyak Order, kombinasi keduanya memastikan setiap baris unik.



2\. Kenapa tidak pakai ProductID1, ProductID2,... di tabel `Orders`?

Masalahnya:

\- Tidak Fleksibel\*\*: Order bisa punya 1 produk, 10, atau 100 produk. Jumlah kolom dibatasi di awal, jadi tidak bisa mengakomodasi.

\- Boros \& Tidak Normal\*\*: Banyak kolom akan kosong, menyia-nyiakan ruang penyimpanan.

\- Sulit Diproses\*\*: Query untuk mencari produk tertentu di semua Order akan sangat rumit karena harus cek banyak kolom.

Konsep ini adalah \*\*prinsip desain database\*\*, dan solusi standarnya adalah menggunakan \*\*tabel perantara\*\* (junction table), yaitu `Order Details` di sini.



3\. Kenapa ada `UnitPrice` di `Order Details` padahal sudah ada di `Products`?

Ini sengaja untuk menjaga data historis transaksi:

\- Jika kita selalu ambil harga dari tabel `Products`, maka ketika harga produk naik tahun depan, semua data pesanan lama ikut berubah.

\- Dengan menyimpan harga di `Order Details`, harga saat transaksi terjadi "dibekukan" (membekukan harga). Order yang lalu tetap memakai harga lama, sementara order baru memakai harga terbaru.











\## Uji Diri: Jelaskan Foreign Key

"Foreign key itu seperti 'kartu anggota' di sebuah tabel. Kartu ini berisi nomor identitas yang mengacu ke tabel lain. Dengan kartu ini, kita tahu bahwa satu data di tabel A, misalnya 'Pelanggan X', berhubungan dengan beberapa data di tabel B, misalnya beberapa pesanan yang dia buat."



\---



\## Uji Diri: Sebutkan Relasi

\- One-to-many: `Customers` dengan `Orders` (satu pelanggan bisa punya banyak pesanan).

\- Many-to-many: `Orders` dengan `Products` (satu pesanan bisa berisi banyak produk, satu produk bisa dipesan di banyak pesanan). Relasi ini diwujudkan melalui tabel `Order Details`.

