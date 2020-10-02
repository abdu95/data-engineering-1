SELECT * FROM birdstrikes.birdstrikes;

-- create a user that has access to birdstrikes
-- username and password
CREATE USER 'malikovabdu'@'%' IDENTIFIED BY 'malikovabdu';

-- grant all priviliges
GRANT ALL ON birdstrikes.employee TO 'malikovabdu'@'%';

-- allows for this user to select one column. READ ONLY
-- from which IP user can enter? % means from any IP
GRANT SELECT (state) ON birdstrikes.birdstrikes TO 'malikovabdu'@'%';

DROP USER 'malikovabdu'@'%';

describe birdstrikes;
select * from birdstrikes.birdstrikes;

SELECT *, speed/2 FROM birdstrikes;
SELECT *, speed/2 AS halfspeed FROM birdstrikes;

select cost as NARX from birdstrikes;

-- top 10
-- List the first 10 records
SELECT * FROM birdstrikes LIMIT 10;

-- eleventh line, List the first 1 record, after the the first 10
SELECT * FROM birdstrikes LIMIT 10,1;

-- What state figures in the 145th line of our database? Tennessee
SELECT * FROM birdstrikes LIMIT 145;
SELECT * FROM birdstrikes LIMIT 144,1;

-- Order by a field. cost
-- by deafult, sorting ASCENDING
SELECT state, cost FROM birdstrikes ORDER BY cost;

-- Order by a multiple fields
SELECT state, cost FROM birdstrikes ORDER BY state, cost ASC;

-- Reverse ordering
SELECT state, cost FROM birdstrikes ORDER BY cost DESC;

-- What is flight_date of the latest birstrike in this database?
select * from birdstrikes;
SELECT * FROM birdstrikes ORDER BY flight_date DESC;
-- alternative solution
select * from birdstrikes as b ORDER BY b.flight_date DESC;

-- Unique values
-- Of a column
-- what are the labels for damage: No damage, Caused damage
SELECT DISTINCT damage FROM birdstrikes;
SELECT DISTINCT state FROM birdstrikes;

-- Unique pairs, unique combinations
SELECT DISTINCT airline, damage FROM birdstrikes;

-- Exercise3
-- What was the cost of the 50th most expensive damage?
SELECT DISTINCT cost FROM birdstrikes ORDER BY cost;
select id, cost from birdstrikes where cost != 0 ORDER BY cost asc;

select distinct cost from birdstrikes order by cost;
select distinct cost from birdstrikes order by cost desc limit 49,1;
select * from birdstrikes order by cost desc;

-- Select the lines where states is Alabama
SELECT * FROM birdstrikes WHERE state = 'Alabama';
SELECT * FROM birdstrikes WHERE state = 'Maryland';

-- Filtering with VARCHAR
-- NOT EQUAL
-- Select the lines where states is not Alabama
SELECT * FROM birdstrikes WHERE state != 'Alabama';
-- LIKE
-- A% is same as a%
SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'A%';

-- States starting with 'ala'
SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'ala%';

-- States starting with 'North ' followed by any character, followed by an 'a', followed by anything
-- _ means followed by any ONE character
SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'North _a%';

-- States not starting with 'A'
-- state names that does not start with a
SELECT DISTINCT state FROM birdstrikes WHERE state NOT LIKE 'a%' ORDER BY state;

-- Logical operators
-- Filter by multiple conditions
SELECT * FROM birdstrikes WHERE state = 'Alabama' AND bird_size = 'Small';
select distinct bird_size from birdstrikes;
SELECT * FROM birdstrikes WHERE state = 'Alabama' OR state = 'Missouri';

-- IS NOT NULL
-- Filtering out nulls and empty strings

SELECT DISTINCT(state) FROM birdstrikes WHERE state IS NOT NULL AND state != '' ORDER BY state;

-- IN
-- What if I need 'Alabama', 'Missouri','New York','Alaska'? Should we concatenate 4 AND filters?

SELECT * FROM birdstrikes WHERE state IN ('Alabama', 'Missouri','New York','Alaska');

-- LENGTH
-- Listing states with 5 characters

SELECT DISTINCT(state) FROM birdstrikes WHERE LENGTH(state) = 5;

-- Filtering with INT
-- Speed equals 350
SELECT * FROM birdstrikes WHERE speed = 350;
SELECT * FROM birdstrikes WHERE speed >= 10000;

SELECT ROUND(SQRT(speed/2) * 10) AS synthetic_speed FROM birdstrikes;

SELECT * FROM birdstrikes where cost BETWEEN 20 AND 40;
SELECT * FROM birdstrikes where cost IN (21, 50);

-- Exercise4
-- What state figures in the 2nd record, if you filter out all records which have no state and no bird_size specified?
select * from birdstrikes where state IS NOT NULL AND bird_size IS NOT NULL AND state != '' AND bird_size != '';

-- Filtering with DATE
-- Date is "2000-01-02"
SELECT * FROM birdstrikes WHERE flight_date = "2000-01-02";

SELECT * FROM birdstrikes WHERE flight_date >= '2000-01-01' AND flight_date <= '2000-01-03';
SELECT * FROM birdstrikes where flight_date BETWEEN "2000-01-01" AND "2000-01-03";