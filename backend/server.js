const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const axios = require('axios');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

const COUNTRIES_API_BASE_URL = process.env.COUNTRIES_API_BASE_URL || 'https://restcountries.com/v3.1';
const STATIC_COUNTRY_DATA = {
  canada: { country: 'Canada', capital: 'Ottawa', population: 41000000, region: 'Americas' },
  nigeria: { country: 'Nigeria', capital: 'Abuja', population: 223800000, region: 'Africa' },
  france: { country: 'France', capital: 'Paris', population: 68000000, region: 'Europe' },
  japan: { country: 'Japan', capital: 'Tokyo', population: 124500000, region: 'Asia' },
  germany: { country: 'Germany', capital: 'Berlin', population: 84500000, region: 'Europe' },
  ghana: { country: 'Ghana', capital: 'Accra', population: 34100000, region: 'Africa' },
  kenya: { country: 'Kenya', capital: 'Nairobi', population: 55500000, region: 'Africa' },
  brazil: { country: 'Brazil', capital: 'Brasilia', population: 203100000, region: 'Americas' },
  usa: { country: 'United States', capital: 'Washington, D.C.', population: 340000000, region: 'Americas' },
  'united states': { country: 'United States', capital: 'Washington, D.C.', population: 340000000, region: 'Americas' },
  uk: { country: 'United Kingdom', capital: 'London', population: 69100000, region: 'Europe' },
  'united kingdom': { country: 'United Kingdom', capital: 'London', population: 69100000, region: 'Europe' },
};

const normalizeCountryKey = (value = '') => value.trim().toLowerCase();

async function lookupCountry(country) {
  const staticMatch = STATIC_COUNTRY_DATA[normalizeCountryKey(country)];

  if (staticMatch) {
    return staticMatch;
  }

  const response = await axios.get(`${COUNTRIES_API_BASE_URL}/name/${encodeURIComponent(country)}`);
  const countryInfo = response.data[0];

  if (!countryInfo || !countryInfo.capital || !countryInfo.capital.length) {
    return null;
  }

  return {
    country,
    capital: countryInfo.capital[0],
    population: countryInfo.population,
    region: countryInfo.region,
  };
}

const healthHandler = (req, res) => {
  res.status(200).json({ status: 'ok' });
};

app.get('/api/health', healthHandler);

app.get('/api/destinations', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM destinations ORDER BY id DESC');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/api/destinations', async (req, res) => {
  const { country } = req.body;
  try {
    const destination = await lookupCountry(country);

    if (!destination) {
      return res.status(400).json({ error: 'Country data not found' });
    }
    
    const result = await pool.query(
      'INSERT INTO destinations (country, capital, population, region) VALUES ($1, $2, $3, $4) RETURNING *',
      [destination.country, destination.capital, destination.population, destination.region]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.delete('/api/destinations/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query('DELETE FROM destinations WHERE id = $1', [id]);
    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

if (require.main === module) {
  app.listen(port, () => {
    console.log(`Server running on port ${port}`);
  });
}

module.exports = { app, healthHandler };
