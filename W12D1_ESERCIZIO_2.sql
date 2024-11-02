-- Esercizio 1 Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006. 
SELECT * 
FROM customer A 
WHERE A.customer_id NOT IN (SELECT customer_id 
							FROM rental 
                            WHERE CONVERT(rental_date, DATE)>='2006-01-01' 
                            AND CONVERT(rental_date, DATE)<='2006-01-31' );


-- Esercizio 2 Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005 
-- NON CI SONO FILM NOLEGGIATI NELL'ULTIMO QUARTO DEL 2005!!!!!
SELECT 
C.title AS FILM
, COUNT(A.rental_id) AS TOTALE_NOLEGGI
FROM rental A 
INNER JOIN inventory B
ON A.inventory_id=B.inventory_id
INNER JOIN film C
ON B.film_id=C.film_id
WHERE CONVERT(rental_date, DATE)>='2005-09-01' 
AND CONVERT(rental_date, DATE)<='2005-12-31' 
GROUP BY C.title
ORDER BY COUNT(A.rental_id) DESC
LIMIT 10;

-- Esercizio 3 Trovate il numero totale di noleggi effettuati il giorno 1/1/2006. 
-- NON CI SONO FILM NOLEGGIATI IL 01/01/2006!!!!!

SELECT *
FROM rental
WHERE CONVERT(rental_date, DATE)= '2006-01-01';

-- Esercizio 4 Calcolate la somma degli incassi generati nei weekend (sabato e domenica). 
SELECT
  CONVERT(A.rental_date, DATE) AS DATA_NOLEGGIO
, DAYNAME(A.rental_date) AS GIORNO
, SUM(B.amount) AS TOTALE
FROM rental A 
LEFT OUTER JOIN payment B
ON A.rental_id=B.rental_id
WHERE DAYNAME(A.rental_date) IN ('Saturday','Sunday')
GROUP BY CONVERT(A.rental_date, DATE), DAYNAME(A.rental_date);



-- Esercizio 5 Individuate il cliente che ha speso di più in noleggi.




-- Esercizio 6 Elencate i 5 film con la maggior durata media di noleggio.

-- Esercizio 7 Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente. 

-- Esercizio 8 Individuate il numero di noleggi per ogni mese del 2005. 

-- Esercizio 9 Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno. 

-- Esercizio 10 Calcolate il tempo medio di noleggio.

