SELECT DISTINCT TOP(5) FactInternet.SalesAMount,
CONCAT(Subcategory.EnglishProductSubcategoryName, '/', Subcategory.SpanishProductSubCategoryName, '/', Subcategory.FrenchProductSubcategoryName) AS CategoryNameThreeLanguages
FROM dbo.FactInternetSales as FactInternet

INNER JOIN dbo.DimCurrency AS Currency ON Factinternet.CurrencyKey = Currency.CurrencyKey
INNER JOIN dbo.DimProduct AS Product ON Factinternet.Productkey = Product.ProductKey
INNER JOIN dbo.DimProductsubcategory AS Subcategory ON  Product.ProductSubcategorykey = Subcategory.ProductSubcategorykey
INNER JOIN  dbo.DimProductCategory AS ProductCategory ON Subcategory.ProductcategoryKey = ProductCategory.ProductcategoryKey
---For Product & Category

INNER JOIN DimSalesTerritory ON FactInternet.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
INNER JOIN dbo.DimGeography ON DimSalesTerritory.SalesTerritoryKey = DimGeography.SalesTerritoryKey
--For Territory and Geography

INNER JOIN FactInternetSalesReason as SalesReason
ON FactInternet.SalesOrderNumber = SalesReason.SalesOrderNumber
INNER JOIN DimSalesReason dsr ON SalesReason.SalesReasonKey = dsr.SalesReasonKey
--For Sales & Reason

WHERE EXISTS (SELECT Currency.CurrencyName, dimGeography.CountryRegioncode
FROM FactInternetSales
INNER JOIN DimCurrency AS Currency on FactInternetSales.CurrencyKey = Currency.CurrencyKey
CROSS JOIN DimGeography
WHERE dimGeography.CountryRegionCode = N'US' AND Currency.CurrencyName Like N'US%'
GROUP BY Currency.CurrencyName, dimGeography.CountryRegionCode);

--Write a query that returns the top 5 best-selling subcategories by salesamount
--We're only interested in sales from our website (internet sales)
--Finally the data should only include sales where the country is United States and the currency is US Dollar
