
CREATE SCHEMA Sigorta;

CREATE TABLE Sigorta.M��TER� (
    M��teriID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    Eposta VARCHAR(100),
    Telefon VARCHAR(20)
);

CREATE TABLE Sigorta.HESAP (
    HesapID INT PRIMARY KEY,
    M��teriID INT,
    HesapTipi VARCHAR(50),
    FinansalBilgi TEXT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID)
);
CREATE TABLE Sigorta.S�GORTA_T�R� (
    T�rID INT PRIMARY KEY,
    Ad VARCHAR(100),
    A��klama TEXT
);
CREATE TABLE Sigorta.POL��E (
    Poli�eID INT PRIMARY KEY,
    M��teriID INT,
    PrimTutari DECIMAL(10,2),
    BaslangicTarihi DATE,
    BitisTarihi DATE,
    SigortaT�rID INT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (SigortaT�rID) REFERENCES Sigorta.S�GORTA_T�R�(T�rID)
);

CREATE TABLE Sigorta.POL��E_NOTLARI (
    NotID INT PRIMARY KEY,
    Poli�eID INT,
    A��klama TEXT,
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);

CREATE TABLE Sigorta.�ZELPOL��E (
    �zelPoli�eID INT PRIMARY KEY,
    Poli�eID INT,
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);

CREATE TABLE Sigorta.TEM�NAT (
    TeminatID INT PRIMARY KEY,
    Poli�eID INT,
    Limit DECIMAL(10,2),
    A��klama TEXT,
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);
CREATE TABLE Sigorta.TEM�NAT_B�LG�LER� (
    BilgiID INT PRIMARY KEY,
    TeminatID INT,
    Detay TEXT,
    FOREIGN KEY (TeminatID) REFERENCES Sigorta.TEM�NAT(TeminatID)
);

CREATE TABLE Sigorta.TEM�NAT_GEC�KMES� (
    TeminatGecikmeID INT PRIMARY KEY,
    TeminatID INT,
    Bor� DECIMAL(10,2),
    GecikmeNedeni TEXT,
    FaizOran� DECIMAL(5,2),
    CezaOran� DECIMAL(5,2),
    FOREIGN KEY (TeminatID) REFERENCES Sigorta.TEM�NAT(TeminatID)
);


CREATE TABLE Sigorta.HASAR_KAYDI (
    HasarID INT PRIMARY KEY,
    Poli�eID INT,
    Durum VARCHAR(50),
    A��klama TEXT,
    Tarih DATE,
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);


CREATE TABLE Sigorta.HASAR_DE�ERLEND�RME (
    De�erlendirmeID INT PRIMARY KEY,
    HasarID INT,
    PersonelID INT,
    Sonu� TEXT,
	EklenenNot TEXT
    FOREIGN KEY (HasarID) REFERENCES Sigorta.HASAR_KAYDI(HasarID),
    FOREIGN KEY (PersonelID) REFERENCES Sigorta.PERSONEL(PersonelID)
);

CREATE TABLE Sigorta.PERSONEL (
    PersonelID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    G�rev VARCHAR(100)
);

CREATE TABLE Sigorta.PERSONEL_PERFORMANSI (
    PerformansID INT PRIMARY KEY,
    PersonelID INT,
    Tarih DATE,
    A��klama TEXT,
    Puan INT,
    FOREIGN KEY (PersonelID) REFERENCES Sigorta.PERSONEL(PersonelID)
);

CREATE TABLE Sigorta.�DEME (
    �demeID INT PRIMARY KEY,
    Poli�eID INT,
    Tutar DECIMAL(10,2),
    Tarih DATE,
    Y�ntem VARCHAR(50),
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);

CREATE TABLE Sigorta.PR�M_GEC�KMES� (
    GecikmeID INT PRIMARY KEY,
    Poli�eID INT,
    Tarih DATE,
    GecikmeNedeni TEXT,
    FaizOran� DECIMAL(5,2),
    CezaOran� DECIMAL(5,2),
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);

CREATE TABLE Sigorta.PR�M_�DEMES� (
    Prim�demeID INT PRIMARY KEY,
    GecikmeID INT,
    �demeID INT,
    FOREIGN KEY (GecikmeID) REFERENCES Sigorta.PR�M_GEC�KMES�(GecikmeID),
    FOREIGN KEY (�demeID) REFERENCES Sigorta.�DEME(�demeID)
);

CREATE TABLE Sigorta.KAMPANYA (
    KampanyaID INT PRIMARY KEY,
    Ad VARCHAR(100),
    A��klama TEXT,
    Ba�lang��Tarihi DATE,
    Biti�Tarihi DATE
);

