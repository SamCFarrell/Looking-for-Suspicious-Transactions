SELECT * FROM card_holder;
SELECT * FROM credit_card;
SELECT * FROM merchant;
SELECT * FROM merchant_category;
SELECT * FROM transaction;

--How can you isolate (or group) the transactions of each cardholder?--
CREATE VIEW transactions_per_ch AS
SELECT c.name, COUNT(*) AS count
FROM transaction AS a
JOIN credit_card as b on a.card = b.card
JOIN card_holder as c on b.cardholder_id = c.id
GROUP BY c.name;

--Count the transactions that are less than $2.00 per cardholder--
CREATE VIEW microtransactions_per_ch AS
SELECT c.name, COUNT(*) AS count_under_2
FROM transaction AS a
JOIN credit_card as b on a.card = b.card
JOIN card_holder as c on b.cardholder_id = c.id
WHERE amount < 2.0
GROUP BY c.name;

--Is there any evidence to suggest that a credit card has been hacked? Explain your rationale--
----Yes. The average number of transactions under $2.00 per cardholder is 14. Some cardholders have more than 20

--What are the top 100 highest transactions made between 7:00 am and 9:00 am?--
CREATE VIEW highest_9t7 AS
SELECT date, amount
FROM transaction AS t
WHERE date_part('hour', t.date) >= 7
AND date_part('hour', t.date) < 9
ORDER BY amount DESC
LIMIT 100;

--Do you see any anomalous transactions that could be fraudulent?--
----The bottom 9. They are so much larger and increase so much more dramatically than the ones below.

--Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?--
----No, 9am-7am only has about 9 fraudulent transactions. The rest of the day has more than 80 in total

--If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.--
----N/A

--What are the top 5 merchants prone to being hacked using small transactions?
CREATE VIEW vulnerable_merchants AS
SELECT name, COUNT(*) AS fraud_count
FROM merchant AS a
JOIN transaction AS b on a.id = b.id_merchant
WHERE amount < 2.00
GROUP BY name
ORDER BY COUNT(*) DESC
LIMIT 5;

--Create a view for each of your queries.--