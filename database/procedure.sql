USE CATADOPT;

-- DROP PROCEDURE --------------------------------------------------------------------------

-- Drop procedure TambahKucing
DROP PROCEDURE TambahKucing;
GO

-- Drop procedure TambahPembeli
DROP PROCEDURE TambahPembeli;
GO

-- Drop procedure InsertTransaksi
DROP PROCEDURE InsertTransaksi;
GO

-- Drop procedure InsertDetailTransaksi
DROP PROCEDURE InsertDetailTransaksi;
GO

-- Drop procedure TambahJenis
DROP PROCEDURE TambahJenis;
GO

-- Drop procedure TambahJenisPengiriman
DROP PROCEDURE TambahJenisPengiriman;
GO

-- Drop procedure TambahMetodePembayaran
DROP PROCEDURE TambahMetodePembayaran;
GO

-- Drop procedure HapusKucing
DROP PROCEDURE HapusKucing;
GO

-- Drop procedure HapusPembeli
DROP PROCEDURE HapusPembeli;
GO

-- Drop procedure HapusTransaksi
DROP PROCEDURE HapusTransaksi;
GO

-- Drop procedure HapusJenisKucing
DROP PROCEDURE HapusJenisKucing;
GO

-- Drop procedure HapusJenisPengiriman
DROP PROCEDURE HapusJenisPengiriman;
GO

-- Drop procedure HapusMetodePembayaran
DROP PROCEDURE HapusMetodePembayaran;
GO

-- Drop procedure UpdateKucing
DROP PROCEDURE UpdateKucing;
GO

-- Drop procedure UpdatePembeli
DROP PROCEDURE UpdatePembeli;
GO

-- Drop procedure UpdateJenis
DROP PROCEDURE UpdateJenis;
GO

-- Drop procedure UpdateJenisPengiriman
DROP PROCEDURE UpdateJenisPengiriman;
GO

-- Drop procedure UpdateMetodePembayaran
DROP PROCEDURE UpdateMetodePembayaran;
GO


--INSERT-----------------------------------------------------------------------------------------------------------------------------------------------------

--Menambahkan data kucing baru ke dalam sistem
CREATE PROCEDURE TambahKucing
	@ID_Kucing VARCHAR(50),
    @ID_Jenis VARCHAR(50),
    @Nama_Kucing VARCHAR(50),
    @Foto VARCHAR(100),
    @Umur SMALLINT,
    @Jenis_Kelamin VARCHAR(6),
    @Tanggal_Masuk DATE,
    @Biaya DECIMAL,
    @Status VARCHAR(10),
    @Keterangan TEXT
AS
BEGIN
	INSERT INTO Kucing (ID_Kucing, ID_Jenis, Nama_Kucing, Foto, Umur, Jenis_Kelamin, Tanggal_Masuk, Biaya, Status, Keterangan) VALUES
	(@ID_Kucing, @ID_Jenis, @Nama_Kucing, @Foto, @Umur, @Jenis_Kelamin, @Tanggal_Masuk, @Biaya, @Status, @Keterangan);
END;

-- Contoh cara pake e
EXEC TambahKucing 'K1', 'J1', 'Fluffy', 'fluffy.jpg', 2, 'Betina', '2023-12-09', 50.00, 'Tersedia', 'Friendly and playful cat';


--Menambahkan data pembeli baru ke dalam sistem
CREATE PROCEDURE TambahPembeli
	@ID_Pembeli VARCHAR(50),
    @Nama_Pembeli VARCHAR(100),
    @Email NVARCHAR(255),
    @No_Telp VARCHAR(15),
    @Alamat TEXT
AS
BEGIN
	INSERT INTO Pembeli (ID_Pembeli, Nama_Pembeli, Email, No_Telp, Alamat) VALUES
	(@ID_Pembeli, @Nama_Pembeli, @Email, @No_Telp, @Alamat);
END;

--Menambahkan data transaksi baru ke dalam sistem
CREATE PROCEDURE InsertTransaksi
    @ID_Transaksi VARCHAR(50),
    @ID_Pembeli VARCHAR(50),
    @ID_Jenis_Pengiriman VARCHAR(50),
    @ID_Metode_Pembayaran VARCHAR(50),
    @Nomor_Resi VARCHAR(30),
    @Tanggal_Transaksi DATE,
    @Pesan TEXT
