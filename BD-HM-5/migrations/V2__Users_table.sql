ALTER TABLE players
ADD column patronymic varchar(50),
ADD column birth date,
ADD column profession varchar(15),
ADD column nationality varchar(20),
ADD column phone varchar(15) UNIQUE check (phone ~ '^[0-9]*$' ),
ADD column email varchar(50) UNIQUE check (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' ),
ADD constraint player_number_check check ( players_number between 1 and 99);



