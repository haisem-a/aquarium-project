# Aquarium Project

A PostgreSQL database for managing an aquarium's tanks, the fish in them, their feeding logs, and water quality logs.

## Project overview

This project models a small, normalised aquarium management system. It contains five tables: `tanks`, `fishspecies`, `tankspecies`, `feedinglogs`, and `waterqualitylogs`.

I built this project to practice SQL fundamentals, including DDL, DML, table relationships, constraints, joins, views, stored procedures, and indexing.

## Features

- Relational database design
    - Uses primary and foreign keys to link related tables
    - Includes a structured schema for tanks, fish species, tank species, feeding logs, and water quality logs
    - Uses a junction table to create a many-to-many relationship between the `fishspecies` table and the `tanks` table
- Data validation
    - Uses the `CHECK` constraint for valid water types, pH range, and positive values to prevent invalid or inconsistent data entries
- Data management
    - Includes insert, update, alter, and delete operations across the schema
- Queries
    - Filtering, sorting, and range queries
    - Aggregates such as totals, averages, minimums, and maximums
    - `GROUP BY` and `HAVING` for grouped insights
- Joins and relationships
    - `INNER JOIN` and `LEFT JOIN` used to combine data across multiple tables, including joining two tables via a third junction table
- Data Analysis
    - A variety of queries to answer questions required for managing and monitoring an aquarium
- Views
    - Species count per tank
    - Feeding relationships between species and food types
    - Temperature variance from ideal conditions
- Stored procedures
    - Moves fish between tanks
    - Deletes tanks and associated records safely
- Performance optimisation
    - Index on `tankspecies` to improve query performance when using joins or filtering on `tank_id`, and combined lookups using both `tank_id` and `species_code`

## Technologies Used

- PostgreSQL
- SQL
- PL/pgSQL

## Database Schema

### Tanks

Stores information about each tank in the aquarium including how many litres it holds, whether it holds fresh or salt water, and information about its location.

### Fishspecies

Stores information about each fish species such as their common name, scientific name, a species code, their ideal temperature, and their ideal water type.

### Tankspecies

A junction table used for joins between `fishspecies` and `tanks`. It also shows which, and how many species exist per tank.

### Feedinglogs

Stores records for each tank's feeding logs such as the date, type of food, and amount of food given.

### Water quality logs

Stores results from the water quality tests, including the temperature, the pH level, salinity, hardness, and nitrite levels.

## Example Queries

### 1. Show which fish species belong to each tank

This query joins the `tanks`, `tankspecies`, and `fishspecies` tables to show the common names of the species assigned to each tank.

```sql
SELECT tanks.tank_id, common_name 
FROM tanks
INNER JOIN tankspecies ON tankspecies.tank_id = tanks.tank_id
INNER JOIN fishspecies ON fishspecies.species_code = tankspecies.species_code;
```

### 2. Show the location of the tanks with no feeding date recorded

This query uses a `LEFT JOIN` to return tanks that do not have a feeding date recorded.

```sql
SELECT tanks.tank_id, location, feed_date 
FROM tanks
LEFT JOIN feedinglogs ON tanks.tank_id = feedinglogs.tank_id
WHERE feed_date IS NULL;
```

### 3. Show tanks where the number of fish species is odd

This query groups species by tank and uses `HAVING` to filter grouped results.

```sql
SELECT tank_id, COUNT(species_code) AS total_species
FROM tankspecies
GROUP BY tank_id
HAVING COUNT(species_code) % 2 = 1
ORDER BY tank_id;
```

### 4. Compare the average pH of freshwater and saltwater tanks

This query joins water quality logs with tank data, groups the results by water type, and calculates the average pH for each group.

```sql
SELECT water_type, AVG(ph) AS average_ph
FROM waterqualitylogs
JOIN tanks ON waterqualitylogs.tank_id = tanks.tank_id
GROUP BY water_type;
```

### 5. Show the minimum and maximum hardness levels for saltwater tanks

This query uses aggregate functions to summarize water hardness levels for saltwater tanks.

```sql
SELECT 
    MIN(hardness_ppm) AS minimum_hardness_ppm_saltwater,
    MAX(hardness_ppm) AS maximum_hardness_ppm_saltwater
FROM waterqualitylogs
JOIN tanks ON waterqualitylogs.tank_id = tanks.tank_id
WHERE water_type = 'saltwater';
```

