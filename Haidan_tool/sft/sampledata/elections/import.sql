DROP TABLE IF EXISTS Rawdata;

CREATE TABLE Rawdata (
    date DATE, ward VARCHAR(100),
    electorate INTEGER, candidate VARCHAR(100),
    party VARCHAR(100), votes INTEGER,
    percent DECIMAL(5,2)
);

LOAD DATA INFILE '/vagrant/sampledata/elections/elections-2014.csv' INTO TABLE Rawdata FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
INSERT INTO Ward (name, electorate) SELECT DISTINCT ward, electorate FROM Rawdata;
INSERT INTO Party (name) SELECT DISTINCT party FROM Rawdata;
INSERT INTO Candidate (name, party, ward, votes) SELECT candidate, Party.id, Ward.id, votes FROM Rawdata
    INNER JOIN Party ON Party.name = Rawdata.party INNER JOIN Ward ON Ward.name = Rawdata.ward;
DROP TABLE Rawdata;
