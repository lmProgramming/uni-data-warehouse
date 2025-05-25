import re

text = r"""
\documentclass[a4paper,12pt]{article}
\usepackage[utf8]{inputenc}
\usepackage{csquotes}
\usepackage[T1]{fontenc}
\usepackage[polish]{babel}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{float}
\usepackage{listings}
\usepackage[style=numeric]{biblatex}
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage{longtable}
\usepackage{array}
\usepackage{booktabs}
\usepackage{tikz}
\usepackage{ragged2e} 
\usepackage{geometry}

\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}

\usetikzlibrary{positioning, shapes.geometric, arrows.meta}

% \addbibresource{bibliografia.bib} % Assuming you have a bibliografia.bib file

\graphicspath{{images/}}

\lstset{
  basicstyle=\ttfamily\small,
  columns=flexible,
  keepspaces=true,
  showstringspaces=false,
  escapeinside={(*@}{@*)},
  literate={ą}{{\k{a}}}1
           {ć}{{\'{c}}}1
           {ę}{{\k{e}}}1
           {ł}{{\l{}}}1
           {ń}{{\'{n}}}1
           {ó}{{\'{o}}}1
           {ś}{{\'{s}}}1
           {ź}{{\'{z}}}1
           {ż}{{\.{z}}}1
           {Ą}{{\k{A}}}1
           {Ć}{{\'{C}}}1
           {Ę}{{\k{E}}}1
           {Ł}{{\L{}}}1
           {Ń}{{\'{N}}}1
           {Ó}{{\'{O}}}1
           {Ś}{{\'{S}}}1
           {Ź}{{\'{Z}}}1
           {Ż}{{\.{Z}}}1
           {"}{{\textquotedbl}}1
           {'}{{\textquotesingle}}1
           {`}{{\textasciigrave}}1
           {~}{{\textasciitilde}}1
           {^}{{\textasciicircum}}1
           {_}{{\textunderscore}}1
           {|}{{\textbar}}1
           {\{}{{\textbraceleft}}1
           {\}}{{\textbraceright}}1
           {[}{{[}}1
           {]}{{]}}1,
  language=SQL,
  showspaces=false,
  numbers=left,
  numberstyle=\tiny\color{gray},
  commentstyle=\color{green!60!black},
  keywordstyle=\color{blue},
  stringstyle=\color{red!80!black},
  breaklines=true,
  frame=tb, % Top and bottom frame for listings
  captionpos=b,
  tabsize=2
}

\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,
    urlcolor=cyan,
    pdftitle={Projekt hurtowni danych F1 - ETL},
    pdfauthor={Mikołaj Kubś},
    pdfpagemode=FullScreen,
}

\title{Projekt hurtowni danych do analizy wyników i czynników wpływających na osiągnięcia kierowców Formuły 1 w latach 1950-2023 \\ \vspace{0.5em} \large Etap II: Proces ETL}
\author{Mikołaj Kubś, 272662}
\date{\today}

\geometry{
  a4paper,
  left=1.5cm,
  right=1.5cm, 
  top=2.5cm,
  bottom=2.5cm
}

\begin{document}

\maketitle
\tableofcontents
\newpage

\section{Wprowadzenie}
Niniejszy dokument stanowi raport z realizacji drugiego etapu projektu hurtowni danych, koncentrującego się na procesie ETL (Extract, Transform, Load). Celem tego etapu było zasilenie zdefiniowanych w Etapie I tabel wymiarów i faktów danymi pochodzącymi z plików CSV, dotyczących wyników i czynników wpływających na osiągnięcia kierowców Formuły 1 w latach 1950-2023. Proces został zaimplementowany przy użyciu narzędzia SQL Server Integration Services (SSIS).

\section{Architektura i Narzędzia Procesu ETL}

\subsection{Struktura Procesu ETL}
Proces ETL został zorganizowany w ramach jednego projektu SSIS, zawierającego dedykowane pakiety dla ładowania poszczególnych tabel wymiarów oraz tabeli faktów. Dodatkowo, zaimplementowano pakiet główny (master package) koordynujący uruchamianie poszczególnych pakietów w odpowiedniej kolejności (najpierw wymiary, następnie fakty), aby zapewnić integralność referencyjną.

Struktura pakietów SSIS:
\begin{itemize}
  \item \texttt{\_Dim\_Circuit.dtsx}
  \item \texttt{\_Dim\_Driver.dtsx}
  \item \texttt{\_Dim\_Constructor.dtsx}
  \item \texttt{\_Dim\_Race.dtsx}
  \item \texttt{\_Dim\_Status.dtsx}
  \item \texttt{\_Dim\_Weather.dtsx}
  \item \texttt{\_Fact\_Result.dtsx}
  \item \texttt{\_Dim\_Time.dtsx}
\end{itemize}

\subsection{Mapa Logiczna ETL}

% --- DIM_DRIVER ---
\subsubsection{Mapowanie Atrybutów: Dim\_Driver}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Driver} \label{tab:map_dim_driver}                                                                                                                                                          \\
    \toprule
    \textbf{Atrybut}      & \textbf{Źródła}                                                                     & \textbf{Kolumna źródła}                   & \textbf{Transformacje i uwagi}                                           \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                                                                                                                          \\
    \toprule
    \textbf{Atrybut}      & \textbf{Źródła}                                                                     & \textbf{Kolumna źródła}                   & \textbf{Transformacje i uwagi}                                           \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                                                                                                                           \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot

    \texttt{DriverKey}    & -                                                                                   & -                                         & SQL Server \texttt{IDENTITY(1,1)}. Klucz zastępczy.                      \\
    \hline
    \texttt{DriverID\_NK} & \texttt{drivers.xlsx}                                                               & \texttt{driverId}                         & Bezpośrednio. Klucz naturalny ze źródła.                                 \\
    \hline
    \texttt{FirstName}    & \texttt{drivers.xlsx}                                                               & \texttt{forename}                         & Bezpośrednio.                                                            \\
    \hline
    \texttt{LastName}     & \texttt{drivers.xlsx}                                                               & \texttt{surname}                          & Bezpośrednio.                                                            \\
    \hline
    \texttt{FullName}     & \texttt{drivers.xlsx}                                                               & \texttt{forename}, \texttt{surname}       & Derived Column: forename + " " + surname. Pełne imię i nazwisko          \\
    \hline
    \texttt{DateOfBirth}  & \texttt{drivers.xlsx}                                                               & \texttt{dob}                              & Bezpośrednio.                                                            \\
    \hline
    \texttt{CountryName}  & \texttt{drivers.xlsx, Helper\_Nationality}                                          & \texttt{nationality}                      & Lookup do Helper\_NationalityCountries.                                  \\
    \hline
    \texttt{Continent}    & \texttt{} \newline \texttt{Helper\_Nationality} \newline \texttt{Helper\_Continent} & \texttt{CountryName poprzednio obliczone} & Lookup do Helper\_CountryContinents z poprzednio obliczonego CountryName \\
  \end{longtable}
\end{footnotesize}

% --- DIM_CONSTRUCTOR ---
\subsubsection{Mapowanie Atrybutów: Dim\_Constructor}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Constructor} \label{tab:map_dim_constructor}                                                                                                    \\
    \toprule
    \textbf{Atrybut}           & \textbf{Źródła}                                          & \textbf{Kolumna źródła}                  & \textbf{Transformacje i uwagi}                      \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                                                                              \\
    \toprule
    \textbf{Atrybut}           & \textbf{Źródła}                                          & \textbf{Kolumna źródła}                  & \textbf{Transformacje i uwagi}                      \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                                                                               \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot
    \texttt{ConstructorKey}    & -                                                        & -                                        & SQL Server \texttt{IDENTITY(1,1)}. Klucz zastępczy. \\
    \hline
    \texttt{ConstructorID\_NK} & \texttt{constructors.xlsx}                               & \texttt{constructorId}                   & Bezpośrednio. Klucz naturalny.                      \\
    \hline
    \texttt{Name}              & \texttt{constructors.xlsx}                               & \texttt{name}                            & Bezpośrednio.                                       \\
    \hline
    \texttt{CountryName}       & \texttt{constructors.xlsx, Helper\_NationalityCountries} & \texttt{nationality}                     & Lookup nationality do Helper\_NationalityCountries. \\
    \hline
    \texttt{Continent}         & {Helper\_Continent, poprzednio obliczone CountryName}    & \texttt{CountryName wcześniej obliczone} & Lookup CountryName do Helper\_CountryContinent      \\
  \end{longtable}
\end{footnotesize}

% --- DIM_RACE ---
\subsubsection{Mapowanie Atrybutów: Dim\_Race}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Race} \label{tab:map_dim_race}                                                              \\
    \toprule
    \textbf{Atrybut}             & \textbf{Źródła}     & \textbf{Kolumna źródła} & \textbf{Transformacje i uwagi}                      \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                          \\
    \toprule
    \textbf{Atrybut}             & \textbf{Źródła}     & \textbf{Kolumna źródła} & \textbf{Transformacje i uwagi}                      \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                           \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot
    \texttt{RaceKey}             & -                   & -                       & SQL Server \texttt{IDENTITY(1,1)}. Klucz zastępczy. \\
    \hline
    \texttt{RaceID\_NK}          & \texttt{races.xlsx} & \texttt{raceId}         & Bezpośrednio. Klucz naturalny.                      \\
    \hline
    \texttt{CircuitID\_NK}       & \texttt{races.xlsx} & \texttt{circuitId}      & Bezpośrednio. NK obwodu dla tego wyścigu.           \\
    \hline
    \texttt{YearSeason}          & \texttt{races.xlsx} & \texttt{year}           & Bezpośrednio.                                       \\
    \hline
    \texttt{RoundNumberInSeason} & \texttt{races.xlsx} & \texttt{round}          & Bezpośrednio.                                       \\
    \hline
    \texttt{RaceNameOfficial}    & \texttt{races.xlsx} & \texttt{name}           & Bezpośrednio.                                       \\
    \hline
    \texttt{Date}                & \texttt{races.xlsx} & \texttt{date}           & Bezpośrednio. Używana do \texttt{DateKey} w Fact.   \\
  \end{longtable}
\end{footnotesize}

% --- DIM_CIRCUIT ---
\subsubsection{Mapowanie Atrybutów: Dim\_Circuit}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Circuit} \label{tab:map_dim_circuit}                                                     \\
    \toprule
    \textbf{Atrybut}       & \textbf{Źródła}        & \textbf{Kolumna źródła} & \textbf{Transformacje i uwagi}                      \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                       \\
    \toprule
    \textbf{Atrybut}       & \textbf{Źródła}        & \textbf{Kolumna źródła} & \textbf{Transformacje i uwagi}                      \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                        \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot
    \texttt{CircuitKey}    & -                      & -                       & SQL Server \texttt{IDENTITY(1,1)}. Klucz zastępczy. \\
    \hline
    \texttt{CircuitID\_NK} & \texttt{circuits.xlsx} & \texttt{circuitId}      & Bezpośrednio. Klucz naturalny.                      \\
    \hline
    \texttt{CircuitName}   & \texttt{circuits.xlsx} & \texttt{name}           & Bezpośrednio.                                       \\
    \hline
    \texttt{LocationCity}  & \texttt{circuits.xlsx} & \texttt{location}       & Bezpośrednio.                                       \\
    \hline
    \texttt{CountryName}   & \texttt{circuits.xlsx} & \texttt{country}        & Bezpośrednio.                                       \\
  \end{longtable}
\end{footnotesize}

% --- DIM_TIME ---
\subsubsection{Mapowanie Atrybutów: Dim\_Time}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Time} \label{tab:map_dim_time}                                                                                                                                                    \\
    \toprule
    \textbf{Atrybut}       & \textbf{Źródła}                                       & \textbf{Kolumna}                      & \textbf{Transformacje i uwagi}                                                                  \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                                                                                                                \\
    \toprule
    \textbf{Atrybut}       & \textbf{Źródła}                                       & \textbf{Kolumna}                      & \textbf{Transformacje i uwagi}                                                                  \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                                                                                                                 \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot
    \texttt{DateKey}       & \texttt{Fact\_Result}                                 & \texttt{Distinct DateKey}             & Distinct z DateKey w Fact\_Result. PK, YYYYMMDD INT.                                            \\
    \hline
    \texttt{FullDate}      & \texttt{Dim\_Time}                                    & \texttt{DateKey wcześniej obliczone}  & Derived column: rok, miesiąc i dzień za pomocą modulo i dzielenia z DateKey.                    \\
    \hline
    \texttt{Year}          & \texttt{Dim\_Time}                                    & \texttt{FullDate wcześniej obliczone} & Derived Column: DatePart YEAR z FullDate.                                                       \\
    \hline
    \texttt{Quarter}       & \texttt{Dim\_Time}                                    & \texttt{FullDate wcześniej obliczone} & Derived Column: DatePart QUARTER z FullDate.                                                    \\
    \hline
    \texttt{Month}         & \texttt{Dim\_Time}                                    & \texttt{FullDate wcześniej obliczone} & Derived Column: DatePart MONTH z FullDate.                                                      \\
    \hline
    \texttt{MonthName}     & \texttt{Dim\_Time} \newline \texttt{Helper\_Months}   & \texttt{Month wcześniej obliczone}    & Lookup na \texttt{Helper\_Months}. Angielska nazwa.                                             \\
    \hline
    \texttt{DayOfMonth}    & \texttt{Dim\_Time}                                    & \texttt{FullDate wcześniej obliczone} & Derived Column: DatePart DAY z FullDate.                                                        \\
    \hline
    \texttt{DayOfWeekName} & \texttt{Dim\_Time} \newline \texttt{Helper\_Weekdays} & Bazuje na \texttt{FullDate}           & Derived Column: DatePart WEEKDAY - z tego Lookup na \texttt{Helper\_Weekdays}. Angielska nazwa. \\
  \end{longtable}
\end{footnotesize}

% --- DIM_WEATHER ---
\subsubsection{Mapowanie Atrybutów: Dim\_Weather}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Weather} \label{tab:map_dim_weather}                                                                                                                     \\
    \toprule
    \textbf{Atrybut}           & \textbf{Źródła}       & \textbf{Źródla}                     & \textbf{Transformacje i uwagi}                                                                       \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                                                                                       \\
    \toprule
    \textbf{Atrybut}           & \textbf{Źródła}       & \textbf{Źródla}                     & \textbf{Transformacje i uwagi}                                                                       \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                                                                                        \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot
    \texttt{WeatherKey}        & \texttt{weather.xlsx} & \texttt{RoundNumber}, \texttt{Year} & Derived Column: Year * 100 + RoundNumber.                                                            \\
    \hline
    \texttt{DidRainOccur}      & \texttt{weather.xlsx} & \texttt{Rainfall}                   & Najpierw Derived Column RainfallInt 1/0 -> Agregacja max z RainfallInt -> "Rain Occurred"/"No Rain". \\
    \hline
    \texttt{WindSpeedCategory} & \texttt{weather.xlsx} & \texttt{WindSpeed}                  & Agregacja AVG -> logika CASE dla kategorii: "Light Breeze", "Calm"...                                \\
    \hline
    \texttt{AirTempCategory}   & \texttt{weather.xlsx} & \texttt{AirTemp}                    & Agregacja AVG -> logika CASE dla kategorii: "Cold", "Warm"...                                        \\
    \hline
    \texttt{TrackTempCategory} & \texttt{weather.xlsx} & \texttt{TrackTemp}                  & Agregacja AVG -> logika CASE dla kategorii: "Optimal Track", "Very Hot Track"...                     \\
    \hline
    \texttt{HumidityCategory}  & \texttt{weather.xlsx} & \texttt{Humidity}                   & Agregacja AVG -> logika CASE dla kategorii: "Dry", "Humid"...                                        \\
    \hline
    \texttt{PressureCategory}  & \texttt{weather.xlsx} & \texttt{Pressure}                   & Agregacja AVG -> logika CASE dla kategorii: "Very Low", "Normal"...                                  \\
    \hline
  \end{longtable}
\end{footnotesize}

% --- DIM_STATUS ---
\subsubsection{Mapowanie Atrybutów: Dim\_Status}
\begin{footnotesize}
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Dim\_Status} \label{tab:map_dim_status}                                                                                                                                                                 \\
    \toprule
    \textbf{Atrybut}           & \textbf{Źródła}                                       & \textbf{Kolumna źródła} & \textbf{Transformacje i uwagi}                                                                                             \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                                                                                                                                 \\
    \toprule
    \textbf{Atrybut}           & \textbf{Źródła}                                       & \textbf{Kolumna źródła} & \textbf{Transformacje i uwagi}                                                                                             \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                                                                                                                                  \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot
    \texttt{StatusKey}         & -                                                     & -                       & SQL Server \texttt{IDENTITY(1,1)}. Klucz zastępczy.                                                                        \\
    \hline
    \texttt{StatusID\_NK}      & \texttt{status.xlsx}                                  & \texttt{statusId}       & Bezpośrednio.                                                                                                              \\
    \hline
    \texttt{StatusDescription} & \texttt{status.xlsx}                                  & \texttt{status}         & Bezpośrednio.                                                                                                              \\
    \hline
    \texttt{StatusCategory}    & \texttt{status.xlsx} \newline \texttt{Helper\_Status} & \texttt{status}         & Fuzzy Lookup na status w Helper\_StatusCategory -> \texttt{BroadCategory}. Kategoria np. Race Outcome, Mechanical Failure. \\
  \end{longtable}
\end{footnotesize}

% --- FACT_RESULT ---
\subsubsection{Mapowanie Atrybutów: Fact\_Result}
\begin{footnotesize}
  \setlength{\tabcolsep}{3pt} % Further reduce for this very wide table
  \begin{longtable}{|L{3.5cm}|L{3.5cm}|L{3cm}|L{7cm}|}
    \caption{Mapowanie ETL dla tabeli Fact\_Result} \label{tab:map_fact_result}                                                                                                                                                                                                             \\
    \toprule
    \textbf{Atrybut}              & \textbf{Źródło CSV / Wymiar}             & \textbf{Kolumna}                              & \textbf{Transformacje i uwagi}                                                                                                                               \\
    \midrule
    \endfirsthead
    \multicolumn{4}{c}%
    {{\bfseries \tablename\ \thetable{} -- Kontynuacja z poprzedniej strony}}                                                                                                                                                                                                               \\
    \toprule
    \textbf{Atrybut}              & \textbf{Źródło CSV / Wymiar}             & \textbf{Kolumna}                              & \textbf{Transformacje i uwagi}                                                                                                                               \\
    \midrule
    \endhead
    \midrule
    \multicolumn{4}{|r|}{{Kontynuacja na następnej stronie}}                                                                                                                                                                                                                                \\
    \midrule
    \endfoot
    \bottomrule
    \endlastfoot

    \texttt{RaceKey}              & results.xlsx, Dim\_Race                  & \texttt{RaceKey}                              & Lookup z \texttt{Dim\_Race}.                                                                                                                                 \\
    \hline
    \texttt{DriverKey}            & results.xlsx, Dim\_Driver                & \texttt{DriverKey}                            & Lookup z \texttt{Dim\_Driver} (\texttt{res.driverId}) -> \texttt{DriverKey} (SK). FK.                                                                        \\
    \hline
    \texttt{ConstructorKey}       & results.xlsx, Dim\_Constructor           & \texttt{ConstructorKey}                       & Lookup z \texttt{Dim\_Constr.} (\texttt{res.constructorId}) -> \texttt{ConstrKey} (SK). FK.                                                                  \\
    \hline
    \texttt{CircuitKey}           & results.xlsx, Dim\_Circuit               & \texttt{CircuitKey}                           & Lookup z \texttt{Dim\_Circuit}                                                                                                                               \\
    \hline
    \texttt{DateKey}              & results.xlsx, Dim\_Race                  & \texttt{Date}                                 & Lookup z \texttt{Dim\_Race} -> \texttt{FullDate}. Derived Column: \texttt{(YEAR(FullDate)*10000) + (MONTH(FullDate)*100) + DAY(FullDate)}. INT YYYYMMDD.     \\
    \hline
    \texttt{WeatherKey}           & {Dim\_Weather} / \texttt{Dim\_Race}      & \texttt{races.raceId} LUB \texttt{races.year} & Lookup z \texttt{Dim\_Race} -> \texttt{RaceID\_NK} (lub \texttt{Year,Round}). LkUp \texttt{Dim\_Weather}. Der.Col: NULL jeśli rok < 2018. FK.                \\
    \hline
    \texttt{StatusKey}            & \texttt{Dim\_Status}                     & \texttt{results.statusId} (NK)                & Lookup z \texttt{Dim\_Status} (\texttt{res.statusId}) -> \texttt{StatusKey} (SK). FK.                                                                        \\
    \hline
    \texttt{PointsScored}         & \texttt{results.xlsx}                    & \texttt{points}                               & Bezpośrednio.                                                                                                                                                \\
    \hline
    \texttt{LapsCompleted}        & \texttt{results.xlsx}                    & \texttt{laps}                                 & Bezpośrednio.                                                                                                                                                \\
    \hline
    \texttt{NumberOfPitStops}     & \texttt{pit\_stops.xlsx}                 & \texttt{raceId}, \texttt{driverId}            & Pod-przepływ: Agg. (\texttt{COUNT(stop)} jako \texttt{stopsCount}). \texttt{Merge Join} (Left Outer). Der.Col: \texttt{ISNULL(stopsCount) ? 0 : stopsCount}. \\
    \hline
    \texttt{RaceTimeMilliseconds} & \texttt{results.xlsx}                    & \texttt{milliseconds} LUB \texttt{time}       & Mapa bezp. LUB Der.Col (parsuj tekst \texttt{time}) + DC (do \texttt{DT\_I8}). NULL jeśli DNF.                                                               \\
    \hline
    \texttt{GridPosition}         & \texttt{results.xlsx}                    & \texttt{grid}                                 & Mapa bezp. + DC (do \texttt{DT\_I4}). Obsługa 0 dla pit lane.                                                                                                \\
    \hline
    \texttt{FinalPositionOrder}   & \texttt{results.xlsx}                    & \texttt{positionOrder} LUB \texttt{position}  & Mapa bezp. + DC (do \texttt{DT\_I4}).                                                                                                                        \\
    \hline
    \texttt{PositionOrderChange}  & \texttt{results.xlsx}                    & \texttt{grid}, \texttt{positionOrder}         & Der.Col: \texttt{GridPosition - FinalPositionOrder}.                                                                                                         \\
    \hline
    \texttt{RankFastestLap}       & \texttt{results.xlsx}                    & \texttt{rank} (fast lap)                      & Mapa bezp. + DC (do \texttt{DT\_I4}). NULL jeśli brak.                                                                                                       \\
    \hline
    \texttt{FastestLapTopSpeed}   & \texttt{results.xlsx}                    & \texttt{fastestLapSpeed}                      & Mapa bezp. + DC (do \texttt{DT\_DECIMAL}). NULL jeśli brak.                                                                                                  \\
    \hline
    \texttt{AgeAtRace}            & \texttt{Dim\_Driver}, \texttt{Dim\_Race} & \texttt{drivers.dob}, \texttt{races.date}     & LkUp \texttt{Dim\_Driver} (\texttt{dob}). LkUp \texttt{Dim\_Race} (\texttt{date}). Der.Col: Kalkulacja wieku. NULL jeśli \texttt{dob} NULL.                  \\
  \end{longtable}
\end{footnotesize}
\setlength{\tabcolsep}{6pt} % Restore default if changed

\subsection{Narzędzia}
Głównym narzędziem wykorzystanym do implementacji procesów ETL był SQL Server Integration Services (SSIS) wchodzący w skład Microsoft SQL Server. Pakiety SSIS zostały utworzone przy użyciu SQL Server Data Tools (SSDT) for Visual Studio. Dodatkowo do czyszczenia początkowych danych i zmiany formatu plików z danymi wykorzystano Python.

\section{Implementacja Procesów ETL}

\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{etl.png}
  \caption{Cały ETL.}
\end{figure}

\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{result.png}
  \caption{ETL dla Fact\_Result.}
\end{figure}

\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{time.png}
  \caption{ETL dla Dim\_Time.}
\end{figure}

\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{final_counts.png}
  \caption{Liczby wierszy w wymiarach i fakcie - zgadzają się ze źródłem danych.}
\end{figure}

\subsection{Ekstrakcja Danych (Extract)}
Dane źródłowe w formacie XLSX były wczytywane przy użyciu komponentu \texttt{Excel Source} w SSIS. Kluczowe aspekty konfiguracji tego etapu to:
\begin{itemize}
  \item Poprzednia konwersja plików .csv to .xlsx za pomocą skryptu Python, aby pominąć błędy w kodowaniu.
  \item Użycie skryptu Python do usunięcia "/N" w zbiorze danych.
  \item Poprawna identyfikacja separatorów kolumn, kwalifikatorów tekstu oraz obsługa wierszy nagłówkowych.
  \item Wstępne mapowanie typów danych na poziomie źródła, z uwzględnieniem późniejszych konwersji.
\end{itemize}

\subsection{Transformacja Danych (Transform)}
Etap transformacji obejmował szereg operacji mających na celu oczyszczenie, integrację i przygotowanie danych do załadowania do tabel docelowych. Przykładowo:
\begin{enumerate}
  \item \textbf{Konwersja Typów Danych:} Komponent \texttt{Data Conversion} był wykorzystany do konwersji danych.
  \item \textbf{Obliczenia Pochodne:} Komponent \texttt{Derived Column} służył do tworzenia nowych kolumn na podstawie istniejących, np.:
        \begin{itemize}
          \item Obliczenie wieku kierowcy w momencie wyścigu (\texttt{AgeAtRace}).
          \item Obliczenie zmiany pozycji (\texttt{PositionOrderChange}).
        \end{itemize}
  \item \textbf{Agregacja Danych:}
        \begin{itemize}
          \item \textbf{Dane pogodowe (\texttt{Dim\_Weather}):} Minutowe dane pogodowe z pliku \texttt{weather.xlsx} były agregowane do poziomu pojedynczego wyścigu (po \texttt{Year} i \texttt{RoundNumber}) przy użyciu komponentu \texttt{Aggregate}. Obliczano wartości średnie, minimalne, maksymalne oraz sumy (np. dla opadów).
          \item \textbf{Dane o pit-stopach:} Informacje o liczbie i łącznym czasie pit-stopów dla każdego kierowcy w wyścigu były agregowane z pliku \texttt{pit\_stops.xlsx} i dołączane podczas ładowania tabeli faktów (np. poprzez wcześniejszą agregację do tabeli stagingowej i lookup).
        \end{itemize}
  \item \textbf{Kategoryzacja Danych Pogodowych:} Po agregacji, zagregowane wartości liczbowe dla danych pogodowych (np. temperatura, wilgotność, prędkość wiatru) były przekształcane na predefiniowane kategorie tekstowe (np. "Zimno", "Umiarkowanie", "Gorąco") przy użyciu wyrażeń warunkowych w komponencie \texttt{Derived Column}, zgodnie z założeniami projektu. Te kategorie zostały następnie załadowane do \texttt{Dim\_Weather}. Transformacja odbyła się w skrypcie C\#.
  \item \textbf{Fuzzy Lookup:} Do statusów dołączono ogólną kategorię statusu np. 'Mechanical Failure', 'Race Outcome' itd.
\end{enumerate}

\subsection{Ładowanie Danych (Load)}
Przetransformowane dane były ładowane do docelowych tabel w hurtowni SQL Server przy użyciu komponentu \texttt{OLE DB Destination}.
\begin{itemize}
  \item Wykorzystano tryb szybkiego ładowania (\texttt{Table or view - fast load}).
  \item Zapewniono poprawne mapowanie kolumn z przepływu danych SSIS do kolumn tabel docelowych.
  \item Kolejność ładowania (najpierw wymiary, potem fakty) była zarządzana przez pakiet główny.
\end{itemize}

\subsection{Event handler}

W przypadku błędu, wszystkie dane są usuwane. Wcześniej podczas developmentu dodatkowo tabele były populowane, ponieważ wtedy występował błąd w metadanych SSIS.

\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{error_handler.png}
  \caption{Error handler.}
\end{figure}

\subsection{Wyzwania i Rozwiązania}
Podczas implementacji napotkano typowe wyzwania związane z procesami ETL:
\begin{itemize}
  \item \textbf{Niezgodność Stron Kodowych:} Początkowe problemy z konfliktem stron kodowych (np. 65001 z Flat File Source vs 1250 domyślne dla OLE DB Destination) zostały rozwiązane poprzez zmianę typu plików na Excel.
  \item \textbf{Synchronizacja Metadanych:} Zmiany w strukturze przepływu danych (np. po dodaniu \texttt{Data Conversion}) wymagały odświeżenia metadanych w komponencie \texttt{OLE DB Destination} i ponownego zmapowania kolumn.
  \item \textbf{Błędy Konwersji Danych w Źródle:} Błędy typu "Text was truncated or one or more characters had no match in the target code page" pojawiające się w \texttt{Excel Source} wskazywały na niepoprawną konfigurację strony kodowej dla pliku źródłowego. Trzeba było zmienić ręcznie w advanced editor dla źródła typy kolumn.
\end{itemize}

\subsection{Przyrostowe Zasilanie (Planowane)}
Nie zaimplementowano z braku czasu. Można by uruchomić dla tabeli faktów, za każdym razem usuwając wszystkie wymiary i klucze do wymiarów w fakcie, zapisanie jaki najnowszy id? w fakcie już był, a potem załadowanie wszystkich wymiarów i wierszy o id powyżej ostatniego id faktu.

\section{Podsumowanie i Wnioski z Etapu ETL}
Proces ETL został pomyślnie zaimplementowany, umożliwiając zasilenie hurtowni danych Formuły 1 przetworzonymi i zintegrowanymi danymi. Kluczowe było właściwe zarządzanie typami danych i stronami kodowymi oraz logiczne rozplanowanie transformacji, w tym agregacji i kategoryzacji danych pogodowych. Zastosowanie SSIS pozwoliło na zbudowanie modularnego i zarządzalnego przepływu danych. Rozwiązane problemy z konwersją danych podkreślają znaczenie dokładnej analizy danych źródłowych i właściwej konfiguracji narzędzi ETL.

Kolejnym etapem będzie budowa kostki OLAP na bazie przygotowanej hurtowni danych oraz przeprowadzenie analiz wielowymiarowych.

\newpage
% \section*{Dodatek A: Przykładowe fragmenty kodu / konfiguracji SSIS}
% (Opcjonalnie: można tu dodać zrzuty ekranu konfiguracji kluczowych komponentów SSIS, np. Data Conversion dla pogody, Lookup, fragment mapy logicznej z SSIS)


% \printbibliography % If using biblatex

\end{document}
"""
result = re.sub(r'\\texttt\{([^}]*)\}', r'\1', text)
print(result)