CREATE TABLE Sigorta.KAMPANYAPUAN (
    PuanID INT PRIMARY KEY,
    M��teriID INT,
    KampanyaID INT,
    Puan INT,
    Yorum TEXT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (KampanyaID) REFERENCES Sigorta.KAMPANYA(KampanyaID)
);

CREATE TABLE Sigorta.�UBE (
    �ubeID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Adres TEXT
);

CREATE TABLE Sigorta.SORUMLU (
    SorumluID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    G�rev VARCHAR(100)
);

CREATE TABLE Sigorta.BAY� (
    BayiID INT PRIMARY KEY,
    �ubeID INT,
    Ad VARCHAR(100),
    Adres TEXT,
    SorumluID INT,
    FOREIGN KEY (�ubeID) REFERENCES Sigorta.�UBE(�ubeID),
    FOREIGN KEY (SorumluID) REFERENCES Sigorta.SORUMLU(SorumluID)
);

-------------------------------------
--veri ekleme
INSERT INTO Sigorta.M��TER� (M��teriID, Ad, Soyad, Eposta, Telefon) VALUES
(1, 'Ahmet', 'Y�lmaz', 'ahmet.yilmaz@email.com', '0530-111-1111'),
(2, 'Ay�e', 'Kaya', 'ayse.kaya@email.com', '0532-222-2222'),
(3, 'Mehmet', 'Demir', 'mehmet.demir@email.com', '0541-333-3333'),
(4, 'Elif', '�elik', 'elif.celik@email.com', '0553-444-4444'),
(5, 'Burak', 'Ayd�n', 'burak.aydin@email.com', '0531-555-5555'),
(6, 'Fatma', '�zt�rk', 'fatma.ozturk@email.com', '0543-666-6666'),
(7, 'Hasan', '�ahin', 'hasan.sahin@email.com', '0554-777-7777'),
(8, 'Zeynep', 'Ko�', 'zeynep.koc@email.com', '0535-888-8888'),
(9, 'Emre', 'G�ler', 'emre.guler@email.com', '0546-999-9999'),
(10, 'Merve', 'Eren', 'merve.eren@email.com', '0534-000-0000');

INSERT INTO Sigorta.HESAP (HesapID, M��teriID, HesapTipi, FinansalBilgi) VALUES
(1, 1, 'Bireysel Sigorta Hesab�', '�zel m��teri sigorta bilgileri.'),
(2, 2, 'Ara� Sigorta Hesab�', 'Kasko ve trafik sigorta planlar� i�erir.'),
(3, 3, 'Ev Sigorta Hesab�', 'Konut ve e�ya koruma poli�eleri.'),
(4, 4, 'Sa�l�k Sigorta Hesab�', '�zel hastane masraflar�n� kapsar.'),
(5, 5, 'Bireysel Sigorta Hesab�', 'Bireysel teminatlar ve ek avantajlar.'),
(6, 6, 'Hayat Sigorta Hesab�', 'Uzun vadeli finansal g�vence ve destek.'),
(7, 7, 'Kasko Sigorta Hesab�', 'Ara� g�venli�i, hasar koruma planlar�.'),
(8, 8, 'Deprem Sigorta Hesab�', 'Do�al afet risklerine kar�� koruma sa�lar.'),
(9, 9, '��yeri Sigorta Hesab�', '�irket ve ticari m�lk teminatlar�n� i�erir.'),
(10, 10, 'Elektronik Cihaz Sigorta Hesab�', 'Bilgisayar, telefon gibi cihazlar i�in sigorta.');


INSERT INTO Sigorta.S�GORTA_T�R� (T�rID, Ad, A��klama) VALUES
(1, 'Ara� Sigortas�', 'Motorlu ta��tlar i�in sigorta.'),
(2, 'Ev Sigortas�', 'Konutlar i�in g�vence sa�lar.'),
(3, 'Sa�l�k Sigortas�', 'T�bbi giderleri kar��lar.'),
(4, 'Hayat Sigortas�', 'Hayati risklere kar�� koruma.'),
(5, 'Seyahat Sigortas�', 'Yurt i�i ve yurt d��� seyahatlerde g�vence.'),
(6, '��yeri Sigortas�', '�irketleri ve ofisleri korur.'),
(7, 'Kasko Sigortas�', 'Ara�lar i�in ek teminat sa�lar.'),
(8, 'E�itim Sigortas�', '��renciler ve e�itim giderleri i�in sigorta.'),
(9, 'Deprem Sigortas�', 'Deprem hasarlar�na kar�� koruma.'),
(10, 'Elektronik Cihaz Sigortas�', 'Bilgisayar, telefon gibi cihazlar� kapsar.');


