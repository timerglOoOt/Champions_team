-- Вывести список кассиров, у которых опыт работы больше
-- 5 лет, отсортированных по фамилии в алфавитном порядке
SELECT * FROM cashier
         WHERE experience > 5 ORDER BY surname ASC;

--Вывести список покупок, совершенных в магазине за
-- последний месяц, отсортированных по дате транзакции
-- в обратном порядке
SELECT * FROM candy_shop_cash_register
         WHERE date_of_transaction >= now() - interval '1 month' ORDER BY date_of_transaction DESC;

-- Вывести список конфет, у которых количество больше
-- 10 и цена меньше 100, отсортированных по имени, ограничив результат 5 записями
SELECT name FROM candies
         WHERE count > 10 AND cost < 100 GROUP BY name LIMIT 5;