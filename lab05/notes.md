# notes for lab04

przymierzyć do procestu ETL

upewnić się, że dzień tyg jest dobry
chyba np. rok kwartał miesiąc dzień dzień tygodnia

automatyzacja procesu:

delete -> create -> insert -> reference

podpisywać co jest w danym bloczku - zamiast source SalesOrderDetails

kolejność logiczna
np. source - sort - merge join - [remove duplicates] - sort
merge sort wymaga joina

Klienci - Zapisz klientów [Posortuj klientów, Połącz klientów i miejsca, Zapisz klientów do bazy]

uważać na daty żeby mniej ich wyciągać?
nie wyciągać ich wiele razy?
1134/1124/11xx unikatowych dat powinno być
lepiej 1100
główny punkt tej listy
usunąć po prostu duplikaty na początku??
1 proces na daty a nie 2 osobne na orderdate i shipdate (shipdate to orderdate + 10 dni)

obsłużyć błędy i wyjątki - wyświetl, że się udało jakiś popup

fuzzy lookup
np. mr is mr. ujednolicić - uważać, żeby nie zjadło to ms
rowerek rozmiar 40 i rowerek rozmiar 38 - lepiej połączyć (np. obciąć tam parę ostatnich cyfr)
fuzzy grouping
united-states united states
iceland vs ireland
south korea vs north korea

przy ładowaniu danych do wymiarów
minimalizacja zbioru komponentów
prosty klucz główny - joinowanie po stringach jest dłuższe niż po intach, sztuczny klucz lebszy

w prostej tabeli faktów id nie jest potrzebne, coś tam o problemach z cout MOŻE

uważać na partycję - jak się źle kliknie trzeba kostkę jeszcze raz