INSERT INTO Sigorta.POL��E (Poli�eID, M��teriID, PrimTutari, BaslangicTarihi, BitisTarihi, SigortaT�rID) VALUES
(1, 1, 5000.00, '2025-01-01', '2026-01-01', 1),
(2, 2, 3000.00, '2025-02-15', '2026-02-15', 2),
(3, 3, 7000.00, '2025-03-10', '2026-03-10', 3),
(4, 4, 2500.00, '2025-04-05', '2026-04-05', 1),
(5, 5, 4500.00, '2025-05-20', '2026-05-20', 2),
(6, 6, 6000.00, '2025-06-30', '2026-06-30', 4),
(7, 7, 3500.00, '2025-07-25', '2026-07-25', 1),
(8, 8, 8000.00, '2025-08-18', '2026-08-18', 5),
(9, 9, 4000.00, '2025-09-12', '2026-09-12', 2),
(10, 10, 9000.00, '2025-10-01', '2026-10-01', 6);

SELECT * FROM Sigorta.TEM�NAT;
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'POL��E_TEM�NAT';
INSERT INTO Sigorta.TEM�NAT (TeminatID, Ad, A��klama) VALUES
(101, 'Kasko Teminat�', 'Ara� sigortas� kapsam�nda ek koruma sa�lar.'),
(102, 'Yang�n Teminat�', 'Ev sigortas� kapsam�nda yang�n hasarlar�n� kar��lar.'),
(103, 'Sa�l�k Teminat�', 'Sa�l�k sigortas� ile hastane giderlerini kapsar.'),
(104, 'Seyahat Teminat�', 'Yurt i�i ve yurt d��� seyahat sigorta teminatlar�.'),
(105, 'Deprem Teminat�', 'Do�al afetlere kar�� sigorta kapsam�.');
ALTER TABLE Sigorta.POL��E_TEM�NAT DROP CONSTRAINT FK__POL��E_TE__Temin__07C12930;
ALTER TABLE Sigorta.POL��E_TEM�NAT 
ADD CONSTRAINT FK__POL��E_TE__Temin__07C12930 
FOREIGN KEY (TeminatID) REFERENCES Sigorta.TEM�NAT(TeminatID);


INSERT INTO Sigorta.HASAR_KAYDI (HasarID, Poli�eID, Durum, A��klama, Tarih) VALUES
(1, 1, 'Tamamland�', 'K���k �apl� ara� hasar�.', '2025-02-10'),
(2, 2, 'Devam Ediyor', 'Evde su s�z�nt�s�.', '2025-03-15'),
(3, 3, 'Tamamland�', 'Hastane masraflar�.', '2025-04-20'),
(4, 5, '�nceleme A�amas�nda', 'Yang�n sonucu hasar.', '2025-05-05'),
(5, 6, 'Tamamland�', 'Hayat sigortas� �demesi.', '2025-06-12'),
(6, 7, 'Devam Ediyor', 'Ara� motor ar�zas�.', '2025-07-01'),
(7, 8, 'Tamamland�', 'Seyahat iptali.', '2025-08-08'),
(8, 9, '�nceleme A�amas�nda', 'Deprem sonras� bina hasar�.', '2025-09-18'),
(9, 10, 'Tamamland�', 'Elektronik cihaz sigortas� kapsam�nda.', '2025-10-20'),
(10, 4, 'Devam Ediyor', 'Kasko hasar�.', '2025-11-25');

INSERT INTO Sigorta.HASAR_DETAY (DetayID, HasarID, A��klama) VALUES
(1, 1, 'Ara� �arpma sonucu hasar olu�tu.'),
(2, 2, 'Evde yang�n hasar� meydana geldi.'),
(3, 3, 'Sa�l�k sigortas� kapsam�nda hastane masraflar� kar��land�.');

SELECT * FROM Sigorta.PERSONEL;
INSERT INTO Sigorta.PERSONEL (PersonelID, Ad, Soyad, G�rev) VALUES
(1, 'Ali', 'Kaplan', 'Hasar Uzman�'),
(2, 'Deniz', 'Y�ld�z', 'Sigorta Eksperi'),
(3, 'Mehmet', 'Ko�', 'De�erlendirme Uzman�'),
(4, 'Zeynep', 'Ayd�n', '�nceleme G�revlisi'),
(5, 'Burak', 'Demir', 'Finans Analisti'),
(6, 'Elif', '�elik', 'Sigorta Dan��man�'),
(7, 'Ahmet', '�ahin', 'Kapsam Uzman�'),
(8, 'Fatma', '�zt�rk', 'Hasar Analisti'),
(9, 'Emre', 'G�ler', 'Risk De�erlendirme'),
(10, 'Merve', 'Eren', 'Poli�e Kontrol Uzman�');

