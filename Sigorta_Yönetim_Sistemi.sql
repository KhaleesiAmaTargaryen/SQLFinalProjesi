
CREATE SCHEMA Sigorta;

CREATE TABLE Sigorta.MÜÞTERÝ (
    MüþteriID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    Eposta VARCHAR(100),
    Telefon VARCHAR(20)
);

CREATE TABLE Sigorta.HESAP (
    HesapID INT PRIMARY KEY,
    MüþteriID INT,
    HesapTipi VARCHAR(50),
    FinansalBilgi TEXT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID)
);
CREATE TABLE Sigorta.SÝGORTA_TÜRÜ (
    TürID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Açýklama TEXT
);
CREATE TABLE Sigorta.POLÝÇE (
    PoliçeID INT PRIMARY KEY,
    MüþteriID INT,
    PrimTutari DECIMAL(10,2),
    BaslangicTarihi DATE,
    BitisTarihi DATE,
    SigortaTürID INT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (SigortaTürID) REFERENCES Sigorta.SÝGORTA_TÜRÜ(TürID)
);

CREATE TABLE Sigorta.POLÝÇE_NOTLARI (
    NotID INT PRIMARY KEY,
    PoliçeID INT,
    Açýklama TEXT,
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);

CREATE TABLE Sigorta.ÖZELPOLÝÇE (
    ÖzelPoliçeID INT PRIMARY KEY,
    PoliçeID INT,
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);

CREATE TABLE Sigorta.TEMÝNAT (
    TeminatID INT PRIMARY KEY,
    PoliçeID INT,
    Limit DECIMAL(10,2),
    Açýklama TEXT,
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);
CREATE TABLE Sigorta.TEMÝNAT_BÝLGÝLERÝ (
    BilgiID INT PRIMARY KEY,
    TeminatID INT,
    Detay TEXT,
    FOREIGN KEY (TeminatID) REFERENCES Sigorta.TEMÝNAT(TeminatID)
);

CREATE TABLE Sigorta.TEMÝNAT_GECÝKMESÝ (
    TeminatGecikmeID INT PRIMARY KEY,
    TeminatID INT,
    Borç DECIMAL(10,2),
    GecikmeNedeni TEXT,
    FaizOraný DECIMAL(5,2),
    CezaOraný DECIMAL(5,2),
    FOREIGN KEY (TeminatID) REFERENCES Sigorta.TEMÝNAT(TeminatID)
);


CREATE TABLE Sigorta.HASAR_KAYDI (
    HasarID INT PRIMARY KEY,
    PoliçeID INT,
    Durum VARCHAR(50),
    Açýklama TEXT,
    Tarih DATE,
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);


CREATE TABLE Sigorta.HASAR_DEÐERLENDÝRME (
    DeðerlendirmeID INT PRIMARY KEY,
    HasarID INT,
    PersonelID INT,
    Sonuç TEXT,
	EklenenNot TEXT
    FOREIGN KEY (HasarID) REFERENCES Sigorta.HASAR_KAYDI(HasarID),
    FOREIGN KEY (PersonelID) REFERENCES Sigorta.PERSONEL(PersonelID)
);

CREATE TABLE Sigorta.PERSONEL (
    PersonelID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    Görev VARCHAR(100)
);

CREATE TABLE Sigorta.PERSONEL_PERFORMANSI (
    PerformansID INT PRIMARY KEY,
    PersonelID INT,
    Tarih DATE,
    Açýklama TEXT,
    Puan INT,
    FOREIGN KEY (PersonelID) REFERENCES Sigorta.PERSONEL(PersonelID)
);

CREATE TABLE Sigorta.ÖDEME (
    ÖdemeID INT PRIMARY KEY,
    PoliçeID INT,
    Tutar DECIMAL(10,2),
    Tarih DATE,
    Yöntem VARCHAR(50),
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);

CREATE TABLE Sigorta.PRÝM_GECÝKMESÝ (
    GecikmeID INT PRIMARY KEY,
    PoliçeID INT,
    Tarih DATE,
    GecikmeNedeni TEXT,
    FaizOraný DECIMAL(5,2),
    CezaOraný DECIMAL(5,2),
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);

CREATE TABLE Sigorta.PRÝM_ÖDEMESÝ (
    PrimÖdemeID INT PRIMARY KEY,
    GecikmeID INT,
    ÖdemeID INT,
    FOREIGN KEY (GecikmeID) REFERENCES Sigorta.PRÝM_GECÝKMESÝ(GecikmeID),
    FOREIGN KEY (ÖdemeID) REFERENCES Sigorta.ÖDEME(ÖdemeID)
);

CREATE TABLE Sigorta.KAMPANYA (
    KampanyaID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Açýklama TEXT,
    BaþlangýçTarihi DATE,
    BitiþTarihi DATE
);

