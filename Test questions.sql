/*CREATE TABLE transactions(
	"date" DATE,
	transid SMALLSERIAL,
	userid INT,
	amount SMALLINT,
	transactiontype VARCHAR(200)
);

CREATE TABLE users(
	userid INT,
	registrationdate DATE,
	city VARCHAR(200),
	age SMALLINT,
	datemodified DATE
);
*/

--Write a query which whenever you run it will return all the Users who made a deposit in the last 30 days from the day you run it. --
SELECT
	userid
FROM transactions
WHERE date > '2020/10/27'::date - '30 days':: interval AND transactiontype = 'Deposit';

CREATE TABLE combined_table AS (
	SELECT	*
	FROM transactions
	JOIN users
	USING (userid)
);

--install extension for cross tabulation--
CREATE EXTENSION tablefunc;

--To delete extension--
--DROP EXTENSION IF EXISTS tablefunc--

--Write query that sums and counts deposits per user city--
SELECT
	city,
	sum(amount),
	count(*)
FROM transactions AS t
JOIN users AS u
ON t.userid = u.userid
WHERE transactiontype = 'Deposit'
GROUP BY city;

--Write a query that shows all the users and their latest information.--
SELECT *
FROM combined_table;

--Write a query that shows all the users and their latest information--
SELECT *
FROM USERS
JOIN TRANSACTIONS
ON USERS.userid = TRANSACTIONS.userid
ORDER BY datemodified DESC