INSERT INTO Sigorta.HASAR_DE�ERLEND�RME (De�erlendirmeID, HasarID, PersonelID, Sonu�, EklenenNot) VALUES
(1, 1, 3, '�deme yap�ld�.', 'Hasar onar�ld�, m��teri memnun.'),
(2, 2, 4, 'Tespit tamamland�.', 'Su tesisat� tamiri yap�lmal�.'),
(3, 3, 5, '�deme yap�ld�.', 'Hastane giderleri kar��land�.'),
(4, 5, 6, '�deme s�recinde.', 'Yang�n sebebi ara�t�r�l�yor.'),
(5, 6, 7, 'Ekspertiz yap�ld�.', 'Motor de�i�imi gereklili�i belirlendi.'),
(6, 7, 8, '�deme yap�ld�.', 'Seyahat iptal tazminat� �dendi.'),
(7, 8, 9, 'Beklemede.', 'Deprem hasar tespiti yap�l�yor.'),
(8, 9, 10, 'Tamamland�.', 'Elektronik cihaz yenisiyle de�i�tirildi.'),
(9, 10, 2, '�nceleme s�r�yor.', 'Kasko kapsam�nda de�erlendirme yap�l�yor.'),
(10, 4, 1, '�deme s�recinde.', 'Onar�m i�lemleri ba�lat�ld�.');

INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem) VALUES
(1, 1, 5000.00, '2025-02-12', 'Banka Transferi'),
(2, 2, 3000.00, '2025-03-17', 'Kredi Kart�'),
(3, 3, 7000.00, '2025-04-22', 'Nakit'),
(4, 4, 2500.00, '2025-05-07', 'Banka Transferi'),
(5, 5, 4500.00, '2025-06-15', 'Kredi Kart�'),
(6, 6, 6000.00, '2025-07-02', 'Nakit'),
(7, 7, 3500.00, '2025-08-10', 'Banka Transferi'),
(8, 8, 8000.00, '2025-09-20', 'Kredi Kart�'),
(9, 9, 4000.00, '2025-10-15', 'Nakit'),
(10, 10, 9000.00, '2025-11-01', 'Banka Transferi');


INSERT INTO Sigorta.PR�M_GEC�KMES� (GecikmeID, Poli�eID, Tarih, GecikmeNedeni, FaizOran�, CezaOran�) VALUES
(1, 1, '2025-02-15', '�deme gecikmesi', 5.00, 2.00),
(2, 2, '2025-03-20', 'Kredi kart� sorunu', 4.50, 1.50),
(3, 5, '2025-06-17', 'Banka i�lemleri aksad�', 3.00, 1.00),
(4, 7, '2025-08-12', 'M��teri unutmu�', 6.00, 2.50),
(5, 8, '2025-09-22', 'Seyahat nedeniyle gecikti', 4.00, 1.75);

INSERT INTO Sigorta.�UBE (�ubeID, Ad, Adres) VALUES
(1, '�stanbul �ubesi', 'Beyo�lu, �stanbul'),
(2, 'Ankara �ubesi', 'K�z�lay, Ankara'),
(3, '�zmir �ubesi', 'Alsancak, �zmir'),
(4, 'Antalya �ubesi', 'Lara, Antalya'),
(5, 'Bursa �ubesi', 'Nil�fer, Bursa');

SELECT * FROM Sigorta.SORUMLU;
INSERT INTO Sigorta.SORUMLU (SorumluID, Ad, Soyad, G�rev) VALUES
(1, 'Ali', 'Kaplan', 'Bayi M�d�r�'),
(2, 'Deniz', 'Y�ld�z', 'Bayi Y�neticisi'),
(3, 'Mehmet', 'Ko�', 'Sat�� Sorumlusu'),
(4, 'Zeynep', 'Ayd�n', 'Operasyon M�d�r�'),
(5, 'Burak', 'Demir', 'Sigorta Dan��man�');

INSERT INTO Sigorta.BAY� (BayiID, �ubeID, Ad, Adres, SorumluID) VALUES
(1, 1, '�stanbul Ana Bayi', 'Kad�k�y, �stanbul', 1),
(2, 2, 'Ankara Bayi', '�ankaya, Ankara', 2),
(3, 3, '�zmir Bayi', 'Konak, �zmir', 3),
(4, 4, 'Antalya Bayi', 'Konyaalt�, Antalya', 4),
(5, 5, 'Bursa Bayi', 'Osmangazi, Bursa', 5);