CREATE TABLE Sigorta.KAMPANYAPUAN (
    PuanID INT PRIMARY KEY,
    MüþteriID INT,
    KampanyaID INT,
    Puan INT,
    Yorum TEXT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (KampanyaID) REFERENCES Sigorta.KAMPANYA(KampanyaID)
);

CREATE TABLE Sigorta.ÞUBE (
    ÞubeID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Adres TEXT
);

CREATE TABLE Sigorta.SORUMLU (
    SorumluID INT PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    Görev VARCHAR(100)
);

CREATE TABLE Sigorta.BAYÝ (
    BayiID INT PRIMARY KEY,
    ÞubeID INT,
    Ad VARCHAR(100),
    Adres TEXT,
    SorumluID INT,
    FOREIGN KEY (ÞubeID) REFERENCES Sigorta.ÞUBE(ÞubeID),
    FOREIGN KEY (SorumluID) REFERENCES Sigorta.SORUMLU(SorumluID)
);

-------------------------------------
--veri ekleme
INSERT INTO Sigorta.MÜÞTERÝ (MüþteriID, Ad, Soyad, Eposta, Telefon) VALUES
(1, 'Ahmet', 'Yýlmaz', 'ahmet.yilmaz@email.com', '0530-111-1111'),
(2, 'Ayþe', 'Kaya', 'ayse.kaya@email.com', '0532-222-2222'),
(3, 'Mehmet', 'Demir', 'mehmet.demir@email.com', '0541-333-3333'),
(4, 'Elif', 'Çelik', 'elif.celik@email.com', '0553-444-4444'),
(5, 'Burak', 'Aydýn', 'burak.aydin@email.com', '0531-555-5555'),
(6, 'Fatma', 'Öztürk', 'fatma.ozturk@email.com', '0543-666-6666'),
(7, 'Hasan', 'Þahin', 'hasan.sahin@email.com', '0554-777-7777'),
(8, 'Zeynep', 'Koç', 'zeynep.koc@email.com', '0535-888-8888'),
(9, 'Emre', 'Güler', 'emre.guler@email.com', '0546-999-9999'),
(10, 'Merve', 'Eren', 'merve.eren@email.com', '0534-000-0000');

INSERT INTO Sigorta.HESAP (HesapID, MüþteriID, HesapTipi, FinansalBilgi) VALUES
(1, 1, 'Bireysel Sigorta Hesabý', 'Özel müþteri sigorta bilgileri.'),
(2, 2, 'Araç Sigorta Hesabý', 'Kasko ve trafik sigorta planlarý içerir.'),
(3, 3, 'Ev Sigorta Hesabý', 'Konut ve eþya koruma poliçeleri.'),
(4, 4, 'Saðlýk Sigorta Hesabý', 'Özel hastane masraflarýný kapsar.'),
(5, 5, 'Bireysel Sigorta Hesabý', 'Bireysel teminatlar ve ek avantajlar.'),
(6, 6, 'Hayat Sigorta Hesabý', 'Uzun vadeli finansal güvence ve destek.'),
(7, 7, 'Kasko Sigorta Hesabý', 'Araç güvenliði, hasar koruma planlarý.'),
(8, 8, 'Deprem Sigorta Hesabý', 'Doðal afet risklerine karþý koruma saðlar.'),
(9, 9, 'Ýþyeri Sigorta Hesabý', 'Þirket ve ticari mülk teminatlarýný içerir.'),
(10, 10, 'Elektronik Cihaz Sigorta Hesabý', 'Bilgisayar, telefon gibi cihazlar için sigorta.');


INSERT INTO Sigorta.SÝGORTA_TÜRÜ (TürID, Ad, Açýklama) VALUES
(1, 'Araç Sigortasý', 'Motorlu taþýtlar için sigorta.'),
(2, 'Ev Sigortasý', 'Konutlar için güvence saðlar.'),
(3, 'Saðlýk Sigortasý', 'Týbbi giderleri karþýlar.'),
(4, 'Hayat Sigortasý', 'Hayati risklere karþý koruma.'),
(5, 'Seyahat Sigortasý', 'Yurt içi ve yurt dýþý seyahatlerde güvence.'),
(6, 'Ýþyeri Sigortasý', 'Þirketleri ve ofisleri korur.'),
(7, 'Kasko Sigortasý', 'Araçlar için ek teminat saðlar.'),
(8, 'Eðitim Sigortasý', 'Öðrenciler ve eðitim giderleri için sigorta.'),
(9, 'Deprem Sigortasý', 'Deprem hasarlarýna karþý koruma.'),
(10, 'Elektronik Cihaz Sigortasý', 'Bilgisayar, telefon gibi cihazlarý kapsar.');


