-- drop the KS608 tables first

DROP TABLE IF EXISTS Statistic;
DROP TABLE IF EXISTS Occupation;

-- geodata

DROP TABLE IF EXISTS Ward;
DROP TABLE IF EXISTS County;
DROP TABLE IF EXISTS Region;
DROP TABLE IF EXISTS Country;

CREATE TABLE Country (
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Region (
    code VARCHAR(10) PRIMARY KEY,
    parent VARCHAR(10),
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (parent) REFERENCES Country(code)
);

CREATE TABLE County (
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent VARCHAR(10),
    country VARCHAR(10),
    FOREIGN KEY (parent) REFERENCES Region(code),
    FOREIGN KEY (country) REFERENCES Country(code)
);

CREATE TABLE Ward (
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent VARCHAR(10),
    FOREIGN KEY (parent) REFERENCES County(code)
);

-- KS608 data

CREATE TABLE Occupation (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Statistic (                      
    wardId VARCHAR(10),                       
    occId INTEGER,
    gender INTEGER, -- 1 = female, 0 = male   
    data INTEGER,                             
    PRIMARY KEY (wardId, occId, gender),      
    FOREIGN KEY (wardId) REFERENCES Ward(code),
    FOREIGN KEY (occId) REFERENCES Occupation(id)
); 
