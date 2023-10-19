ALTER TABLE teams
ADD CONSTRAINT uq_team UNIQUE (team_name);

ALTER TABLE tickets
ADD constraint uq_number UNIQUE (number),
ADD constraint uq_place UNIQUE (place);
