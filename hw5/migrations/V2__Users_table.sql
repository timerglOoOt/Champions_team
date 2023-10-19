alter table players
add column patronymic varchar(50),
add column birthday date,
add column job varchar(15),
add column nationality varchar(30),
add column phone_number varchar(15) unique check ( phone_number ~ '^[0-9]*$' ),
add column email varchar(50) unique check ( email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' ),
add constraint players_number_check check ( players_number between 1 and 99 );