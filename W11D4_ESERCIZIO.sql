-- Esercizio 1 Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. 

SELECT 
B.GenreId
, MAX(B.Name)
, COUNT(TrackId)
FROM track A 
INNER JOIN genre B 
ON A.GenreId= B.GenreId
GROUP BY B.GenreId
HAVING COUNT(B.GenreId)>= 10
ORDER BY COUNT(B.GenreId) DESC;


-- Esercizio 2 Trovate le tre canzoni più costose. 


SELECT 
TrackId
, Name 
, UnitPrice 
FROM track
ORDER BY UnitPrice DESC
LIMIT 3;


-- Esercizio 3 Elencate gli artisti che hanno canzoni più lunghe di 6 minuti. 
SELECT DISTINCT
  C.Name
FROM track A 
INNER JOIN album B 
ON A.AlbumId=B.AlbumId
INNER JOIN artist C 
ON B.ArtistId=C.ArtistId
WHERE  CAST(A.Milliseconds/1000/60 AS DECIMAL (10,2))>6
ORDER BY C.Name;



-- Esercizio 4 Individuate la durata media delle tracce per ogni genere. 

SELECT 
  B.GenreId
, B.Name AS GENERE
, SEC_TO_TIME((AVG(CAST(A.Milliseconds/1000 AS DECIMAL (10,2))))) AS DURATA_MEDIA_1
, SEC_TO_TIME(SUM(CAST(A.Milliseconds/1000 AS DECIMAL (10,2)))/COUNT(TrackId)) AS DURATA_MEDIA_2
FROM track A 
LEFT OUTER JOIN genre B 
ON A.GenreId=B.GenreId
GROUP BY B.GenreId, B.Name
ORDER BY B.Name;





-- Esercizio 5 Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome. 

SELECT
B.Name AS GENERE
,A.Name AS TITOLO
FROM track A 
LEFT OUTER JOIN genre B 
ON A.GenreId=B.GenreId
WHERE A.Name LIKE '%Love %' OR A.Name LIKE '% Love' OR A.Name LIKE 'Love'
ORDER BY  A.Name;


-- Esercizio 6 Trovate il costo medio per ogni tipologia di media.

SELECT 
B.MediaTypeId AS GENEREID
, MAX(B.Name) AS GENERE
, SUM(UnitPrice)/COUNT(TrackId) AS PREZZO_MEDIO
FROM track A 
LEFT OUTER JOIN mediatype B 
ON A.MediaTypeId=B.MediaTypeId
GROUP BY B.MediaTypeId;


-- Esercizio 7 Individuate il genere con più tracce. 
SELECT 
  B.GenreId
, MAX(B.Name)
, COUNT(A.TrackId)
FROM track A 
INNER JOIN genre B 
ON A.GenreId=B.GenreId
GROUP BY B.GenreId
ORDER BY COUNT(A.TrackId) DESC
LIMIT 1;


-- Esercizio 8 Esercizio Query Avanzate Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones. 

SELECT 
B.Name AS ARTISTA
, COUNT(AlbumId) AS NR_ALBUM
FROM album A 
INNER JOIN artist B 
ON A.ArtistId=B.ArtistId
GROUP BY B.Name
HAVING COUNT(AlbumId) = (SELECT 
						 count(*)
						 FROM album A 
						 INNER JOIN artist B 
						 ON A.ArtistId=B.ArtistId
						 WHERE B.Name LIKE 'The Rolling Stones');


-- Esercizio 9 Trovate l’artista con l’album più costoso. 

SELECT 
  C.Name
, B.AlbumId
, B.Title
, SUM(A.UnitPrice)
FROM track A 
INNER JOIN album B 
ON A.AlbumId=B.AlbumId
INNER JOIN artist C 
ON B.ArtistId=C.ArtistId
GROUP BY   C.Name
			, B.AlbumId
			, B.Title
ORDER BY SUM(A.UnitPrice) DESC
LIMIT 1;




/*TIP: Alcuni di questi esercizi possono essere complessi, cercate di suddividere la richiesta in piccoli step, 
       applicate un approccio logico e risolvete gli step uno alla volta prima di unificarli e giungere alla soluzione.
*/