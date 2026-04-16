-- Inserts for tanks table
INSERT INTO tanks
(tank_id, size_litres, water_type, system_type, location_type, location)
VALUES (1, 115, 'freshwater', 'semi-open', 'outdoor exhibit', '2a'),
(2, 123, 'saltwater', 'semi-open', 'filtration room', '1c'),
(3, 99, 'saltwater', 'open', 'outdoor exhibit', '2b'),
(4, 95, 'saltwater', 'closed', 'storage room', '3a'),
(5, 155, 'freshwater', 'semi-open', 'filtration room', '1b'),
(6, 421, 'freshwater', 'open', 'outdoor exhibit', '2c'),
(7, 216, 'saltwater', 'semi-open', 'filtration room', '1a');

INSERT INTO tanks
(tank_id, size_litres, water_type, system_type, location_type, location)
VALUES (8, 264, 'freshwater', 'semi-open', 'outdoor exhibit', '2d');

--Inserts for fish species table
INSERT INTO fishspecies
(species_code, common_name, scientific_name, ideal_temperature_celsius)
VALUES ('COD', 'Atlantic Cod', 'Gadus Morhua', 5),
('RJM', 'Spotted Ray', 'Raja Montagui', 12),
('HAD', 'Haddock', 'Melanogrammus Aeglefinus', 9),
('SQR', 'European Squid', 'Loligo Vulgaris', 19),
('GAR', 'Garfish', 'Belone Belone', 25),
('LIN', 'Ling', 'Molva Molva', 6),
('ILL', 'Shortfin Squids Nei', 'Illex Spp', 15),
('TFT', 'Yellowfin Tuna', 'Thunnus Albacares', 19),
('MOL', 'Common Mola', 'Mola Mola', 14),
('BET', 'Bigeye Tuna', 'Thunnus Obesus', 15),
('BRT', 'Brown Tang', 'Zebrasoma Scopas', 14),
('BUL', 'Bullhead', 'Cottus Gobio', 6),
('TEN', 'Tench', 'Tinca Tinca', 27),
('KAN', 'King Angelfish', 'Holacanthus Passer', 15),
('GAF', 'Grey Angelfish', 'Pomacanthus Arcuatus', 14),
('SAL', 'Atlantic Salmon', 'Salmo Salar', 27),
('PAL', 'Palometa', 'Trachinotus Goodei', 19),
('WHG', 'White Grunt', 'Haemulon Plumierii', 15),
('ANG', 'Eel', 'Anguilla Anguilla ', 28),
('ISJ', 'Island Jack', 'Ferdauia Orthogrammus', 10),
('DOG', 'Dogtooth Tuna', 'Gymnosarda Unicolor', 16),
('BRW', 'Brown Trout', 'Salmo Trutta', 5);

UPDATE fishspecies
SET ideal_water_type = 'Freshwater'
WHERE species_code IN ('COD', 'GAR', 'LIN', 'BUL', 'TEN', 'SAL', 'ANG', 'BRW');

UPDATE fishspecies
SET ideal_water_type = 'Saltwater'
WHERE species_code IN ('RJM', 'HAD', 'SQR', 'ILL', 'TFT', 'MOL', 'BET', 'BRT', 'KAN', 'GAF', 'PAL', 'WHG', 'ISJ', 'DOG');

-- Inserts for tank species table
INSERT INTO tankspecies
(tank_id, species_code)
VALUES (1, 'COD'),
(1, 'LIN'),
(1, 'BRW'),
(2, 'MOL'),
(2, 'RJM'),
(2, 'BRT'),
(2, 'KAN'),
(3, 'HAD'),
(3, 'ISJ'),
(4, 'SQR'),
(4, 'TFT'),
(4, 'PAL'),
(5, 'ANG'),
(5, 'GAR'),
(5, 'TEN'),
(5, 'SAL'),
(6, 'BUL'),
(7, 'GAF'),
(7, 'WHG'),
(7, 'DOG'),
(7, 'BET'),
(7, 'ILL');

DELETE FROM tankspecies
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM tankspecies
    GROUP BY tank_id, species_code
);

-- Inserts for feeding logs table
INSERT INTO feedinglogs
(log_id, tank_id, feed_date, food_type, amount_grams)
VALUES ('L1', 1, '2003-07-29', 'Pellets', '45'),
('L2', 2, '2003-07-29', 'Flakes', '50'),
('L3', 3, '2003-07-29', 'Pellets', '45'),
('L4', 4, NULL, NULL, NULL),
('L6', 6, '2003-08-20', 'Brine Shrimp', '165'),
('L7', 7, '2003-07-28', 'Algae', '70');

