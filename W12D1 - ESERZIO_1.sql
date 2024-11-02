-- Esercizio 1 Effettuate un’esplorazione preliminare del database. 
-- Di cosa si tratta? Quante e quali tabelle contiene? Fate in modo di avere 
-- un’idea abbastanza chiara riguardo a con cosa state lavorando. 


-- Esercizio 2 Scoprite quanti clienti si sono registrati nel 2006. 
SELECT * 
FROM customer
WHERE YEAR(create_date) = 2006;


-- Esercizio 3 Trovate il numero totale di noleggi effettuati il giorno 1/1/2006. 


SELECT *
FROM rental
WHERE CONVERT(rental_date, DATE)= '2006-01-01';

-- Esercizio 4 Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati. 
SELECT 
E.
FROM rental
WHERE WEEK(rental_date) = (SELECT WEEK(MAX(rental_date)) 
						   FROM rental) 
AND YEAR(rental_date) = (SELECT YEAR(MAX(rental_date)) 
						 FROM rental);


-- Esercizio 5 Calcolate la durata media del noleggio per ogni categoria di film.

SELECT 
  E.category_id AS CODICE_CATEGORIA
, MAX(E.name) AS DESCRIZIONE
-- , COUNT(A.rental_id)
-- , SUM(DATEDIFF(return_date, rental_date )) as durata
, CONVERT((SUM(DATEDIFF(return_date, rental_date ))/COUNT(A.rental_id)) , DECIMAL (10,2)) AS DURATA_MEDIA
FROM rental A 
INNER JOIN inventory B 
ON A.inventory_id=B.inventory_id
INNER JOIN film C 
ON B.film_id=C.film_id
INNER JOIN film_category D
ON C.film_id=D.film_id
INNER JOIN category E
ON D.category_id=E.category_id
WHERE A.return_date IS NOT NULL
GROUP BY E.category_id;




-- Esercizio 6 Trovate la durata del noleggio più lungo.

SELECT 
  MAX(E.name) AS CATEGORIA
, MAX(C.title)
, MAX(DATEDIFF(return_date, rental_date )) AS DURATA_NOLEGGIO
FROM rental A 
INNER JOIN inventory B 
ON A.inventory_id=B.inventory_id
INNER JOIN film C 
ON B.film_id=C.film_id
INNER JOIN film_category D
ON C.film_id=D.film_id
INNER JOIN category E
ON D.category_id=E.category_id
WHERE A.return_date IS NOT NULL;