ALTER TABLE players
ALTER column profession TYPE varchar(30),
DROP constraint players_phone_check,
ADD constraint players_phone_check check (phone ~ '^[0-9]*-[0-9]*-[0-9]*$');
