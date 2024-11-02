-- W11D1 - Pratica

-- Interrogare, filtrare e raggruppare
/* 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
     Quali considerazioni/ragionamenti è necessario che tu faccia?
*/



SELECT ProductKey, COUNT(ProductKey)
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(ProductKey) >1;

-- oppure

SHOW KEYS
FROM dimproduct
WHERE Key_name = 'PRIMARY';


-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

SELECT SalesOrderNumber, SalesOrderLineNumber, COUNT(*)
FROM factresellersales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING COUNT(*) > 1;


-- 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.

SELECT OrderDate, COUNT(*) 
FROM factresellersales
WHERE OrderDate >= {D'2020-01-01'}
GROUP BY OrderDate;

/* 4.Calcola il fatturato totale (FactResellerSales.SalesAmount), 
	 la quantità totale venduta (FactResellerSales.OrderQuantity) e 
	 il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) 
     a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, 
     la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!
*/


SELECT 
  A.ProductKey							  AS CODICE
, MAX(B.EnglishProductName)				  AS DESCRIZIONE
, SUM(A.OrderQuantity) 					  AS TOTALE_QUANTITA
, SUM(A.SalesAmount)					  AS TOTALE_VENDITA
, CAST(SUM(A.SalesAmount)/SUM(A.OrderQuantity) AS DECIMAL (10,2)) AS PREZZO_MEDIO
FROM factresellersales A 	
LEFT OUTER JOIN dimproduct B
ON A.ProductKey=B.ProductKey
WHERE A.OrderDate >= {D'2020-01-01'}
GROUP BY A.ProductKey;
     
/* 5.Calcola il fatturato totale (FactResellerSales.SalesAmount) 
	e la quantità totale venduta (FactResellerSales.OrderQuantity) 
	per Categoria prodotto (DimProductCategory). .
	Il result set deve esporre pertanto il nome della categoria prodotto, 
	il fatturato totale e la quantità totale venduta. 
	I campi in output devono essere parlanti!
*/


SELECT 
  D.ProductCategoryKey					AS CODICE_CATEGORIA
, MAX(D.EnglishProductCategoryName)		AS DESCRIZIONE
, SUM(A.SalesAmount)					AS TOTALE_FATTURATO
, SUM(A.OrderQuantity)					AS TOTALE_QUANTITA
FROM factresellersales A 
LEFT OUTER JOIN dimproduct B 
ON A.ProductKey=B.ProductKey
LEFT OUTER JOIN dimproductsubcategory C 
ON B.ProductSubcategoryKey=C.ProductSubcategoryKey
LEFT OUTER JOIN dimproductcategory D 
ON C.ProductCategoryKey=D.ProductCategoryKey
GROUP BY D.ProductCategoryKey;




/* 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
     Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.
*/



SELECT * FROM dimsalesterritory;

-- 12.650.022,79 --
SELECT SUM(SalesAmount)
FROM factresellersales
WHERE OrderDate >={D'2020-01-01'};

SELECT SUM(SalesAmount)
FROM factresellersales
WHERE OrderDate >={D'2020-01-01'};

SELECT 
A.SalesTerritoryKey
, SUM(A.SalesAmount)
FROM factresellersales A 
-- LEFT OUTER JOIN dimgeography B 
-- ON A.SalesTerritoryKey=B.SalesTerritoryKey
WHERE A.OrderDate >={D'2020-01-01'}
GROUP BY A.SalesTerritoryKey
-- HAVING SUM(A.SalesAmount) > 60000
ORDER BY SUM(A.SalesAmount) DESC;


SELECT * FROM dimgeography



TIP
Dove non espressamente indicato è necessario individuare in autonomia le tabelle contenenti i dati utili.
In alcuni casi, per maggior chiarezza è stato indicando il percorso NomeTabella.NomeCampo altrimenti la sola indicazione del campo!


