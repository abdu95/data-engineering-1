-- Exercise1
SELECT * FROM birdstrikes LIMIT 144,1;
-- Answer: 'Tennessee'

-- Exercise2
SELECT * FROM birdstrikes ORDER BY flight_date DESC;
-- Answer: '2000-04-18'

-- Exercise3
SELECT DISTINCT cost FROM birdstrikes ORDER BY cost LIMIT 50;
-- Answer: 86864

-- Exercise4
select * from birdstrikes where state IS NOT NULL AND bird_size IS NOT NULL;
-- Answer: " " (empty string)
select * from birdstrikes where state IS NOT NULL AND bird_size IS NOT NULL AND state != '' AND bird_size != '';
-- Answer: Colorado

-- Exercise5 
SELECT DATEDIFF(NOW(), (select flight_date from birdstrikes where WEEKOFYEAR(flight_date) = 52 AND state = 'Colorado'));  
-- Answer: 7580