-- Exercise1
-- Do the same with speed. If speed is NULL or speed < 100 create a "LOW SPEED" category, otherwise, mark as "HIGH SPEED". Use IF instead of CASE!
select aircraft, airline, speed, if(speed < 100 OR speed IS NULL, "LOW SPEED", "HIGH SPEED") AS speed_category from birdstrikes ORDER BY speed_category;

-- Exercise2
-- How many distinct 'aircraft' we have in the database?
SELECT COUNT(DISTINCT(aircraft)) FROM birdstrikes;
-- Answer: 3
-- More accurate answer is 2. Airplane, Helicopter and one empty value

-- Exercise3
-- What was the lowest speed of aircrafts starting with 'H'
select MIN(speed) as MinSpeed from birdstrikes WHERE aircraft LIKE 'H%';
-- Answer: 9

-- Exercise4
-- Which phase_of_flight has the least of incidents?
select phase_of_flight, COUNT(damage) from birdstrikes group by damage;
-- Answer: En Route with 191

-- Exercise5
-- What is the rounded highest average cost by phase_of_flight?
select phase_of_flight, AVG(cost) as avg_cost FROM birdstrikes group by phase_of_flight;
-- Answer: 54673

-- Exercise6 
-- What the highest AVG speed of the states with names less than 5 characters?
SELECT AVG(speed) AS avg_speed,state FROM birdstrikes where length(state) < 5 GROUP BY state order by avg_speed desc limit 1;
-- Answer: 2862.5