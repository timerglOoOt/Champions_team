alter table players
alter column job type varchar(30),
drop constraint players_phone_number_check,
add constraint  players_phone_number_check check ( phone_number ~ '^[0-9]-[0-9]-[0-9]*$' );