INSERT INTO tanks
(tank_id, size_litres, water_type, system_type, location_type, location)
VALUES (1, 115, 'freshwater', 'semi-open', 'outdoor exhibit', '2a'),
(2, 123, 'saltwater', 'semi-open', 'filtration room', '1c'),
(3, 99, 'saltwater', 'open', 'outdoor exhibit', '2b'),
(4, 95, 'saltwater', 'closed', 'storage room', '3a'),
(5, 155, 'freshwater', 'semi-open', 'filtration room', '1b'),
(6, 421, 'freshwater', 'open', 'outdoor exhibit', '2c'),
(7, 216, 'saltwater', 'semi-open', 'filtration room', '1a');

INSERT INTO fishspecies
(species_code, species_id, common_name, scientific_name, ideal_temperature_celsius)
VALUES ('COD', 'A', 'Atlantic Cod', 'Gadus Morhua', 5),
('RJM', 'B', 'Spotted Ray', 'Raja Montagui', 12),
('HAD', 'C', 'Haddock', 'Melanogrammus Aeglefinus', 9),
('SQR', 'D', 'European Squid', 'Loligo Vulgaris', 19),
('GAR', 'E', 'Garfish', 'Belone Belone', 25),
('LIN', 'F', 'Ling', 'Molva Molva', 6),
('ILL', 'G', 'Shortfin Squids Nei', 'Illex Spp', 15),
('TFT', 'H', 'Yellowfin Tuna', 'Thunnus Albacares', 19),
('MOL', 'I', 'Common Mola', 'Mola Mola', 14),
('BET', 'J', 'Bigeye Tuna', 'Thunnus Obesus', 15),
('BRT', 'K', 'Brown Tang', 'Zebrasoma Scopas', 14),
('BUL', 'L', 'Bullhead', 'Cottus Gobio', 6),
('TEN', 'M', 'Tench', 'Tinca Tinca', 27),
('KAN', 'N', 'King Angelfish', 'Holacanthus Passer', 15),
('GAF', 'O', 'Grey Angelfish', 'Pomacanthus Arcuatus', 14),
('SAL', 'P', 'Atlantic Salmon', 'Salmo Salar', 27),
('PAL', 'Q', 'Palometa', 'Trachinotus Goodei', 19),
('WHG', 'R', 'White Grunt', 'Haemulon Plumierii', 15),
('ANG', 'S', 'Eel', 'Anguilla Anguilla ', 28),
('ISJ', 'T', 'Island Jack', 'Ferdauia Orthogrammus', 10),
('DOG', 'U', 'Dogtooth Tuna', 'Gymnosarda Unicolor', 16),
('BRW', 'V', 'Brown Trout', 'Salmo Trutta', 5);

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