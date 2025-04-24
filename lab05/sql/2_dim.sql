CREATE TABLE Kubs.DIM_TIME (
    PK_TIME INT PRIMARY KEY,      
    FullDate DATE NOT NULL,       
    Rok INT NOT NULL,
    Kwarta³ INT NOT NULL,
    Miesi¹c INT NOT NULL,              
    Miesi¹c_s³ownie NVARCHAR(20) NOT NULL,
    Dzieñ_tyg INT NOT NULL,         
    Dzieñ_tyg_s³ownie NVARCHAR(20) NOT NULL,
    Dzieñ_miesi¹ca INT NOT NULL    
);