INSERT INTO Sigorta.BAY� (BayiID, �ubeID, Ad, Adres, SorumluID) VALUES
(6, 1, '�stanbul Ana Bayi', 'Kad�k�y, �stanbul', 1),
(7, 1, '�stanbul Ana Bayi', 'Kad�k�y, �stanbul', 1),
(8, 2, 'Ankara Bayi', '�ankaya, Ankara', 2),
(9, 2, 'Ankara Bayi', '�ankaya, Ankara', 2),
(10, 3, '�zmir Bayi', 'Konak, �zmir', 3),
(11, 4, 'Antalya Bayi', 'Konyaalt�, Antalya', 4),
(12, 4, 'Antalya Bayi', 'Konyaalt�, Antalya', 4),
(13, 5, 'Bursa Bayi', 'Osmangazi, Bursa', 5),
(14, 5, 'Bursa Bayi', 'Osmangazi, Bursa', 5);

--1.Normalizasyon tablolar�
INSERT INTO Sigorta.M��TER�_HESAP (ID, M��teriID, HesapTipi) VALUES
(1, 1, 'Bireysel Sigorta Hesab�'),
(2, 2, 'Ara� Sigorta Hesab�'),
(3, 3, 'Ev Sigorta Hesab�'),
(4, 4, 'Sa�l�k Sigorta Hesab�'),
(5, 5, 'Bireysel Sigorta Hesab�'),
(6, 6, 'Hayat Sigorta Hesab�'),
(7, 7, 'Kasko Sigorta Hesab�'),
(8, 8, 'Deprem Sigorta Hesab�'),
(9, 9, '��yeri Sigorta Hesab�'),
(10, 10, 'Elektronik Cihaz Sigorta Hesab�');
CREATE TABLE Sigorta.M��TER�_HESAP (
    ID INT PRIMARY KEY,
    M��teriID INT,
    HesapTipi VARCHAR(50),
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID)
);

select*from Sigorta.M��TER�_HESAP
--2nf si
CREATE TABLE Sigorta.HESAP_T�P� (
    HesapTipiID INT PRIMARY KEY,
    HesapTipi VARCHAR(50)
);


CREATE TABLE Sigorta.M��TER�_HESAP_2NF (
    ID INT PRIMARY KEY,
    M��teriID INT,
    HesapTipiID INT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (HesapTipiID) REFERENCES Sigorta.HESAP_T�P�(HesapTipiID)
);

INSERT INTO Sigorta.HESAP_T�P� (HesapTipiID, HesapTipi) VALUES
(1, 'Bireysel Sigorta Hesab�'),
(2, 'Ara� Sigorta Hesab�'),
(3, 'Ev Sigorta Hesab�'),
(4, 'Sa�l�k Sigorta Hesab�'),
(5, 'Hayat Sigorta Hesab�'),
(6, 'Kasko Sigorta Hesab�'),
(7, 'Deprem Sigorta Hesab�'),
(8, '��yeri Sigorta Hesab�'),
(9, 'Elektronik Cihaz Sigorta Hesab�');
INSERT INTO Sigorta.M��TER�_HESAP_2NF (ID, M��teriID, HesapTipiID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 1),
(6, 6, 5),
(7, 7, 6),
(8, 8, 7),
(9, 9, 8),
(10, 10, 9);

SELECT * FROM Sigorta.M��TER�_HESAP_2NF;
SELECT * FROM Sigorta.HESAP_T�P�;
---3nf 
CREATE TABLE Sigorta.HESAP_DETAY (
    HesapID INT PRIMARY KEY,
    HesapTipiID INT,
    A��klama TEXT,
    FOREIGN KEY (HesapTipiID) REFERENCES Sigorta.HESAP_T�P�(HesapTipiID)
);
CREATE TABLE Sigorta.M��TER�_HESAP_3NF (
    ID INT PRIMARY KEY,
    M��teriID INT,
    HesapID INT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (HesapID) REFERENCES Sigorta.HESAP_DETAY(HesapID)
);
INSERT INTO Sigorta.HESAP_DETAY (HesapID, HesapTipiID, A��klama) VALUES
(1, 1, 'Bireysel sigorta kapsam�nda sa�l�k ve hayat g�vencesi sa�lar.'),
(2, 2, 'Ara� sigortas�, kasko ve trafik sigortas�n� kapsar.'),
(3, 3, 'Ev sigortas�, konut ve e�ya koruma sa�lar.'),
(4, 4, 'Sa�l�k sigortas�, �zel hastane giderlerini kar��lar.'),
(5, 5, 'Hayat sigortas�, uzun vadeli finansal g�vence sunar.');

INSERT INTO Sigorta.HASAR_KAYDI_TAR�H (KayitID, HasarID, Tarih) VALUES
(1, 1, '2025-02-10'),
(2, 2, '2025-03-15'),
(3, 3, '2025-04-20');

INSERT INTO Sigorta.M��TER�_HESAP_3NF (ID, M��teriID, HesapID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 1);

