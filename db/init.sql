-- Dream Vacations Database Schema
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS vacations (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    destination VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO users (email, password) VALUES ('user@example.com', 'password123') ON CONFLICT DO NOTHING;
INSERT INTO vacations (user_id, destination, start_date, end_date) VALUES (1, 'Hawaii', '2024-12-20', '2024-12-27') ON CONFLICT DO NOTHING;
