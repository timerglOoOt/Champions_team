CREATE TABLE teams (
id SERIAL PRIMARY KEY,
team_name VARCHAR(50),
foundation_year INTEGER,
city VARCHAR(50),
division VARCHAR(50)
);

CREATE TABLE players (
id SERIAL PRIMARY KEY,
name VARCHAR(50),
surname VARCHAR(50),
players_number INTEGER,
position VARCHAR(50),
team_id INTEGER REFERENCES teams(id)
);

CREATE TABLE games (
id SERIAL PRIMARY KEY,
date DATE,
time TIME,
home_team_id INTEGER REFERENCES teams(id),
guest_team_id INTEGER REFERENCES teams(id)
);

CREATE TABLE tickets (
id SERIAL PRIMARY KEY,
number INTEGER,
cost INTEGER,
place VARCHAR(50),
game_id INTEGER REFERENCES games(id)
);

CREATE TABLE stadiums (
id SERIAL PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50),
capacity INTEGER,
game_id INTEGER REFERENCES games(id)
);

CREATE TABLE coaches (
id SERIAL PRIMARY KEY,
name VARCHAR(50),
surname VARCHAR(50),
team_id INTEGER REFERENCES teams(id)
);