INSERT INTO Sigorta.POLÝÇE (PoliçeID, MüþteriID, PrimTutari, BaslangicTarihi, BitisTarihi, SigortaTürID) VALUES
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

SELECT * FROM Sigorta.TEMÝNAT;
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'POLÝÇE_TEMÝNAT';
INSERT INTO Sigorta.TEMÝNAT (TeminatID, Ad, Açýklama) VALUES
(101, 'Kasko Teminatý', 'Araç sigortasý kapsamýnda ek koruma saðlar.'),
(102, 'Yangýn Teminatý', 'Ev sigortasý kapsamýnda yangýn hasarlarýný karþýlar.'),
(103, 'Saðlýk Teminatý', 'Saðlýk sigortasý ile hastane giderlerini kapsar.'),
(104, 'Seyahat Teminatý', 'Yurt içi ve yurt dýþý seyahat sigorta teminatlarý.'),
(105, 'Deprem Teminatý', 'Doðal afetlere karþý sigorta kapsamý.');
ALTER TABLE Sigorta.POLÝÇE_TEMÝNAT DROP CONSTRAINT FK__POLÝÇE_TE__Temin__07C12930;
ALTER TABLE Sigorta.POLÝÇE_TEMÝNAT 
ADD CONSTRAINT FK__POLÝÇE_TE__Temin__07C12930 
FOREIGN KEY (TeminatID) REFERENCES Sigorta.TEMÝNAT(TeminatID);


INSERT INTO Sigorta.HASAR_KAYDI (HasarID, PoliçeID, Durum, Açýklama, Tarih) VALUES
(1, 1, 'Tamamlandý', 'Küçük çaplý araç hasarý.', '2025-02-10'),
(2, 2, 'Devam Ediyor', 'Evde su sýzýntýsý.', '2025-03-15'),
(3, 3, 'Tamamlandý', 'Hastane masraflarý.', '2025-04-20'),
(4, 5, 'Ýnceleme Aþamasýnda', 'Yangýn sonucu hasar.', '2025-05-05'),
(5, 6, 'Tamamlandý', 'Hayat sigortasý ödemesi.', '2025-06-12'),
(6, 7, 'Devam Ediyor', 'Araç motor arýzasý.', '2025-07-01'),
(7, 8, 'Tamamlandý', 'Seyahat iptali.', '2025-08-08'),
(8, 9, 'Ýnceleme Aþamasýnda', 'Deprem sonrasý bina hasarý.', '2025-09-18'),
(9, 10, 'Tamamlandý', 'Elektronik cihaz sigortasý kapsamýnda.', '2025-10-20'),
(10, 4, 'Devam Ediyor', 'Kasko hasarý.', '2025-11-25');

INSERT INTO Sigorta.HASAR_DETAY (DetayID, HasarID, Açýklama) VALUES
(1, 1, 'Araç çarpma sonucu hasar oluþtu.'),
(2, 2, 'Evde yangýn hasarý meydana geldi.'),
(3, 3, 'Saðlýk sigortasý kapsamýnda hastane masraflarý karþýlandý.');

SELECT * FROM Sigorta.PERSONEL;
INSERT INTO Sigorta.PERSONEL (PersonelID, Ad, Soyad, Görev) VALUES
(1, 'Ali', 'Kaplan', 'Hasar Uzmaný'),
(2, 'Deniz', 'Yýldýz', 'Sigorta Eksperi'),
(3, 'Mehmet', 'Koç', 'Deðerlendirme Uzmaný'),
(4, 'Zeynep', 'Aydýn', 'Ýnceleme Görevlisi'),
(5, 'Burak', 'Demir', 'Finans Analisti'),
(6, 'Elif', 'Çelik', 'Sigorta Danýþmaný'),
(7, 'Ahmet', 'Þahin', 'Kapsam Uzmaný'),
(8, 'Fatma', 'Öztürk', 'Hasar Analisti'),
(9, 'Emre', 'Güler', 'Risk Deðerlendirme'),
(10, 'Merve', 'Eren', 'Poliçe Kontrol Uzmaný');

INSERT INTO Sigorta.HASAR_DEÐERLENDÝRME (DeðerlendirmeID, HasarID, PersonelID, Sonuç, EklenenNot) VALUES
(1, 1, 3, 'Ödeme yapýldý.', 'Hasar onarýldý, müþteri memnun.'),
(2, 2, 4, 'Tespit tamamlandý.', 'Su tesisatý tamiri yapýlmalý.'),
(3, 3, 5, 'Ödeme yapýldý.', 'Hastane giderleri karþýlandý.'),
(4, 5, 6, 'Ödeme sürecinde.', 'Yangýn sebebi araþtýrýlýyor.'),
(5, 6, 7, 'Ekspertiz yapýldý.', 'Motor deðiþimi gerekliliði belirlendi.'),
(6, 7, 8, 'Ödeme yapýldý.', 'Seyahat iptal tazminatý ödendi.'),
(7, 8, 9, 'Beklemede.', 'Deprem hasar tespiti yapýlýyor.'),
(8, 9, 10, 'Tamamlandý.', 'Elektronik cihaz yenisiyle deðiþtirildi.'),
(9, 10, 2, 'Ýnceleme sürüyor.', 'Kasko kapsamýnda deðerlendirme yapýlýyor.'),
(10, 4, 1, 'Ödeme sürecinde.', 'Onarým iþlemleri baþlatýldý.');

INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem) VALUES
(1, 1, 5000.00, '2025-02-12', 'Banka Transferi'),
(2, 2, 3000.00, '2025-03-17', 'Kredi Kartý'),
(3, 3, 7000.00, '2025-04-22', 'Nakit'),
(4, 4, 2500.00, '2025-05-07', 'Banka Transferi'),
(5, 5, 4500.00, '2025-06-15', 'Kredi Kartý'),
(6, 6, 6000.00, '2025-07-02', 'Nakit'),
(7, 7, 3500.00, '2025-08-10', 'Banka Transferi'),
(8, 8, 8000.00, '2025-09-20', 'Kredi Kartý'),
(9, 9, 4000.00, '2025-10-15', 'Nakit'),
(10, 10, 9000.00, '2025-11-01', 'Banka Transferi');


INSERT INTO Sigorta.PRÝM_GECÝKMESÝ (GecikmeID, PoliçeID, Tarih, GecikmeNedeni, FaizOraný, CezaOraný) VALUES
(1, 1, '2025-02-15', 'Ödeme gecikmesi', 5.00, 2.00),
(2, 2, '2025-03-20', 'Kredi kartý sorunu', 4.50, 1.50),
(3, 5, '2025-06-17', 'Banka iþlemleri aksadý', 3.00, 1.00),
(4, 7, '2025-08-12', 'Müþteri unutmuþ', 6.00, 2.50),
(5, 8, '2025-09-22', 'Seyahat nedeniyle gecikti', 4.00, 1.75);

INSERT INTO Sigorta.ÞUBE (ÞubeID, Ad, Adres) VALUES
(1, 'Ýstanbul Þubesi', 'Beyoðlu, Ýstanbul'),
(2, 'Ankara Þubesi', 'Kýzýlay, Ankara'),
(3, 'Ýzmir Þubesi', 'Alsancak, Ýzmir'),
(4, 'Antalya Þubesi', 'Lara, Antalya'),
(5, 'Bursa Þubesi', 'Nilüfer, Bursa');

SELECT * FROM Sigorta.SORUMLU;
INSERT INTO Sigorta.SORUMLU (SorumluID, Ad, Soyad, Görev) VALUES
(1, 'Ali', 'Kaplan', 'Bayi Müdürü'),
(2, 'Deniz', 'Yýldýz', 'Bayi Yöneticisi'),
(3, 'Mehmet', 'Koç', 'Satýþ Sorumlusu'),
(4, 'Zeynep', 'Aydýn', 'Operasyon Müdürü'),
(5, 'Burak', 'Demir', 'Sigorta Danýþmaný');

INSERT INTO Sigorta.BAYÝ (BayiID, ÞubeID, Ad, Adres, SorumluID) VALUES
(1, 1, 'Ýstanbul Ana Bayi', 'Kadýköy, Ýstanbul', 1),
(2, 2, 'Ankara Bayi', 'Çankaya, Ankara', 2),
(3, 3, 'Ýzmir Bayi', 'Konak, Ýzmir', 3),
(4, 4, 'Antalya Bayi', 'Konyaaltý, Antalya', 4),
(5, 5, 'Bursa Bayi', 'Osmangazi, Bursa', 5);

INSERT INTO Sigorta.BAYÝ (BayiID, ÞubeID, Ad, Adres, SorumluID) VALUES
(6, 1, 'Ýstanbul Ana Bayi', 'Kadýköy, Ýstanbul', 1),
(7, 1, 'Ýstanbul Ana Bayi', 'Kadýköy, Ýstanbul', 1),
(8, 2, 'Ankara Bayi', 'Çankaya, Ankara', 2),
(9, 2, 'Ankara Bayi', 'Çankaya, Ankara', 2),
(10, 3, 'Ýzmir Bayi', 'Konak, Ýzmir', 3),
(11, 4, 'Antalya Bayi', 'Konyaaltý, Antalya', 4),
(12, 4, 'Antalya Bayi', 'Konyaaltý, Antalya', 4),
(13, 5, 'Bursa Bayi', 'Osmangazi, Bursa', 5),
(14, 5, 'Bursa Bayi', 'Osmangazi, Bursa', 5);

