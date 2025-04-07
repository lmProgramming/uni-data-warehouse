# Hurtownia Danych - Analiza Sprzedaży Aut (Poprawiona Wersja)

## Fakt

Fakt: Sprzedaż Pozycji (Samochodu) w Transakcji.
Tabela Faktów: FactSales. Każdy wiersz to jeden samochód sprzedany w ramach konkretnej transakcji.

## Miary

Miary w tabeli FactSales:

ActualSalesAmount
SalesQuantity (Ilość - zawsze 1 dla tego ziarna)
WholesalePriceAmount
SuggestedRetailPriceAmount
ProfitMargin (Marża = ActualSalesAmount - WholesalePriceAmount)
DiscountAmount (Rabat = SuggestedRetailPriceAmount - ActualSalesAmount)

## Wymiary

DimDate:
    DateKey
    FullDate
    Day
    Month
    Quarter
    Year

DimCar:
    CarKey
    VIN
    MakeName
    ModelName
    SeriesName
    ColorName
    FactoryName
    EmissionType
    ModelYear

DimDealer:
    DealerKey
    DealerID
    USAID
    DealerName
    DealerCity
    DealerState

DimOptionPackage:
    OptionPackageKey
    OptionPackageID
    OptionPackageRetailPriceAmount

## Struktura FactSales

SalesKey
DateKey
CarKey
DealerKey
OptionPackageKey
TransactionID
VIN
ActualSalesAmount
SalesQuantity
WholesalePriceAmount
SuggestedRetailPriceAmount
ProfitMargin
DiscountAmount

## Zestawienia

1. Kwota sprzedaży według Marki (MakeName), Modelu (ModelName) i Roku (Year).
2. Ranking TOP 10 Dealerów (DealerName) pod względem łącznej wartości sprzedaży w ostatnim roku (Year).
3. Średnia liczba samochodów sprzedawanych w jednej transakcji.
4. Liczba sprzedanych aut dla konkretnej Marki (MakeName) w podziale miesięcznym (Month).
5. Porównanie średniej marży (ProfitMargin) dla samochodów sprzedawanych w transakcjach z jednym autem vs. w transakcjach z wieloma autami.
6. Udział procentowy poszczególnych Modeli (ModelName) w całkowitej sprzedaży (ActualSalesAmount) danego Dealera (DealerName).
7. Analiza sprzedaży według Koloru (ColorName) i Typu Emisji (EmissionType) w podziale na lata (Year).
8. Średnia wartość transakcji w zależności od dnia tygodnia (DayOfWeek) daty sprzedaży.
9. Porównanie średniej Ceny Hurtowej (WholesalePriceAmount) samochodu dla różnych Roczników (ModelYear).
10. Zestawienie średniej Marży (ProfitMargin) dla każdej Fabryki (FactoryName).