AS
BEGIN
    INSERT INTO Transaksi (ID_Transaksi, ID_Pembeli, ID_Jenis_Pengiriman, ID_Metode_Pembayaran, Nomor_Resi, Tanggal_Transaksi, Pesan)
    VALUES (@ID_Transaksi, @ID_Pembeli, @ID_Jenis_Pengiriman, @ID_Metode_Pembayaran, @Nomor_Resi, @Tanggal_Transaksi, @Pesan);
END;

CREATE PROCEDURE InsertDetailTransaksi
    @ID_Detail_Transaksi VARCHAR(50),
    @ID_Transaksi VARCHAR(50),
    @ID_Kucing VARCHAR(50)
AS
BEGIN
    INSERT INTO Detail_Transaksi (ID_Detail_Transaksi, ID_Transaksi, ID_Kucing)
    VALUES (@ID_Detail_Transaksi, @ID_Transaksi, @ID_Kucing);
	UPDATE Transaksi SET Total_Biaya = dbo.HitungTotal(@ID_Transaksi) WHERE ID_Transaksi = @ID_Transaksi;
END;


--Menambahkan data jenis kucing baru ke dalam sistem
CREATE PROCEDURE TambahJenis
    @ID_Jenis VARCHAR(50),
    @Jenis_Kucing VARCHAR(50)
AS
BEGIN
    INSERT INTO Jenis (ID_Jenis, Jenis_Kucing)
    VALUES (@ID_Jenis, @Jenis_Kucing);
END;

--Menambahkan data jenis pengiriman baru ke dalam sistem
CREATE PROCEDURE TambahJenisPengiriman
    @ID_Jenis_Pengiriman VARCHAR(50),
    @Jenis_Pengiriman VARCHAR(20)
AS
BEGIN
    INSERT INTO Jenis_Pengiriman (ID_Jenis_Pengiriman, Jenis_Pengiriman)
    VALUES (@ID_Jenis_Pengiriman, @Jenis_Pengiriman);
END;

--Menambahkan data metode pembayaran baru ke dalam sistem
CREATE PROCEDURE TambahMetodePembayaran
    @ID_Metode_Pembayaran VARCHAR(50),
    @Metode_Pembayaran VARCHAR(20)
AS
BEGIN
    INSERT INTO Metode_Pembayaran (ID_Metode_Pembayaran, Metode_Pembayaran)
    VALUES (@ID_Metode_Pembayaran, @Metode_Pembayaran);
END;


--DELETE-----------------------------------------------------------------------------------------------------------------------------------------------------

--Menghapus data kucing dalam sistem
CREATE PROCEDURE HapusKucing
	@ID_Kucing VARCHAR(50)
AS
BEGIN
	DELETE FROM Kucing WHERE ID_Kucing = @ID_Kucing;
END;

--Menghapus data pembeli dalam sistem
CREATE PROCEDURE HapusPembeli
	@ID_Pembeli VARCHAR(50)
AS
BEGIN
	DELETE FROM Pembeli WHERE ID_Pembeli = @ID_Pembeli;
END;

--Menghapus data transaksi dalam sistem
CREATE PROCEDURE HapusTransaksi
	@ID_Transaksi VARCHAR(50)
AS
BEGIN
	DELETE FROM Transaksi  WHERE ID_Transaksi = @ID_Transaksi;
	DELETE FROM Detail_Transaksi WHERE ID_Transaksi = @ID_Transaksi;
END;

--Menghapus data jenis kucing dalam sistem
CREATE PROCEDURE HapusJenisKucing
	@ID_Jenis VARCHAR(50)
AS
BEGIN
	DELETE FROM Jenis WHERE ID_Jenis = @ID_Jenis;
END;

--Menghapus data jenis pengiriman dalam sistem
CREATE PROCEDURE HapusJenisPengiriman
    @ID_Jenis_Pengiriman VARCHAR(50)
AS
BEGIN
    DELETE FROM Jenis_Pengiriman
    WHERE ID_Jenis_Pengiriman = @ID_Jenis_Pengiriman;
END;

--Menghapus data metode pembayaran dalam sistem
CREATE PROCEDURE HapusMetodePembayaran
    @ID_Metode_Pembayaran VARCHAR(50)
AS
BEGIN
    DELETE FROM Metode_Pembayaran
    WHERE ID_Metode_Pembayaran = @ID_Metode_Pembayaran;
END;



--UPDATE-----------------------------------------------------------------------------------------------------------------------------------------------------