--1.Normalizasyon tablolarý
INSERT INTO Sigorta.MÜÞTERÝ_HESAP (ID, MüþteriID, HesapTipi) VALUES
(1, 1, 'Bireysel Sigorta Hesabý'),
(2, 2, 'Araç Sigorta Hesabý'),
(3, 3, 'Ev Sigorta Hesabý'),
(4, 4, 'Saðlýk Sigorta Hesabý'),
(5, 5, 'Bireysel Sigorta Hesabý'),
(6, 6, 'Hayat Sigorta Hesabý'),
(7, 7, 'Kasko Sigorta Hesabý'),
(8, 8, 'Deprem Sigorta Hesabý'),
(9, 9, 'Ýþyeri Sigorta Hesabý'),
(10, 10, 'Elektronik Cihaz Sigorta Hesabý');
CREATE TABLE Sigorta.MÜÞTERÝ_HESAP (
    ID INT PRIMARY KEY,
    MüþteriID INT,
    HesapTipi VARCHAR(50),
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID)
);

select*from Sigorta.MÜÞTERÝ_HESAP
--2nf si
CREATE TABLE Sigorta.HESAP_TÝPÝ (
    HesapTipiID INT PRIMARY KEY,
    HesapTipi VARCHAR(50)
);


CREATE TABLE Sigorta.MÜÞTERÝ_HESAP_2NF (
    ID INT PRIMARY KEY,
    MüþteriID INT,
    HesapTipiID INT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (HesapTipiID) REFERENCES Sigorta.HESAP_TÝPÝ(HesapTipiID)
);

INSERT INTO Sigorta.HESAP_TÝPÝ (HesapTipiID, HesapTipi) VALUES
(1, 'Bireysel Sigorta Hesabý'),
(2, 'Araç Sigorta Hesabý'),
(3, 'Ev Sigorta Hesabý'),
(4, 'Saðlýk Sigorta Hesabý'),
(5, 'Hayat Sigorta Hesabý'),
(6, 'Kasko Sigorta Hesabý'),
(7, 'Deprem Sigorta Hesabý'),
(8, 'Ýþyeri Sigorta Hesabý'),
(9, 'Elektronik Cihaz Sigorta Hesabý');
INSERT INTO Sigorta.MÜÞTERÝ_HESAP_2NF (ID, MüþteriID, HesapTipiID) VALUES
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

SELECT * FROM Sigorta.MÜÞTERÝ_HESAP_2NF;
SELECT * FROM Sigorta.HESAP_TÝPÝ;
---3nf 
CREATE TABLE Sigorta.HESAP_DETAY (
    HesapID INT PRIMARY KEY,
    HesapTipiID INT,
    Açýklama TEXT,
    FOREIGN KEY (HesapTipiID) REFERENCES Sigorta.HESAP_TÝPÝ(HesapTipiID)
);
CREATE TABLE Sigorta.MÜÞTERÝ_HESAP_3NF (
    ID INT PRIMARY KEY,
    MüþteriID INT,
    HesapID INT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (HesapID) REFERENCES Sigorta.HESAP_DETAY(HesapID)
);
INSERT INTO Sigorta.HESAP_DETAY (HesapID, HesapTipiID, Açýklama) VALUES
(1, 1, 'Bireysel sigorta kapsamýnda saðlýk ve hayat güvencesi saðlar.'),
(2, 2, 'Araç sigortasý, kasko ve trafik sigortasýný kapsar.'),
(3, 3, 'Ev sigortasý, konut ve eþya koruma saðlar.'),
(4, 4, 'Saðlýk sigortasý, özel hastane giderlerini karþýlar.'),
(5, 5, 'Hayat sigortasý, uzun vadeli finansal güvence sunar.');

INSERT INTO Sigorta.HASAR_KAYDI_TARÝH (KayitID, HasarID, Tarih) VALUES
(1, 1, '2025-02-10'),
(2, 2, '2025-03-15'),
(3, 3, '2025-04-20');

INSERT INTO Sigorta.MÜÞTERÝ_HESAP_3NF (ID, MüþteriID, HesapID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 1);

select* from Sigorta.MÜÞTERÝ
SELECT*FROM Sigorta.HESAP
SELECT * FROM Sigorta.MÜÞTERÝ_HESAP;
SELECT * FROM Sigorta.MÜÞTERÝ_HESAP_2NF;
SELECT * FROM Sigorta.MÜÞTERÝ_HESAP_3NF;

------------------------------------------
--1.NF
CREATE TABLE Sigorta.HASAR_KAYDI_1NF (
    HasarID INT PRIMARY KEY,
    PoliçeID INT,
    Tarih DATE
);
SELECT HasarID, PoliçeID, Tarih FROM Sigorta.HASAR_KAYDI;
--2.NF
CREATE TABLE Sigorta.HASAR_DURUM (
    DurumID INT PRIMARY KEY,
    DurumAdý VARCHAR(50)
);
SELECT DISTINCT Durum FROM Sigorta.HASAR_KAYDI;

