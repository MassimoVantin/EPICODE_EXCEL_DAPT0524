-- 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
select  * 
from dimproduct A
left outer join dimproductsubcategory B
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey;


SELECT * 
FROM dimproduct
WHERE ProductSubcategoryKey IN (SELECT ProductSubcategoryKey FROM dimproductsubcategory);

-- 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).
SELECT *
FROM dimproduct A
INNER JOIN dimproductsubcategory B
ON A.ProductSubcategoryKey=B.ProductSubcategoryKey
INNER JOIN 	dimproductcategory C 
ON B.ProductCategoryKey=C.ProductCategoryKey;




-- 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales). 

SELECT DISTINCT 
A.ProductKey,
A.EnglishProductName 
FROM dimproduct A 
INNER JOIN dimfactresellersalses B
ON A.ProductKey=B.ProductKey;



-- 4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).
SELECT 
ProductKey,
EnglishProductName 
FROM dimproduct	 
WHERE ProductKey IN (SELECT ProductKey FROM factresellersales)
AND FinishedGoodsFlag = 1;


-- 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)
SELECT A.* , B.EnglishProductName
FROM factresellersales A
INNER JOIN dimproduct B 
ON A.ProductKey= B.ProductKey;




-- 6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

SELECT A.* , D.EnglishProductCategoryName
FROM factresellersales A
INNER JOIN dimproduct B 
ON A.ProductKey= B.ProductKey
LEFT OUTER JOIN dimproductsubcategory C 
ON B.ProductSubcategoryKey=C.ProductSubcategoryKey
LEFT OUTER JOIN dimproductcategory D
ON C.ProductCategoryKey=D.ProductCategoryKey;


-- 7.Esplora la tabella DimReseller.

SELECT * 
FROM dimreseller;


-- 8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 

SELECT A.*, B.EnglishCountryRegionName
FROM dimreseller A 
LEFT OUTER JOIN dimgeography B
ON A.GeographyKey=B.GeographyKey;


-- 9-Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
-- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica.

SELECT 
  A.SalesOrderNumber
, A.SalesOrderLineNumber
, A.OrderDate
, A.UnitPrice
, A.OrderQuantity
, A.TotalProductCost
, B.EnglishProductName
, C.ResellerName
, E.EnglishProductCategoryName
, F.ResellerName
, G.EnglishCountryRegionName
FROM factresellersales A 
INNER JOIN dimproduct B	
ON A.ProductKey=B.ProductKey
LEFT OUTER JOIN dimreseller C 
ON A.ResellerKey=C.ResellerKey
LEFT OUTER JOIN dimproductsubcategory D 
ON B.ProductSubcategoryKey=D.ProductSubcategoryKey
LEFT OUTER JOIN dimproductcategory E
ON D.ProductCategoryKey=E.ProductCategoryKey
LEFT OUTER JOIN dimreseller F 
ON A.ResellerKey=F.ResellerKey
LEFT OUTER JOIN dimgeography G 
ON F.GeographyKey=G.GeographyKey;


SELECT * FROM factresellersales
TIP

Dove possibile, risolvi la query utilizzando sia le JOIN che le SUBQUERY.

Dove non espressamente indicato (punto 8 per esempio) è necessario individuare in autonomia le tabelle contenenti i dati utili. */