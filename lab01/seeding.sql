INSERT INTO
    Klient (id, imie, nazwisko)
VALUES
    (1, 'Jan', 'Kowalski'),
    (2, 'Anna', 'Nowak'),
    (3, 'Piotr', 'Wójcik');

INSERT INTO
    Sklep (id, nazwa)
VALUES
    (1, 'Biedronka'),
    (2, 'Biedronka'),
    (3, 'BIEDRONKA pl. GRUNWALDZKI');

INSERT INTO
    Produkt (id, nazwa)
VALUES
    (1, 'Masło'),
    (2, 'Bułki'),
    (3, 'Wędliny');

INSERT INTO
    Oferta (id, cena, ilosc_dostepna, sklep_id, produkt_id)
VALUES
    (1, 25.99, 10, 1, 1),
    (2, 45.50, 5, 1, 2),
    (3, 15.75, 15, 2, 1),
    (4, 35.30, 7, 2, 3),
    (5, 99.99, 0, 3, 2);

INSERT INTO
    Zakup (id, data, czas, klient_id, sklep_id)
VALUES
    (1, '2025-03-07', '10:30:00', 1, 1),
    (2, '2025-03-07', '11:00:00', 2, 2),
    (3, '2025-03-07', '12:00:00', 3, 3);

INSERT INTO
    Nabycie (id, cena, ilosc_kupiona, zakup_id, oferta_id)
VALUES
    (1, 25.99, 3, 1, 1),
    (2, 45.50, 2, 2, 2),
    (3, 15.75, 5, 3, 3),
    (4, 35.30, 1, 3, 4);

-- Invalid operations
INSERT INTO
    Oferta (id, cena, ilosc_dostepna, sklep_id, produkt_id)
VALUES
    (6, -10.00, 10, 1, 1);

INSERT INTO
    Oferta (id, cena, ilosc_dostepna, sklep_id, produkt_id)
VALUES
    (7, 20.00, -5, 1, 2);

INSERT INTO
    Nabycie (id, cena, ilosc_kupiona, zakup_id, oferta_id)
VALUES
    (5, 25.00, 0, 1, 1);

INSERT INTO
    Nabycie (id, cena, ilosc_kupiona, zakup_id, oferta_id)
VALUES
    (5, -25.00, 1, 1, 1);

INSERT INTO
    Zakup (id, data, czas, klient_id, sklep_id)
VALUES
    (4, '2025-03-07', '10:30:00', 1, 1);