CREATE TABLE Sigorta.HASAR_AÇIKLAMA (
    AçýklamaID INT PRIMARY KEY,
    Açýklama TEXT
);

CREATE TABLE Sigorta.HASAR_KAYDI_2NF (
    HasarID INT PRIMARY KEY,
    PoliçeID INT,
    Tarih DATE,
    DurumID INT,
    AçýklamaID INT,
    FOREIGN KEY (DurumID) REFERENCES Sigorta.HASAR_DURUM(DurumID),
    FOREIGN KEY (AçýklamaID) REFERENCES Sigorta.HASAR_AÇIKLAMA(AçýklamaID)
);
--3.NF
CREATE TABLE Sigorta.DURUM_KATEGORÝ (
    KategoriID INT PRIMARY KEY,
    KategoriAdý VARCHAR(50)
);
CREATE TABLE Sigorta.HASAR_KAYDI_3NF (
    HasarID INT PRIMARY KEY,
    PoliçeID INT,
    Tarih DATE,
    AçýklamaID INT,
    KategoriID INT,
    FOREIGN KEY (AçýklamaID) REFERENCES Sigorta.HASAR_AÇIKLAMA(AçýklamaID),
    FOREIGN KEY (KategoriID) REFERENCES Sigorta.DURUM_KATEGORÝ(KategoriID)
);
SELECT * FROM Sigorta.HASAR_KAYDI;
SELECT* FROM Sigorta.HASAR_KAYDI_1NF
SELECT * FROM Sigorta.HASAR_KAYDI_2NF

SELECT * FROM Sigorta.DURUM_KATEGORÝ

SELECT * FROM Sigorta.HASAR_KAYDI_3NF 

-----------------------------
---ödeme ile ilgili normalizasyon
--1.normalizasyon
CREATE TABLE Sigorta.ÖDEME_1NF (
    ÖdemeID INT PRIMARY KEY,
    MüþteriID INT,
    ÖdemeTarihi DATE,
    Tutar DECIMAL(10,2),
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID)
);--yöntem sutununu kaldýrdýk
CREATE TABLE Sigorta.ÖDEME_YÖNTEMLERÝ (
    ÖdemeYöntemID INT PRIMARY KEY,
    ÖdemeID INT,
    Yöntem VARCHAR(50),
    FOREIGN KEY (ÖdemeID) REFERENCES Sigorta.ÖDEME_1NF(ÖdemeID)
);--her ödeme yöntemi artýk baðýmsýz bir tabloda saklanacak
--2.normalizasyon
CREATE TABLE Sigorta.ÖDEME_TÝPÝ (
    ÖdemeTipiID INT PRIMARY KEY,
    TipAdý VARCHAR(50)
);--ödeme yöntemlerini kategorize etmek için tablo oluþturduk
CREATE TABLE Sigorta.ÖDEME_YÖNTEMLERÝ_2NF (
    ÖdemeYöntemID INT PRIMARY KEY,
    ÖdemeID INT,
    ÖdemeTipiID INT,
    FOREIGN KEY (ÖdemeID) REFERENCES Sigorta.ÖDEME_1NF(ÖdemeID),
    FOREIGN KEY (ÖdemeTipiID) REFERENCES Sigorta.ÖDEME_TÝPÝ(ÖdemeTipiID)
);-- ödeme yöntemlerini bir kategoriye baðladýk
--3.normalizasyon
CREATE TABLE Sigorta.ÖDEME_STATÜSÜ (
    StatüID INT PRIMARY KEY,
    StatüAdý VARCHAR(50)
);--ek bilgileri ayrý bir tabloya taþýdýk

CREATE TABLE Sigorta.ÖDEME_3NF (
    ÖdemeID INT PRIMARY KEY,
    MüþteriID INT,
    ÖdemeTarihi DATE,
    Tutar DECIMAL(10,2),
    StatüID INT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (StatüID) REFERENCES Sigorta.ÖDEME_STATÜSÜ(StatüID)
);--son hailyle ödemeler daha baðýmsýz hale geldi.

SELECT * FROM Sigorta.ÖDEME;
SELECT * FROM Sigorta.ÖDEME_1NF;
SELECT * FROM Sigorta.ÖDEME_YÖNTEMLERÝ;
SELECT * FROM Sigorta.ÖDEME_YÖNTEMLERÝ_2NF;
SELECT * FROM Sigorta.ÖDEME_TÝPÝ;
SELECT * FROM Sigorta.ÖDEME_3NF;
SELECT * FROM Sigorta.ÖDEME_STATÜSÜ;