select* from Sigorta.M��TER�
SELECT*FROM Sigorta.HESAP
SELECT * FROM Sigorta.M��TER�_HESAP;
SELECT * FROM Sigorta.M��TER�_HESAP_2NF;
SELECT * FROM Sigorta.M��TER�_HESAP_3NF;

------------------------------------------
--1.NF
CREATE TABLE Sigorta.HASAR_KAYDI_1NF (
    HasarID INT PRIMARY KEY,
    Poli�eID INT,
    Tarih DATE
);
SELECT HasarID, Poli�eID, Tarih FROM Sigorta.HASAR_KAYDI;
--2.NF
CREATE TABLE Sigorta.HASAR_DURUM (
    DurumID INT PRIMARY KEY,
    DurumAd� VARCHAR(50)
);
SELECT DISTINCT Durum FROM Sigorta.HASAR_KAYDI;

CREATE TABLE Sigorta.HASAR_A�IKLAMA (
    A��klamaID INT PRIMARY KEY,
    A��klama TEXT
);

CREATE TABLE Sigorta.HASAR_KAYDI_2NF (
    HasarID INT PRIMARY KEY,
    Poli�eID INT,
    Tarih DATE,
    DurumID INT,
    A��klamaID INT,
    FOREIGN KEY (DurumID) REFERENCES Sigorta.HASAR_DURUM(DurumID),
    FOREIGN KEY (A��klamaID) REFERENCES Sigorta.HASAR_A�IKLAMA(A��klamaID)
);
--3.NF
CREATE TABLE Sigorta.DURUM_KATEGOR� (
    KategoriID INT PRIMARY KEY,
    KategoriAd� VARCHAR(50)
);
CREATE TABLE Sigorta.HASAR_KAYDI_3NF (
    HasarID INT PRIMARY KEY,
    Poli�eID INT,
    Tarih DATE,
    A��klamaID INT,
    KategoriID INT,
    FOREIGN KEY (A��klamaID) REFERENCES Sigorta.HASAR_A�IKLAMA(A��klamaID),
    FOREIGN KEY (KategoriID) REFERENCES Sigorta.DURUM_KATEGOR�(KategoriID)
);
SELECT * FROM Sigorta.HASAR_KAYDI;
SELECT* FROM Sigorta.HASAR_KAYDI_1NF
SELECT * FROM Sigorta.HASAR_KAYDI_2NF

SELECT * FROM Sigorta.DURUM_KATEGOR�

SELECT * FROM Sigorta.HASAR_KAYDI_3NF 

-----------------------------
---�deme ile ilgili normalizasyon
--1.normalizasyon
CREATE TABLE Sigorta.�DEME_1NF (
    �demeID INT PRIMARY KEY,
    M��teriID INT,
    �demeTarihi DATE,
    Tutar DECIMAL(10,2),
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID)
);--y�ntem sutununu kald�rd�k
CREATE TABLE Sigorta.�DEME_Y�NTEMLER� (
    �demeY�ntemID INT PRIMARY KEY,
    �demeID INT,
    Y�ntem VARCHAR(50),
    FOREIGN KEY (�demeID) REFERENCES Sigorta.�DEME_1NF(�demeID)
);--her �deme y�ntemi art�k ba��ms�z bir tabloda saklanacak
--2.normalizasyon
CREATE TABLE Sigorta.�DEME_T�P� (
    �demeTipiID INT PRIMARY KEY,
    TipAd� VARCHAR(50)
);--�deme y�ntemlerini kategorize etmek i�in tablo olu�turduk
CREATE TABLE Sigorta.�DEME_Y�NTEMLER�_2NF (
    �demeY�ntemID INT PRIMARY KEY,
    �demeID INT,
    �demeTipiID INT,
    FOREIGN KEY (�demeID) REFERENCES Sigorta.�DEME_1NF(�demeID),
    FOREIGN KEY (�demeTipiID) REFERENCES Sigorta.�DEME_T�P�(�demeTipiID)
);-- �deme y�ntemlerini bir kategoriye ba�lad�k
--3.normalizasyon
CREATE TABLE Sigorta.�DEME_STAT�S� (
    Stat�ID INT PRIMARY KEY,
    Stat�Ad� VARCHAR(50)
);--ek bilgileri ayr� bir tabloya ta��d�k

CREATE TABLE Sigorta.�DEME_3NF (
    �demeID INT PRIMARY KEY,
    M��teriID INT,
    �demeTarihi DATE,
    Tutar DECIMAL(10,2),
    Stat�ID INT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (Stat�ID) REFERENCES Sigorta.�DEME_STAT�S�(Stat�ID)
);--son hailyle �demeler daha ba��ms�z hale geldi.

