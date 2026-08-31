-- Dream Vacations Database Schema
CREATE TABLE IF NOT EXISTS destinations (
    id SERIAL PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    capital VARCHAR(255) NOT NULL,
    population BIGINT NOT NULL,
    region VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO destinations (country, capital, population, region)
VALUES ('Canada', 'Ottawa', 41000000, 'Americas');
