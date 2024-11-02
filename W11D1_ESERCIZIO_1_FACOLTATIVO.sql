-- Esercizio 1 Cominciate facendo un’analisi esplorativa del database,  ad esempio: Fate un elenco di tutte le tabelle. 
   SELECT * 
   FROM album;
   
   SELECT * 
   FROM artist;   
   
   SELECT * 
   FROM customer;
   
   SELECT * 
   FROM employee;   
   
   SELECT * 
   FROM genre;      
      
   SELECT * 
   FROM invoice;
   
   SELECT * 
   FROM invoiceline;   
   
   SELECT * 
   FROM mediatype;
   
   SELECT * 
   FROM   playlist;
   
   
   SELECT * 
   FROM   playlisttrack;
   
   SELECT * 
   FROM   track;
   
 --  Visualizzate le prime 10 righe della tabella Album.    
 SELECT * 
 FROM album
 LIMIT 10;
  
   
 --  Trovate il numero totale di canzoni della tabella Tracks. 
SELECT TrackId, COUNT(*) 
FROM   track
GROUP BY TrackId
HAVING COUNT(*)>1;

SELECT COUNT(*)  
FROM track;
-- TOTALE TRACCIE 3503 
   
   
--   Trovate i diversi generi presenti nella tabella Genre. … …
SELECT DISTINCT Name 
FROM genre;   
-- 25 GENERI DIVERSI   


--   Effettuate tutte le query esplorative che vi servono per prendere confidenza con i dati. 
   
--   Esercizio 2 Recuperate il nome di tutte le tracce e del genere associato. 

SELECT A.Name, B.Name
FROM track A 	
LEFT OUTER JOIN genre B 
ON A.GenreId=B.GenreId;
   
   
--   Esercizio 3 Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. 


SELECT DISTINCT A.Name 
FROM Artist A 
INNER JOIN album B
ON A.ArtistId=B.ArtistId;
  
--   Esistono artisti senza album nel database?

SELECT * 
FROM Artist A 
LEFT OUTER JOIN album B
ON A.ArtistId=B.ArtistId
WHERE AlbumId IS NULL;

-- Esercizio 4 Esercizio Join Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. 
-- Esiste un modo per recuperare il nome della tipologia di media? 

SELECT 
  A.Name AS TITOLO_BRANO
, B.Name AS GENERE
, C.Name AS TIPO_MEDIA
FROM track A 	
LEFT OUTER JOIN genre B 
ON A.GenreId=B.GenreId
LEFT OUTER JOIN mediatype C 
ON A.MediaTypeId=C.MediaTypeId;


-- Esercizio 5 Elencate i nomi di tutti gli artisti e dei loro album.

SELECT 
  A.Name AS ARTISTA
, B.Title AS ALBUM
FROM artist A 
INNER JOIN album B 
ON A.ArtistId=B.ArtistId
ORDER BY A.Name;