SELECT * FROM Sigorta.�DEME;
SELECT * FROM Sigorta.�DEME_1NF;
SELECT * FROM Sigorta.�DEME_Y�NTEMLER�;
SELECT * FROM Sigorta.�DEME_Y�NTEMLER�_2NF;
SELECT * FROM Sigorta.�DEME_T�P�;
SELECT * FROM Sigorta.�DEME_3NF;
SELECT * FROM Sigorta.�DEME_STAT�S�;

----------
--bayi i�in normalizasyon
SELECT * FROM Sigorta.BAY� ORDER BY Ad;

--1NF
CREATE TABLE Sigorta.BAY�_1NF (
    BayiID INT PRIMARY KEY,
    �ubeID INT,
    Ad VARCHAR(100),
    Adres VARCHAR(255),
    SorumluID INT,
    FOREIGN KEY (�ubeID) REFERENCES Sigorta.�UBE(�ubeID),
    FOREIGN KEY (SorumluID) REFERENCES Sigorta.SORUMLU(SorumluID)
);
SELECT * FROM Sigorta.BAY�_1NF;
--2.NF
CREATE TABLE Sigorta.�UBE_T�P� (
    �ubeTipiID INT PRIMARY KEY,
    �ubeTipi VARCHAR(50)
);

CREATE TABLE Sigorta.BAY�_3NF (
    BayiID INT PRIMARY KEY,
    �ubeID INT,
    Ad VARCHAR(100),
    Adres VARCHAR(255),
    SorumluID INT,
    �ubeTipiID INT,
    FOREIGN KEY (�ubeID) REFERENCES Sigorta.�UBE(�ubeID),
    FOREIGN KEY (SorumluID) REFERENCES Sigorta.SORUMLU(SorumluID),
    FOREIGN KEY (�ubeTipiID) REFERENCES Sigorta.�UBE_T�P�(�ubeTipiID)
);
SELECT * FROM Sigorta.BAY�_1NF;

--2.nf i�in
SELECT * FROM Sigorta.�UBE_T�P�;
SELECT * FROM Sigorta.SORUMLU;

--3.nf i�in
SELECT * FROM Sigorta.BAY�_3NF;
SELECT * FROM Sigorta.�UBE_T�P�;
SELECT * FROM Sigorta.SORUMLU;


SELECT * FROM Sigorta.BAY�
---------------------------------------------------
INSERT INTO Sigorta.BAY�_1NF (BayiID, �ubeID, Ad, Adres, SorumluID)
SELECT BayiID, �ubeID, Ad, Adres, SorumluID FROM Sigorta.BAY�;

SELECT * FROM Sigorta.BAY�_1NF;

INSERT INTO Sigorta.�UBE_T�P� (�ubeTipiID, �ubeTipi)
SELECT DISTINCT �ubeID, 'B�lge Bayi' FROM Sigorta.BAY� WHERE Ad LIKE '%Ana Bayi%'
UNION ALL
SELECT DISTINCT �ubeID, '�ube Bayi' FROM Sigorta.BAY� WHERE Ad NOT LIKE '%Ana Bayi%';
SELECT * FROM Sigorta.�UBE_T�P�;

INSERT INTO Sigorta.BAY�_3NF (BayiID, �ubeID, Ad, Adres, SorumluID, �ubeTipiID)
SELECT b.BayiID, b.�ubeID, b.Ad, b.Adres, b.SorumluID, st.�ubeTipiID
FROM Sigorta.BAY� b
LEFT JOIN Sigorta.�UBE_T�P� st ON b.�ubeID = st.�ubeTipiID;

SELECT * FROM Sigorta.BAY�_3NF;

-------
--temel sorgular
SELECT * FROM Sigorta.M��TER�;
SELECT * FROM Sigorta.HESAP;
SELECT * FROM Sigorta.S�GORTA_T�R�;
SELECT * FROM Sigorta.POL��E;
SELECT * FROM Sigorta.POL��E_NOTLARI;
SELECT * FROM Sigorta.�ZELPOL��E;
SELECT * FROM Sigorta.TEM�NAT;
SELECT * FROM Sigorta.TEM�NAT_B�LG�LER�;
SELECT * FROM Sigorta.TEM�NAT_GEC�KMES�;
SELECT * FROM Sigorta.HASAR_KAYDI;
SELECT * FROM Sigorta.HASAR_DE�ERLEND�RME;
SELECT * FROM Sigorta.PERSONEL;
SELECT * FROM Sigorta.PERSONEL_PERFORMANSI;
SELECT * FROM Sigorta.�DEME;
SELECT * FROM Sigorta.PR�M_GEC�KMES�;
SELECT * FROM Sigorta.PR�M_�DEMES�;
SELECT * FROM Sigorta.KAMPANYA;
SELECT * FROM Sigorta.KAMPANYAPUAN;
SELECT * FROM Sigorta.�UBE;
SELECT * FROM Sigorta.SORUMLU;
SELECT * FROM Sigorta.BAY�;


