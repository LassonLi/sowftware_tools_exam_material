-- import script for census data.
-- To recreate the census data, source this file in mariadb.

LOAD DATA INFILE '/vagrant/sampledata/census/Country.csv'    INTO TABLE Country    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/vagrant/sampledata/census/Region.csv'     INTO TABLE Region     FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/vagrant/sampledata/census/County.csv'     INTO TABLE County     FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/vagrant/sampledata/census/Ward.csv'       INTO TABLE Ward       FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (code, name, @parent) SET parent=nullif(@parent,'');
LOAD DATA INFILE '/vagrant/sampledata/census/Occupation.csv' INTO TABLE Occupation FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/vagrant/sampledata/census/Statistic.csv'  INTO TABLE Statistic  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';
