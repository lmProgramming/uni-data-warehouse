CREATE TABLE Kubs.DIM_TIME (
    PK_TIME INT PRIMARY KEY,      
    FullDate DATE NOT NULL,       
    Rok INT NOT NULL,
    Kwarta� INT NOT NULL,
    Miesi�c INT NOT NULL,              
    Miesi�c_s�ownie NVARCHAR(20) NOT NULL,
    Dzie�_tyg INT NOT NULL,         
    Dzie�_tyg_s�ownie NVARCHAR(20) NOT NULL,
    Dzie�_miesi�ca INT NOT NULL    
);
