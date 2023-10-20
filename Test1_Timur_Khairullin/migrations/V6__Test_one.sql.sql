create table  cashier (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) not null,
    surname VARCHAR(50),
    experience integer check ( experience >= 0 ) not null,
    access_to_cash boolean not null,
    phone_number varchar(11) unique check ( phone_number ~ '^[0-9]{11}$' ),
    home_address varchar(70)
);
create table candy_shop_cash_register (
    id SERIAL primary key,
    number_of_goods integer,
    price integer not null,
    bank_account varchar(20) check ( bank_account ~ '^[0-9]{20}$' ),
    email varchar(50) unique check ( email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' ),
    date_of_transaction date,
    cashier_id integer references cashier(id)
);

create table candies (
    id SERIAL primary key,
    name varchar(50) not null,
    description varchar(500),
    count integer check ( count >= 0 ),
    cost integer not null
);

insert into cashier(name, surname, experience, access_to_cash, phone_number, home_address) values
   ('Иван', 'Иванов', 2, false, '88005553535', 'ул. Пушкина, дом 13'),
   ('Асхаб', 'Тамаев', 1, true, '88005553115', 'ул. Президента мира, дом 1'),
   ('Тимур', 'Хайруллин', 20, true, '88888888888', 'ул. Суетная, дом 777'),
   ('Андрей', 'Донской', 7, false, '88005553577', 'ул. Университетская, дом 4'),
   ('Сергей', 'Сергеев', 15, true, '89997776661', 'ул. Пушкина, дом 10');

insert into candy_shop_cash_register(number_of_goods, price, bank_account, email, date_of_transaction, cashier_id) values
    (3, 1000, '12345678901234567890', 'mero@yahoo.com', '2023-07-10', 1),
    (66, 1000000, '12345678901234567895', 'massey@mail.com', '2023-05-10', 2),
    (30, 999900, '12345678901234567893', 'tristan.kinney@mail.com', '2023-07-02', 1),
    (3, 1000, '12345678901234567892', 'romero@yahoo.com', '2023-07-10', 4),
    (1, 50, '12345678901234567891', 'romo@yahoo.com', '2023-07-10', 5);

insert into candies(name, description, count, cost) values
    ('Milka', 'ifyveb efiebfbeif efy8vefbeuf efeuvfeeeeeee', 20, 89),
    ('Choco pie', 'ifyveb efiebfbeif efy8vefbeuf', 10, 130),
    ('Cookie', 'efiebfbe efeuvfeeeeeee', 7, 50),
    ('Sugar candy', 'ifyveb efiebfdhfddd', 2000, 13),
    ('Сaramel', 'mmm yummy', 100000, 9);