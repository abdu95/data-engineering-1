USE birdstrikes;

SELECT aircraft, airline, cost, 
    CASE 
        WHEN cost  = 0
            THEN 'NO COST'
        WHEN  cost >0 AND cost < 100000
            THEN 'MEDIUM COST'
        ELSE 
            'HIGH COST'
    END
    AS cost_category   
FROM  birdstrikes
ORDER BY cost_category;

-- Do the same with speed. 
-- If speed is NULL or speed < 100 create a "LOW SPEED" category, otherwise, mark as "HIGH SPEED". Use IF instead of CASE!
SELECT aircraft, airline, cost, 
    CASE 
        WHEN speed  = null OR speed < 100
            THEN "LOW SPEED"
        ELSE 
            "HIGH SPEED"
    END
    AS speed_category   
FROM  birdstrikes
ORDER BY speed_category;

select aircraft, airline, speed, if(speed < 100 OR speed IS NULL, "LOW SPEED", "HIGH SPEED") AS speed_category from birdstrikes ORDER BY speed_category;

SELECT COUNT(*) FROM birdstrikes;
SELECT COUNT(speed) FROM birdstrikes;
SELECT COUNT(reported_date) FROM birdstrikes;

SELECT DISTINCT(state) FROM birdstrikes;
SELECT COUNT(DISTINCT(state)) FROM birdstrikes;

select distinct aircraft from birdstrikes;

-- Exercise2
-- How many distinct 'aircraft' we have in the database?
-- error. no. 3 is teachers answer
SELECT COUNT(DISTINCT(aircraft)) FROM birdstrikes;


SELECT SUM(cost) FROM birdstrikes;

SELECT (AVG(speed)*1.852) as avg_kmh FROM birdstrikes;

SELECT DATEDIFF(MAX(reported_date),MIN(reported_date)) as difference from birdstrikes;

-- Exercise3
-- What was the lowest speed of aircrafts starting with 'H'
select distinct aircraft from birdstrikes;
select aircraft, speed from birdstrikes where aircraft LIKE 'H%';
select MIN(speed) as MinSpeed from birdstrikes WHERE aircraft LIKE 'H%';
-- 9

SELECT MAX(speed), aircraft FROM birdstrikes GROUP BY aircraft;
-- group multiple columns
SELECT state, aircraft, SUM(cost) AS sum FROM birdstrikes WHERE state !='' GROUP BY state, aircraft ORDER BY sum DESC;

-- Exercise4: difficult
-- Which phase_of_flight has the least of incidents?
select distinct damage from birdstrikes;
select distinct phase_of_flight from birdstrikes;
select phase_of_flight, damage from birdstrikes;
select phase_of_flight, damage from birdstrikes where damage = "No damage";

select phase_of_flight, COUNT(damage) from birdstrikes group by damage;
-- En Route with 191?no. Taxi is correct answer

-- Exercise5
-- What is the rounded highest average cost by phase_of_flight?
select phase_of_flight, AVG(cost) as avg_cost FROM birdstrikes group by phase_of_flight;
-- 54673? yes

-- Teachers solution
select phase_of_flight, round(avg(cost)) as avg_cost FROM birdstrikes group by phase_of_flight order by phase_of_flight;

SELECT AVG(speed) AS avg_speed,state FROM birdstrikes GROUP BY state having ROUND(avg_speed) = 50;

-- Exercise6 
-- What the highest AVG speed of the states with names less than 5 characters?
SELECT AVG(speed) AS avg_speed,state FROM birdstrikes where length(state) < 5 GROUP BY state order by avg_speed desc limit 1;

