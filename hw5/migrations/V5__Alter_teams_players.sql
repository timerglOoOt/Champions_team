alter table players
drop constraint players_phone_number_check,
add constraint  players_phone_number_check check ( phone_number ~ '^[0-9]*-[0-9]*-[0-9]*$' );

insert into teams (team_name, foundation_year, city, division) values
            ('Ak_Bars', 1956, 'Kazan', 'Дивизион Харламов');