INSERT INTO feedinglogs
(log_id, tank_id, feed_date, food_type, amount_grams)
VALUES ('L5', 5, '2003-08-02', 'Flakes', '60.3');

-- Inserts for water quality logs table
INSERT INTO waterqualitylogs
(test_id, tank_id, test_date, temperature_celsius, ph, salinity_ppt, hardness_ppm, nitrite_ppm)
VALUES ('T1' , 1, '2003-07-29', 5, 7.6, 0.5, 30, 0.08),
('T2' , 2, '2003-07-29', 14, 8.2, 32, 198, 0.09),
('T3' , 3, '2003-07-29', 9, 8.1, 33, 221, 0.02),
('T4' , 4, '2003-07-29', 21, 8.4, 37, 290, 0.31),
('T6' , 6, '2003-08-20', 4, 7.2, 0.4, 25, 0.02),
('T7' , 7, '2003-07-28', 15, 8.3, 39, 320, 0.11);

INSERT INTO waterqualitylogs
(test_id, tank_id, test_date, temperature_celsius, ph, salinity_ppt, hardness_ppm, nitrite_ppm)
VALUES ('T5', 6, '2003-08-02', 23, 6.8, 0.2, 25, 0.02);

UPDATE waterqualitylogs
SET salinity_ppt = salinity_ppt + 2,
    ph = ph + 0.4
WHERE salinity_ppt > 2;

--List all fish species and their scientific names
SELECT common_name, scientific_name FROM fishspecies;

--List all tanks that contain saltwater
SELECT tank_id FROM tanks
WHERE water_type = 'saltwater';

--List all tanks where the amount of water is between 95 and 125 litres
SELECT * FROM tanks
WHERE size_litres BETWEEN 95 AND 125;

--List all tanks where the location is in 1a, 1b, or 1c
SELECT * FROM tanks
WHERE location LIKE '1%';

--Show the unique food types ordered by the amount fed, excluding the top-fed tank and returning only 4
SELECT DISTINCT food_type, tank_id, amount_grams FROM feedinglogs
ORDER BY amount_grams DESC
LIMIT 4 OFFSET 2;

--Show which fish belong to which tank using their common names
SELECT tanks.tank_id, common_name FROM tanks
INNER JOIN tankspecies ON tankspecies.tank_id = tanks.tank_id
INNER JOIN fishspecies ON fishspecies.species_code = tankspecies.species_code;

--Show all tanks and the fish they carry, as well as tanks with no fish
SELECT tanks.tank_id, species_code FROM tanks
LEFT JOIN tankspecies ON tanks.tank_id = tankspecies.tank_id;

--Show the location of the tank which doesn't have a feeding log
SELECT tanks.tank_id, location, feed_date FROM feedinglogs
JOIN tanks ON feedinglogs.tank_id = tanks.tank_id
WHERE feed_date IS NULL;

--Show the feeding logs only for the tanks that were fed
SELECT * FROM feedinglogs
WHERE feed_date IS NOT NULL
AND food_type IS NOT NULL 
AND amount_grams IS NOT NULL;

--Show the amount of food served in kilograms instead of grams
SELECT amount_grams / 1000.0 AS amount_kilograms FROM feedinglogs;

--Show tanks where the number of fish species inside is odd
SELECT tank_id, COUNT(species_code) AS total_species FROM tankspecies
GROUP BY tank_id
HAVING COUNT(species_code) % 2 = 1
ORDER BY tank_id;

--Show the minimum and maximum water hardness levels for saltwater tanks
SELECT MIN(hardness_ppm) AS minimum_hardness_ppm_saltwater, MAX(hardness_ppm) AS maximum_hardness_ppm_saltwater
FROM waterqualitylogs
JOIN tanks ON waterqualitylogs.tank_id = tanks.tank_id
WHERE water_type = 'saltwater';

--Show the minimum and maximum water hardness levels for freshwater tanks
SELECT MIN(hardness_ppm) AS minimum_hardness_ppm_freshwater, MAX(hardness_ppm) AS maximum_hardness_ppm_freshwater
FROM waterqualitylogs
JOIN tanks ON waterqualitylogs.tank_id = tanks.tank_id
WHERE water_type = 'freshwater';

--Compare the average ph of the two different water types
SELECT water_type, AVG(ph) AS average_ph FROM waterqualitylogs
JOIN tanks ON waterqualitylogs.tank_id = tanks.tank_id
GROUP BY water_type;

--Find out how many grams of food were fed to the fish in total, and return the total in kilograms
SELECT SUM(amount_grams) / 1000.0 AS total_amount_fed_kilograms FROM feedinglogs;