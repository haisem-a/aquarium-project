-- Tanks table schema
CREATE TABLE tanks (
    tank_id INTEGER PRIMARY KEY,
    size_litres FLOAT,
    water_type TEXT,
    system_type TEXT,
    location_type TEXT,
    location TEXT
)