----------
--bayi için normalizasyon
SELECT * FROM Sigorta.BAYÝ ORDER BY Ad;

--1NF
CREATE TABLE Sigorta.BAYÝ_1NF (
    BayiID INT PRIMARY KEY,
    ÞubeID INT,
    Ad VARCHAR(100),
    Adres VARCHAR(255),
    SorumluID INT,
    FOREIGN KEY (ÞubeID) REFERENCES Sigorta.ÞUBE(ÞubeID),
    FOREIGN KEY (SorumluID) REFERENCES Sigorta.SORUMLU(SorumluID)
);
SELECT * FROM Sigorta.BAYÝ_1NF;
--2.NF
CREATE TABLE Sigorta.ÞUBE_TÝPÝ (
    ÞubeTipiID INT PRIMARY KEY,
    ÞubeTipi VARCHAR(50)
);

CREATE TABLE Sigorta.BAYÝ_3NF (
    BayiID INT PRIMARY KEY,
    ÞubeID INT,
    Ad VARCHAR(100),
    Adres VARCHAR(255),
    SorumluID INT,
    ÞubeTipiID INT,
    FOREIGN KEY (ÞubeID) REFERENCES Sigorta.ÞUBE(ÞubeID),
    FOREIGN KEY (SorumluID) REFERENCES Sigorta.SORUMLU(SorumluID),
    FOREIGN KEY (ÞubeTipiID) REFERENCES Sigorta.ÞUBE_TÝPÝ(ÞubeTipiID)
);
SELECT * FROM Sigorta.BAYÝ_1NF;

--2.nf için
SELECT * FROM Sigorta.ÞUBE_TÝPÝ;
SELECT * FROM Sigorta.SORUMLU;

--3.nf için
SELECT * FROM Sigorta.BAYÝ_3NF;
SELECT * FROM Sigorta.ÞUBE_TÝPÝ;
SELECT * FROM Sigorta.SORUMLU;


SELECT * FROM Sigorta.BAYÝ
---------------------------------------------------
INSERT INTO Sigorta.BAYÝ_1NF (BayiID, ÞubeID, Ad, Adres, SorumluID)
SELECT BayiID, ÞubeID, Ad, Adres, SorumluID FROM Sigorta.BAYÝ;

SELECT * FROM Sigorta.BAYÝ_1NF;

INSERT INTO Sigorta.ÞUBE_TÝPÝ (ÞubeTipiID, ÞubeTipi)
SELECT DISTINCT ÞubeID, 'Bölge Bayi' FROM Sigorta.BAYÝ WHERE Ad LIKE '%Ana Bayi%'
UNION ALL
SELECT DISTINCT ÞubeID, 'Þube Bayi' FROM Sigorta.BAYÝ WHERE Ad NOT LIKE '%Ana Bayi%';
SELECT * FROM Sigorta.ÞUBE_TÝPÝ;

INSERT INTO Sigorta.BAYÝ_3NF (BayiID, ÞubeID, Ad, Adres, SorumluID, ÞubeTipiID)
SELECT b.BayiID, b.ÞubeID, b.Ad, b.Adres, b.SorumluID, st.ÞubeTipiID
FROM Sigorta.BAYÝ b
LEFT JOIN Sigorta.ÞUBE_TÝPÝ st ON b.ÞubeID = st.ÞubeTipiID;

SELECT * FROM Sigorta.BAYÝ_3NF;

-------
--temel sorgular
SELECT * FROM Sigorta.MÜÞTERÝ;
SELECT * FROM Sigorta.HESAP;
SELECT * FROM Sigorta.SÝGORTA_TÜRÜ;
SELECT * FROM Sigorta.POLÝÇE;
SELECT * FROM Sigorta.POLÝÇE_NOTLARI;
SELECT * FROM Sigorta.ÖZELPOLÝÇE;
SELECT * FROM Sigorta.TEMÝNAT;
SELECT * FROM Sigorta.TEMÝNAT_BÝLGÝLERÝ;
SELECT * FROM Sigorta.TEMÝNAT_GECÝKMESÝ;
SELECT * FROM Sigorta.HASAR_KAYDI;
SELECT * FROM Sigorta.HASAR_DEÐERLENDÝRME;
SELECT * FROM Sigorta.PERSONEL;
SELECT * FROM Sigorta.PERSONEL_PERFORMANSI;
SELECT * FROM Sigorta.ÖDEME;
SELECT * FROM Sigorta.PRÝM_GECÝKMESÝ;
SELECT * FROM Sigorta.PRÝM_ÖDEMESÝ;
SELECT * FROM Sigorta.KAMPANYA;
SELECT * FROM Sigorta.KAMPANYAPUAN;
SELECT * FROM Sigorta.ÞUBE;
SELECT * FROM Sigorta.SORUMLU;
SELECT * FROM Sigorta.BAYÝ;


