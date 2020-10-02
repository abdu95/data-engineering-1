CREATE SCHEMA birdstrikes;

USE birdstrikes;

CREATE TABLE birdstrikes
(id INTEGER NOT NULL,
aircraft VARCHAR(32),
flight_date DATE NOT NULL,
damage VARCHAR(16) NOT NULL,
airline VARCHAR(255) NOT NULL,
state VARCHAR(255),
phase_of_flight VARCHAR(32),
reported_date DATE,
bird_size VARCHAR(16),
cost INTEGER NOT NULL,
speed INTEGER,PRIMARY KEY(id));

-- just clone the structure of a table
CREATE TABLE new_birdstrikes LIKE birdstrikes;

SHOW TABLES;

DESCRIBE new_birdstrikes;
SELECT * FROM new_birdstrikes;

CREATE TABLE employee (id INTEGER NOT NULL, employee_name VARCHAR(255) NOT NULL, PRIMARY KEY(id));

DESCRIBE employee;

SELECT * FROM employee;

INSERT INTO employee (id,employee_name) VALUES(1,'Student1');
INSERT INTO employee (id,employee_name) VALUES(2,'Student2');
INSERT INTO employee (id,employee_name) VALUES(3,'Student3');

-- ..
INSERT INTO employee (id,employee_name) VALUES(3,'Student4');

-- update rows
UPDATE employee SET employee_name='Arnold Schwarzenegger' WHERE id = '1';

UPDATE employee SET employee_name='The Other Arnold' WHERE id = '2';
SELECT * FROM employee;

DELETE FROM employee WHERE id = 3;

-- delete content, empty table
TRUNCATE employee;

-- why not working
DELETE FROM employee WHERE employee_name = "The Other Arnold";