### 6. Show the total amount of food served in kilograms

This query uses `SUM` to calculate the total amount of food served and converts the result from grams to kilograms.

```sql
SELECT SUM(amount_grams) / 1000.0 AS total_amount_fed_kilograms 
FROM feedinglogs;
```

## Views

This project includes views to make repeated queries easier to run and understand.

### `tank_species_count_view`

Shows how many fish species are assigned to each tank.

```sql
CREATE VIEW tank_species_count_view AS
SELECT tank_id, COUNT(species_code) AS species_count
FROM tankspecies
GROUP BY tank_id
ORDER BY tank_id ASC;
```

### `species_food`

Shows what food type each fish was fed.

```sql
CREATE VIEW species_food AS
SELECT common_name, food_type
FROM fishspecies
INNER JOIN tankspecies ON fishspecies.species_code = tankspecies.species_code
INNER JOIN feedinglogs on feedinglogs.tank_id = tankspecies.tank_id;
```

### `temperature_variance`

Shows the difference between each fish species' ideal temperature and the recorded tank temperature.

```sql
CREATE VIEW temperature_variance AS
SELECT scientific_name, ideal_temperature_celsius - temperature_celsius AS temperature_difference
FROM waterqualitylogs
INNER JOIN tankspecies ON waterqualitylogs.tank_id = tankspecies.tank_id
INNER JOIN fishspecies ON fishspecies.species_code = tankspecies.species_code;
```

## Stored Procedures

This project includes stored procedures to make common database actions easier to perform.

### `change_fish_tank`

Moves a fish species from one tank to another.

```sql
CREATE PROCEDURE change_fish_tank (
    p_species_code TEXT,
    p_old_tank_id INTEGER,
    p_new_tank_id INTEGER
)
LANGUAGE plpgsql
AS $BODY$
BEGIN
    UPDATE tankspecies
    SET tank_id = p_new_tank_id
    WHERE tank_id = p_old_tank_id
    AND species_code = p_species_code;
END
$BODY$;
```

### `delete_tank`

Deletes a tank and its related records from the database, including records from `tankspecies`, `feedinglogs`, and `waterqualitylogs`.

```sql
CREATE PROCEDURE delete_tank (
    p_tank_id INTEGER
)
LANGUAGE plpgsql
AS $BODY$
BEGIN
    DELETE FROM tankspecies WHERE tank_id = p_tank_id;
    DELETE FROM feedinglogs WHERE tank_id = p_tank_id;
    DELETE FROM waterqualitylogs WHERE tank_id = p_tank_id;
    DELETE FROM tanks WHERE tank_id = p_tank_id;
END
$BODY$;
```

## Performance Optimisation

An index was created on the `tankspecies` table to support faster lookups and joins using `tank_id` and `species_code`.

```sql
CREATE INDEX tankspecies_idx
ON tankspecies (tank_id, species_code);
```

## How to Run

1. Install PostgreSQL.
2. Create a new database.
3. Open the SQL file in pgAdmin, psql, or another PostgreSQL client.
4. Run the script from top to bottom.
5. Run the example queries to explore the data.

If using `psql`, the script can be run with:

```sql
\i schema.sql
\i queries.sql
```

## What I Learnt

Throughout this project, I practised:

- Creating a normalised, relational database
- Choosing primary and foreign keys
- Creating a many-to-many relationship using a junction table
- Using constraints to improve data validation
- Inserting, updating, altering, and deleting records
- Using clauses such as `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `LIMIT`, and `OFFSET`
- Using aggregate functions such as `COUNT`, `MIN`, `MAX`, `AVG`, and `SUM`
- Joining tables using `INNER JOIN` and `LEFT JOIN`
- Creating views
- Writing basic PostgreSQL stored procedures
- Creating indexes for query performance

## Future Improvements

This was my first SQL project, so the focus was on learning the basics of SQL and creating a strong foundation in relational database design, queries, indexes, stored procedures, and views.

Going forward, I want to continue developing my SQL skills by focusing on:

- Building confidence by writing more advanced queries using subqueries and common table expressions
- Improving my understanding of database normalisation and when to denormalise
- Practising more complex joins across larger datasets
- Practising data cleaning and transformation tasks with SQL

This project has given me a starting point, and my next goal is to keep building on these foundations by solving more complex data problems with larger datasets.