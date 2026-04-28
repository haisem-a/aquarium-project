-- Tanks table schema
CREATE TABLE tanks (
    tank_id INTEGER PRIMARY KEY,
    size_litres FLOAT,
    water_type TEXT,
    system_type TEXT,
    location_type TEXT,
    location TEXT
);

ALTER TABLE tanks
ALTER COLUMN size_litres TYPE NUMERIC(8,2);

-- Fish Species table schema
CREATE TABLE fishspecies (
    species_code TEXT PRIMARY KEY,
    species_id TEXT,
    common_name TEXT,
    scientific_name TEXT,
    ideal_temperature_celsius FLOAT
);

ALTER TABLE fishspecies DROP COLUMN species_id;

ALTER TABLE fishspecies ADD COLUMN ideal_water_type TEXT;

-- Tank Species table schema
CREATE TABLE tankspecies (
    tank_id INTEGER REFERENCES tanks(tank_id),
    species_code TEXT REFERENCES fishspecies(species_code),
    PRIMARY KEY (tank_id, species_code)
);

-- Feeding Logs table schema
CREATE TABLE feedinglogs (
    log_id TEXT PRIMARY KEY,
    tank_id INTEGER REFERENCES tanks(tank_id),
    feed_date DATE,
    food_type TEXT,
    amount_grams FLOAT
);

ALTER TABLE feedinglogs
ALTER COLUMN amount_grams TYPE NUMERIC(8,2);

-- Water Quality Logs table schema
CREATE TABLE waterqualitylogs (
    test_id TEXT PRIMARY KEY,
    tank_id INTEGER REFERENCES tanks(tank_id),
    test_date DATE,
    temperature_celsius FLOAT,
    ph FLOAT,
    salinity_ppt FLOAT,
    hardness_ppm FLOAT,
    nitrite_ppm FLOAT
);