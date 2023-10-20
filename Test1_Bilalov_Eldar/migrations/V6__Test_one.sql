CREATE TABLE rooms
(
    id              SERIAL PRIMARY KEY,
    number          INT check ( number between 1 and 390),
    number_of_rooms SMALLINT check ( number_of_rooms between 1 and 9),
    room_level      varchar(10) NOT NULL,
    price_per_night INT check ( price_per_night between 1200 and 100000),
    availability    BOOLEAN     NOT NULL,
    description     varchar(1000)
);

CREATE TABLE guests
(
    id      SERIAL PRIMARY KEY,
    name    varchar(20) NOT NULL,
    surname varchar(20) NOT NULL,
    gender  BOOLEAN     NOT NULL,
    birth   DATE        NOT NULL,
    phone   varchar(15) UNIQUE check (phone ~ '^[0-9]*$' ),
    email   varchar(50) UNIQUE check (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' )
);

CREATE TABLE reservations
(
    id               SERIAL PRIMARY KEY,
    guest_id         INTEGER REFERENCES guests (id),
    room_id          INTEGER REFERENCES rooms (id),
    reservation_date DATE default current_date,
    check_in_date    DATE check ( check_in_date > current_date and check_in_date <= check_out_date),
    check_out_date   DATE check ( check_out_date > current_date and check_out_date >= check_in_date),
    cost             INT check ( cost between 1200 and 1000000)
);

INSERT INTO rooms (number, number_of_rooms, room_level, price_per_night, availability, description)
VALUES (1, 1, 'economy', 1500, true, 'It is a good room'),
       (27, 2, 'economy', 2000, true, 'It is a good room'),
       (39, 2, 'economy', 2100, false, 'It is a good room'),
       (42, 4, 'standart', 4000, true, 'It is a really good room'),
       (309, 3, 'luxe', 6000, true, 'It is a very good room');

INSERT INTO guests (name, surname, gender, birth, phone, email)
VALUES ('Adel', 'Syeta', false, '2005-03-01', '79195435679', 'syeta@gmail.com'),
       ('Max', 'Maers', false, '2002-07-21', '79195434678', 'Maers@gmail.com'),
       ('Marat', 'Dalon', false, '2001-02-11', '79185435678', 'Dalon@gmail.com'),
       ('Timur', 'Prodex', false, '1999-10-27', '89195435678', 'Prodex@gmail.com'),
       ('Dima', 'Woter', false, '1885-01-09', '71195435678', 'Woter@gmail.com');

INSERT INTO reservations (guest_id, room_id, check_in_date, check_out_date, cost)
VALUES (1, 2, '2023-10-25', '2023-10-26', 4000),
       (1, 4, '2023-10-27', '2023-10-29', 12000),
       (2, 5, '2023-11-21', '2023-11-22', 6000),
       (4, 1, '2023-11-01', '2023-11-02', 3000),
       (5, 2, '2023-11-15', '2023-11-17', 6000);