SELECT * FROM Sigorta.�DEME WHERE Poli�eID = 1;

---eklenenler

CREATE TABLE SigortaT�P� (
    SigortaTipiID INT PRIMARY KEY,
    HesapTipi VARCHAR(50),
    FinansalBilgi TEXT
);

CREATE TABLE Sigorta.HESAP2 (
    HesapID INT PRIMARY KEY,
    M��teriID INT,
    SigortaTipiID INT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (SigortaTipiID) REFERENCES SigortaT�P�(SigortaTipiID)
);
CREATE TABLE SigortaDetaylar� (
    SigortaDetayID INT PRIMARY KEY,
    SigortaTipiID INT,
    DetayBilgi TEXT,
    FOREIGN KEY (SigortaTipiID) REFERENCES SigortaT�P�(SigortaTipiID)
);


Select * from SigortaT�P� 
select * from Sigorta.HESAP2 
select * from SigortaDetaylar�

----------------------------------------------------------

CREATE TABLE Sigorta.POL��E2 (
    Poli�eID INT PRIMARY KEY,
    M��teriID INT,
    SigortaT�rID INT,
    FOREIGN KEY (M��teriID) REFERENCES Sigorta.M��TER�(M��teriID),
    FOREIGN KEY (SigortaT�rID) REFERENCES Sigorta.S�GORTA_T�R�(T�rID)
);

CREATE TABLE Sigorta.POL��E_DETAY (
    DetayID INT PRIMARY KEY,
    Poli�eID INT,
    PrimTutari DECIMAL(10,2),
    BaslangicTarihi DATE,
    BitisTarihi DATE,
    FOREIGN KEY (Poli�eID) REFERENCES Sigorta.POL��E(Poli�eID)
);
select * from Sigorta.POL��E
select * from Sigorta.POL��E2
select * from Sigorta.POL��E_DETAY
-------------------------------------------

----TRIGGER EKLEME
CREATE TRIGGER trg_G�ncellemePrimGecikme
ON Sigorta.�DEME
AFTER INSERT
AS
BEGIN
    UPDATE Sigorta.PR�M_GEC�KMES�
    SET GecikmeNedeni = '�deme Yap�ld�', FaizOran� = 0, CezaOran� = 0
    WHERE Poli�eID IN (SELECT Poli�eID FROM inserted);
	PRINT 'Trigger �al��t�: Prim gecikmesi �deme yap�ld��� i�in g�ncellendi.';
END;



INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem)
VALUES (11, 1, 5000.00, '2025-02-16', 'Banka Transferi');
SELECT * FROM Sigorta.PR�M_GEC�KMES� WHERE Poli�eID = 1;

INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem)
VALUES (12, 3, 7000.00, '2025-05-25', 'Banka Transferi');

INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem)
VALUES (13, 7, 3500.00, '2025-06-10', 'Kredi Kart�');
SELECT * FROM Sigorta.PR�M_GEC�KMES� WHERE Poli�eID = 7;

INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem)
VALUES (14, 5, 4500.00, '2025-07-05', 'Banka Transferi');
SELECT * FROM Sigorta.PR�M_GEC�KMES� WHERE Poli�eID = 5;

INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem) 
VALUES (15, 9, 4000.00, '2025-08-15', 'Nakit');
SELECT * FROM Sigorta.PR�M_GEC�KMES� WHERE Poli�eID = 9;


--INSERT INTO Sigorta.�DEME (�demeID, Poli�eID, Tutar, Tarih, Y�ntem) 
--VALUES (16, 2, 3000.00, '2025-09-30', 'Kredi Kart�');

--SELECT * FROM Sigorta.PR�M_GEC�KMES� WHERE Poli�eID = 2;
---------------------------------------
---PROCEDURE EKLEME
CREATE PROCEDURE sp_GetM��teriSigortaBilgileri
    @M��teriID INT
AS
BEGIN
    SELECT M.Ad, M.Soyad, P.Poli�eID, P.PrimTutari, P.BaslangicTarihi, P.BitisTarihi, S.Ad AS SigortaT�r�
    FROM Sigorta.M��TER� M
    INNER JOIN Sigorta.POL��E P ON M.M��teriID = P.M��teriID
    INNER JOIN Sigorta.S�GORTA_T�R� S ON P.SigortaT�rID = S.T�rID
    WHERE M.M��teriID = @M��teriID;
END;


EXEC sp_GetM��teriSigortaBilgileri @M��teriID = 3;
