-- Tanks table schema
CREATE TABLE tanks (
    tank_id INTEGER PRIMARY KEY,
    size_litres FLOAT,
    water_type TEXT,
    system_type TEXT,
    location_type TEXT,
    location TEXT
);

-- Fish Species table schema
CREATE TABLE fishspecies (
    species_code TEXT PRIMARY KEY,
    species_id TEXT,
    common_name TEXT,
    scientific_name TEXT,
    ideal_temperature_celsius FLOAT
);

-- Tank Species table schema
CREATE TABLE tankspecies (
    tank_id INTEGER REFERENCES tanks(tankid),
    species_code TEXT REFERENCES fishspecies(speciescode)
);

-- Feeding Logs table schema
CREATE TABLE feedinglogs (
    log_id TEXT PRIMARY KEY,
    tank_id INTEGER REFERENCES tanks(tankid),
    feed_date DATE,
    food_type TEXT,
    amount_grams FLOAT
);

-- Water Quality Logs table schema
CREATE TABLE waterqualitylogs(
    test_id TEXT PRIMARY KEY,
    tank_id INTEGER REFERENCES tanks(tankid),
    test_date DATE,
    temperature_celsius FLOAT,
    ph FLOAT,
    saltinity_ppt FLOAT,
    hardness_ppm FLOAT,
    nitrite_ppm FLOAT
);