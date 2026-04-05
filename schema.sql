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
    ideal_temperature_c FLOAT
);