--Mengupdate data kucing dalam sistem
CREATE PROCEDURE UpdateKucing
    @ID_Kucing VARCHAR(50),
    @ID_Jenis VARCHAR(50),
    @Nama_Kucing VARCHAR(50),
    @Foto VARCHAR(100),
    @Umur SMALLINT,
    @Jenis_Kelamin VARCHAR(6),
    @Tanggal_Masuk DATE,
    @Biaya DECIMAL,
    @Status VARCHAR(10),
    @Keterangan TEXT
AS
BEGIN
    UPDATE Kucing
    SET 
        ID_Jenis = @ID_Jenis,
        Nama_Kucing = @Nama_Kucing,
        Foto = @Foto,
        Umur = @Umur,
        Jenis_Kelamin = @Jenis_Kelamin,
        Tanggal_Masuk = @Tanggal_Masuk,
        Biaya = @Biaya,
        Status = @Status,
        Keterangan = @Keterangan
    WHERE ID_Kucing = @ID_Kucing;
END;

--Mengupdate data pembeli dalam sistem
CREATE PROCEDURE UpdatePembeli
    @ID_Pembeli VARCHAR(50),
    @Nama_Pembeli VARCHAR(100),
    @Email NVARCHAR(255),
    @No_Telp VARCHAR(15),
    @Alamat TEXT
AS
BEGIN
    UPDATE Pembeli
    SET 
        Nama_Pembeli = @Nama_Pembeli,
        Email = @Email,
        No_Telp = @No_Telp,
        Alamat = @Alamat
    WHERE ID_Pembeli = @ID_Pembeli;
END;


--Mengupdate data transaksi ke dalam sistem
CREATE PROCEDURE UpdateTransaksi
    @ID_Transaksi VARCHAR(50),
    @ID_Pembeli VARCHAR(50),
    @ID_Jenis_Pengiriman VARCHAR(50),
    @ID_Metode_Pembayaran VARCHAR(50),
    @Nomor_Resi VARCHAR(30),
    @Tanggal_Transaksi DATE,
    @Pesan TEXT
AS
BEGIN
    UPDATE Transaksi
    SET 
        ID_Pembeli = @ID_Pembeli,
        ID_Jenis_Pengiriman = @ID_Jenis_Pengiriman,
        ID_Metode_Pembayaran = @ID_Metode_Pembayaran,
        Nomor_Resi = @Nomor_Resi,
        Tanggal_Transaksi = @Tanggal_Transaksi,
        Pesan = @Pesan
    WHERE ID_Transaksi = @ID_Transaksi;
END;

CREATE PROCEDURE UpdateDetailTransaksi
    @ID_Detail_Transaksi VARCHAR(50),
    @ID_Transaksi VARCHAR(50),
    @ID_Kucing VARCHAR(50)
AS
BEGIN
    UPDATE Detail_Transaksi
    SET 
        ID_Transaksi = @ID_Transaksi,
        ID_Kucing = @ID_Kucing
    WHERE ID_Detail_Transaksi = @ID_Detail_Transaksi;

    UPDATE Transaksi
    SET Total_Biaya = dbo.HitungTotal(@ID_Transaksi)
    WHERE ID_Transaksi = @ID_Transaksi;
END;

--Mengupdate data jenis kucing ke dalam sistem
CREATE PROCEDURE UpdateJenis
    @ID_Jenis VARCHAR(50),
    @Jenis_Kucing VARCHAR(50)
AS
BEGIN
    UPDATE Jenis
    SET 
        Jenis_Kucing = @Jenis_Kucing
    WHERE ID_Jenis = @ID_Jenis;
END;

--Mengupdate data jenis pengiriman ke dalam sistem
CREATE PROCEDURE UpdateJenisPengiriman
    @ID_Jenis_Pengiriman VARCHAR(50),
    @Jenis_Pengiriman VARCHAR(20)
AS
BEGIN
    UPDATE Jenis_Pengiriman
    SET 
        Jenis_Pengiriman = @Jenis_Pengiriman
    WHERE ID_Jenis_Pengiriman = @ID_Jenis_Pengiriman;
END;

--Mengupdate data metode pembayaran ke dalam sistem
CREATE PROCEDURE UpdateMetodePembayaran
    @ID_Metode_Pembayaran VARCHAR(50),
    @Metode_Pembayaran VARCHAR(20)
AS
BEGIN
	UPDATE Metode_Pembayaran
    SET 
        Metode_Pembayaran = @Metode_Pembayaran
    WHERE ID_Metode_Pembayaran = @ID_Metode_Pembayaran;
END;

