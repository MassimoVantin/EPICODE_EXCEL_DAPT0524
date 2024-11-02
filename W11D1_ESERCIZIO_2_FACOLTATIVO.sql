-- Esercizio 1 Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”. 

SELECT 
  A.Name AS TRACCIA
, B.Name AS GENERE
FROM track A 
LEFT OUTER JOIN genre B 
ON A.GenreId=B.GenreId
WHERE B.Name IN ('POP','ROCK')
ORDER BY A.Name;



-- Esercizio 2 Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”. 

SELECT 
  TITLE AS DESCRIZIONE
, 'Album' AS TIPO
FROM album
WHERE TITLE LIKE 'A%'

UNION

SELECT 
  Name 
, 'Artista'
FROM artist
WHERE Name LIKE 'A%';


-- Esercizio 3 Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti. 

SELECT 
  A.Name AS TRACCIA
, B.Name AS GENERE
, SEC_TO_TIME(CAST(A.Milliseconds/1000 AS DECIMAL (10,2))) AS DURATA
FROM track A 
LEFT OUTER JOIN genre B 
ON A.GenreId=B.GenreId
WHERE B.Name ='JAZZ'
AND CAST(A.Milliseconds/1000/60 AS DECIMAL (10,2))>3
ORDER BY A.Name;

-- Esercizio 4 Recuperate tutte le tracce più lunghe della durata media.

SELECT 
  A.Name AS TRACCIA
, SEC_TO_TIME(CAST(A.Milliseconds/1000 AS DECIMAL (10,2))) AS DURATA 
, SEC_TO_TIME(CAST((SELECT AVG(Milliseconds)  FROM TRACK)/1000 AS DECIMAL (10,2))) AS DURATA_MEDIA
FROM track A 
WHERE A.Milliseconds>(SELECT AVG(Milliseconds)  FROM TRACK)
ORDER BY A.Milliseconds DESC;


-- Esercizio 5 Esercizio Query Avanzate Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti. 
SELECT DISTINCT
B.Name AS GENERE
FROM track A 
INNER JOIN genre B 
ON A.GenreId=B.GenreId
WHERE A.Milliseconds>(4*60*1000);


-- Esercizio 6 Individuate gli artisti che hanno rilasciato più di un album. 

SELECT *
FROM artist A ;

SELECT 
  A.ArtistId AS CODICE_ARTISTA
, MAX(B.Name) AS NOME
, COUNT(*) AS NR_ALBUM
FROM album A 
INNER JOIN artist B 
ON A.ArtistId=B.ArtistId
GROUP BY A.ArtistId
HAVING COUNT(*) >1
ORDER BY COUNT(*) DESC;

-- Esercizio 7 Trovate la traccia più lunga in ogni album. 

SELECT  A.AlbumId , MAX(A.Name), MAX(A.Milliseconds) AS DURATA
			FROM  track A GROUP BY A.AlbumId;



SELECT 
  C.AlbumId AS CODICE_ALBUM
, C.Title AS TITOLO_ALBUM
, A.Name AS TITOLO_BRANO
, SEC_TO_TIME(CAST(A.Milliseconds/1000 AS DECIMAL (10,2))) AS DURATA
FROM track A 
INNER JOIN (SELECT  A.AlbumId 
				  , MAX(A.Milliseconds) AS DURATA
			FROM  track A 
            GROUP BY A.AlbumId) B
ON A.AlbumId=B.AlbumId AND A.Milliseconds=B.DURATA
LEFT OUTER JOIN album C 
ON A.AlbumId=C.AlbumId
ORDER BY C.AlbumId;


-- Esercizio 8 Individuate la durata media delle tracce per ogni album. 


-- Esercizio 9 Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.