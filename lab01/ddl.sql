CREATE DATABASE Uslugi;

GO
    USE Uslugi;

DROP TABLE IF EXISTS Nabycie;

DROP TABLE IF EXISTS Zakup;

DROP TABLE IF EXISTS Oferta;

DROP TABLE IF EXISTS Produkt;

DROP TABLE IF EXISTS Sklep;

DROP TABLE IF EXISTS Klient;

CREATE TABLE Klient (
    id INT PRIMARY KEY,
    imie VARCHAR(255) NOT NULL,
    nazwisko VARCHAR(255) NOT NULL
);

CREATE TABLE Sklep (
    id INT PRIMARY KEY,
    nazwa VARCHAR(255) NOT NULL
);

CREATE TABLE Produkt (
    id INT PRIMARY KEY,
    nazwa VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Oferta (
    id INT PRIMARY KEY,
    cena DECIMAL(10, 2) NOT NULL CHECK (cena >= 0),
    ilosc_dostepna INT NOT NULL CHECK (ilosc_dostepna >= 0),
    sklep_id INT NOT NULL,
    produkt_id INT NOT NULL,
    FOREIGN KEY (sklep_id) REFERENCES Sklep(id) ON DELETE CASCADE,
    FOREIGN KEY (produkt_id) REFERENCES Produkt(id) ON DELETE CASCADE
);

CREATE TABLE Zakup (
    id INT PRIMARY KEY,
    data DATE NOT NULL,
    czas TIME NOT NULL,
    klient_id INT,
    sklep_id INT NOT NULL,
    FOREIGN KEY (klient_id) REFERENCES Klient(id) ON DELETE
    SET
        NULL,
        FOREIGN KEY (sklep_id) REFERENCES Sklep(id) ON DELETE CASCADE,
        CONSTRAINT unique_zakup UNIQUE (data, czas, klient_id, sklep_id)
);

CREATE TABLE Nabycie (
    id INT PRIMARY KEY,
    cena DECIMAL(10, 2) NOT NULL CHECK (cena >= 0),
    ilosc_kupiona INT NOT NULL CHECK (ilosc_kupiona > 0),
    zakup_id INT,
    oferta_id INT,
    FOREIGN KEY (zakup_id) REFERENCES Zakup(id) ON DELETE
    SET
        NULL,
        FOREIGN KEY (oferta_id) REFERENCES Oferta(id)
);