SELECT * FROM Sigorta.ÖDEME WHERE PoliçeID = 1;

---eklenenler

CREATE TABLE SigortaTÝPÝ (
    SigortaTipiID INT PRIMARY KEY,
    HesapTipi VARCHAR(50),
    FinansalBilgi TEXT
);

CREATE TABLE Sigorta.HESAP2 (
    HesapID INT PRIMARY KEY,
    MüþteriID INT,
    SigortaTipiID INT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (SigortaTipiID) REFERENCES SigortaTÝPÝ(SigortaTipiID)
);
CREATE TABLE SigortaDetaylarý (
    SigortaDetayID INT PRIMARY KEY,
    SigortaTipiID INT,
    DetayBilgi TEXT,
    FOREIGN KEY (SigortaTipiID) REFERENCES SigortaTÝPÝ(SigortaTipiID)
);


Select * from SigortaTÝPÝ 
select * from Sigorta.HESAP2 
select * from SigortaDetaylarý

----------------------------------------------------------

CREATE TABLE Sigorta.POLÝÇE2 (
    PoliçeID INT PRIMARY KEY,
    MüþteriID INT,
    SigortaTürID INT,
    FOREIGN KEY (MüþteriID) REFERENCES Sigorta.MÜÞTERÝ(MüþteriID),
    FOREIGN KEY (SigortaTürID) REFERENCES Sigorta.SÝGORTA_TÜRÜ(TürID)
);

CREATE TABLE Sigorta.POLÝÇE_DETAY (
    DetayID INT PRIMARY KEY,
    PoliçeID INT,
    PrimTutari DECIMAL(10,2),
    BaslangicTarihi DATE,
    BitisTarihi DATE,
    FOREIGN KEY (PoliçeID) REFERENCES Sigorta.POLÝÇE(PoliçeID)
);
select * from Sigorta.POLÝÇE
select * from Sigorta.POLÝÇE2
select * from Sigorta.POLÝÇE_DETAY
-------------------------------------------

----TRIGGER EKLEME
CREATE TRIGGER trg_GüncellemePrimGecikme
ON Sigorta.ÖDEME
AFTER INSERT
AS
BEGIN
    UPDATE Sigorta.PRÝM_GECÝKMESÝ
    SET GecikmeNedeni = 'Ödeme Yapýldý', FaizOraný = 0, CezaOraný = 0
    WHERE PoliçeID IN (SELECT PoliçeID FROM inserted);
	PRINT 'Trigger çalýþtý: Prim gecikmesi ödeme yapýldýðý için güncellendi.';
END;



INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem)
VALUES (11, 1, 5000.00, '2025-02-16', 'Banka Transferi');
SELECT * FROM Sigorta.PRÝM_GECÝKMESÝ WHERE PoliçeID = 1;

INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem)
VALUES (12, 3, 7000.00, '2025-05-25', 'Banka Transferi');

INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem)
VALUES (13, 7, 3500.00, '2025-06-10', 'Kredi Kartý');
SELECT * FROM Sigorta.PRÝM_GECÝKMESÝ WHERE PoliçeID = 7;

INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem)
VALUES (14, 5, 4500.00, '2025-07-05', 'Banka Transferi');
SELECT * FROM Sigorta.PRÝM_GECÝKMESÝ WHERE PoliçeID = 5;

INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem) 
VALUES (15, 9, 4000.00, '2025-08-15', 'Nakit');
SELECT * FROM Sigorta.PRÝM_GECÝKMESÝ WHERE PoliçeID = 9;


--INSERT INTO Sigorta.ÖDEME (ÖdemeID, PoliçeID, Tutar, Tarih, Yöntem) 
--VALUES (16, 2, 3000.00, '2025-09-30', 'Kredi Kartý');

--SELECT * FROM Sigorta.PRÝM_GECÝKMESÝ WHERE PoliçeID = 2;
---------------------------------------
---PROCEDURE EKLEME
CREATE PROCEDURE sp_GetMüþteriSigortaBilgileri
    @MüþteriID INT
AS
BEGIN
    SELECT M.Ad, M.Soyad, P.PoliçeID, P.PrimTutari, P.BaslangicTarihi, P.BitisTarihi, S.Ad AS SigortaTürü
    FROM Sigorta.MÜÞTERÝ M
    INNER JOIN Sigorta.POLÝÇE P ON M.MüþteriID = P.MüþteriID
    INNER JOIN Sigorta.SÝGORTA_TÜRÜ S ON P.SigortaTürID = S.TürID
    WHERE M.MüþteriID = @MüþteriID;
END;


EXEC sp_GetMüþteriSigortaBilgileri @MüþteriID = 3;
