alter table teams
add constraint uq_team unique (team_name);

alter table tickets
add constraint uq_number unique (number),
add constraint uq_place unique (place);