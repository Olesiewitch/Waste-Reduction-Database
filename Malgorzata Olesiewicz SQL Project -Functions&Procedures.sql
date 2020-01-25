---Malgorzata Paulina Olesiewicz, ID: 1975361

USE malgooPROJECT
GO 
----- PROCEDURES :

-- a) supportting  

----- Insert new product type procedure 
CREATE PROCEDURE addproducttype
@PTName varchar(50), 
@PDescr varchar(500) 
AS 
INSERT INTO tblPRODUCT_TYPE (ProductTypeName, ProductTypeDescr)
VALUES (@PTName, @PDescr)
GO 


----- Insert new product procedure
CREATE PROCEDURE addproduct 
@PName varchar(50), 
@PTName varchar (500)

AS

DECLARE @PTID INT = (SELECT PT.ProductTypeID FROM tblProduct_Type PT
							WHERE PT.ProductTypeName = @PTName)

INSERT INTO tblProduct (ProductName, ProductTypeID)
VALUES (@PName, @PTID)

GO

--- Add ingredient procedure

CREATE PROCEDURE addingredient 
@IName varchar(50), 
@ITName varchar (500)

AS
DECLARE @ITID INT = (SELECT IT.IngredientTypeID FROM tblIngredient_Type IT WHERE IT.IngredientTypeName = @ITName)

INSERT INTO tblIngredient (IngredientName, IngredientTypeID)
VALUES (@IName, @ITID)

GO

--- Adding ingredient procedure

CREATE PROCEDURE addingredientproduct
@IName varchar(50), 
@ITName varchar (500)

AS
DECLARE @ITID INT = (SELECT IT.IngredientTypeID FROM tblIngredient_Type IT 
							WHERE IT.IngredientTypeName = @ITName)

INSERT INTO tblIngredient (IngredientName, IngredientTypeID)
VALUES (@IName, @ITID)

GO

--- b) to be graded 


---- 1. Procedure to add new supplier with new ZIP Code

CREATE PROCEDURE addnewsupplierWithNewZIP
@SupName varchar(50), 
@SupStreet varchar(50),
@SupCity varchar(50),
@ZIPNumber INT, 
@StateAbr varchar(4)

AS 

BEGIN TRANSACTION T1

DECLARE @ZIPID INT

INSERT INTO tblZIP (ZIPNumber, StateID)
VALUES (@ZIPNumber, (SELECT StateID FROM tblState WHERE Stateabr = @StateAbr))

SET @ZIPID = (SELECT SCOPE_IDENTITY())

INSERT INTO tblSupplier (SupplierName,ZIPID, SupplierStreet, SupplierCity )
VALUES (@SupName, @ZIPID, @SupStreet, @SupCity)

COMMIT TRANSACTION T1
GO 

use malgooPROJECT

GO

---- 2.Procedure to enter new Ingredient Delivery List item 

CREATE PROCEDURE newIngredientDelivery
@Quan numeric (6,2),
@InName varchar(50), 
@SupName varchar(50), 
@ResName varchar (50),
@DelOrderDate Date, 
@DeDeDate Date, 
@DeType varchar(50), 
@CO2PerPound numeric(6,2)

AS 

BEGIN TRANSACTION T2
DECLARE @IngID INT
DECLARE @ResID INT
DECLARE @SupID INT
DECLARE @DelID INT
SET @ResID = (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = @ResName) 
SET @DelID = (SELECT DeliveryID FROM tblDelivery WHERE OrderDate = @DelOrderDate AND 
			  DeliveryDate = @DeDeDate AND RestaurantId = @ResID)
SET @IngID = (SELECT IngredientID FROM tblIngredient WHERE IngredientName = @InName)
SET @SupID = (SELECT SupplierID FROM tblSupplier WHERE SupplierName  = @SupName)
INSERT INTO tblINGREDIENT_DELIVERY_LIST (Quantity, IngredientID, SupplierID, DeliveryID, CO2KgPerPound)
VALUES (@Quan, @IngID, @SupID, @DelID, @CO2PerPound)
COMMIT TRANSACTION T2
GO

---- COMPUTED COLUMNS: 

---- 1. a) Create function to calculate the total CO2 footprint of each product for the given order
USE malgooPROJECT

GO

CREATE FUNCTION AverCO2(@PK INT)
RETURNS Numeric (6,2) 
AS
BEGIN 
DECLARE @Ref Numeric = (SELECT AVG(IDL.CO2KgPerPound) 
						FROM tblProduct P 
						JOIN tblProduct_Order OD ON OD.ProductID = P.ProductID
							JOIN tblProduct_Ingredient  PIT ON PIT.ProductID = P. ProductID
								JOIN tblIngredient I ON I.IngredientID = PIT.IngredientID
								JOIN tblIngredient_Delivery_List IDL on IDL.IngredientID = I.IngredientID
								JOIN tblDelivery D ON D.DeliveryID = IDL.DeliveryID
						WHERE IDL.IngredientID  = @PK
						AND YEAR(GetDate())=YEAR(D.DeliveryDate)
						AND MONTH(GetDate())=MONTH(D.DeliveryDate))
						
RETURN @Ref 
END 
GO 

ALTER TABLE tblIngredient 
ADD AverCO2ThisMonth AS (dbo.TotalCO2(IngredientID))

GO

use malgooPROJECT
ALTER TABLE tblINGREDIENT_DELIVERY_LIST
ADD CO2KgPerPound Numeric(6,2)


---- 1. b)  Create function to calculate the totl CO2 footprint of each delivery

use malgooPROJECT
GO

CREATE FUNCTION DeliveryCO2(@PK INT)
RETURNS NUMERIC (6,2)
AS 
BEGIN 
DECLARE @Ref Numeric = (SELECT Sum(IDL.Quantity*IDL.CO2KgPerPound)
					FROM tblDelivery D 
						JOIN tblIngredient_Delivery_List IDL ON IDL.DeliveryID = D.DeliveryID
						JOIN tblIngredient I ON I.IngredientID =IDL.IngredientID
						WHERE D.DeliveryID= @PK)

RETURN @Ref 
END 
GO 


--- Insert new column with claculated CO2 per delivery into delivery table

ALTER TABLE tblDelivery
ADD DeliveryCO2 AS (dbo.DeliveryCO2(DeliveryID))

GO

---- 2.Compute relative amount of waste (total amount of waste per capacity)

CREATE Function wastePerCapacity(@PK INT)
RETURNS Numeric(4,2)
AS 
BEGIN 
DECLARE @REF Numeric = (SELECT WL.TotalWeight/R.RestaurantCapacity
				FROM tblWaste_List WL
				JOIN tblRestaurant R On R.RestaurantID = WL.RestaurantID
				WHERE WL.WasteListID = @PK)

RETURN @REF
END
GO 

ALTER TABLE tblWaste_List
ADD WastePerCapacity AS (dbo.wastePerCapacity(WasteListID))

GO

---- BUISSNESS RULE 

--- 1. Don't allow Restaurant Type 'Italian' order more than 20 pounds of rice per weekly order
GO

CREATE FUNCTION NoRiceForItalians
RETURNS INT
AS
BEGIN

DECLARE @Ret INT = 0
IF EXISTS (SELECT R.RestaurantID
			FROM tblRestaurant_Type RT 
				JOIN tblRestaurant R ON RT.RestaurantTypeID = R.RestaurantTypeID
					JOIN tblDelivery D ON D.ResturantID=R.RestaurantID
						JOIN tblDelivery_Type DT ON DT.DeliveryTypeID = D.DeliveryTypeID
							JOIN tblIngredient_Delivery_List IDL ON IDL.DeliveryID = D.DeliveryID  
			WHERE RT.RestaurantTypeName LIKE '%Italian%'
			AND DT.DeliveryTypeName = 'Weekly'
			AND I.IngredientName = 'Rice'
			AND IDL.Quantity>20)

			BEGIN 
				SET @Ret = 1
			END
RETURN @Ret
END


--- 2.  Don't let Restaurant Roma order products outside of Washington State


CREATE FUNCTION NoProductOusideOfWA
RETURNS INT
AS
BEGIN

DECLARE @Ret INT = 0
IF EXISTS (SELECT R.RestaurantID
			FROM tblRestaurant_Type RT 
			JOIN tblRestaurant R ON RT.RestaurantTypeID = R.RestaurantTypeID
			JOIN tblDelivery D ON D.ResturantID = R.RestaurantID
			JOIN tblLocation L ON L.LocationID  = R.LocationID
			JOIN tblZIP Z ON Z.ZIPID = L.ZIPID
			JOIN tblState S ON S.StateID = Z.StateID
			WHERE RT.RestaurantName = 'Roma'
			AND S.StateAbr != 'WA')

			BEGIN 
				SET @Ret = 1
			END
RETURN @Ret
END


---- VIEWS: 



--- 1. Restaurant having smallest amount of Waste and of Type Asian Fussion with total CO2Delivery < 700kg

SELECT TOP 1 R.RestaurantID, R.RestaurantName, SUM(WL.WastePerCapacity) AS TotalRelativeWaste
FROM tblRestaurant R 
JOIN tblWaste_List WL ON WL.RestaurantID= R.RestaurantID
	JOIN tblRestaurant_Type RT ON RT.RestaurantTypeID = R.RestaurantTypeID
		JOIN (SELECT R2.RestaurantID
			  FROM tblRestaurant R2 
				JOIN tblDelivery D2 ON D2.RestaurantID = R2.RestaurantID
			  GROUP BY R2.RestaurantID
			  HAVING SUM(DeliveryCO2)< 700) AS SQ1 ON SQ1.RestaurantID = R.RestaurantID
WHERE 
RT.RestaurantTypeName ='Asian Fussion'
GROUP BY R.RestaurantID, R.RestaurantName
ORDER BY SUM(WL.WastePerCapacity) ASC

use malgooPROJECT

--- 2. Ingredients and their quantity which are part of Spaghetti Bolognese and which have been delivered to restaurant ROMA from the supplier in 
--- Washington in November 2019
SELECT I.IngredientID, I.IngredientName, IDL.Quantity, D.DeliveryDate 
FROM tblProduct P 
	JOIN tblProduct_Ingredient PIT ON PIT.ProductID = P.ProductID
		JOIN tblIngredient I ON I.IngredientID = PIT.IngredientID
			JOIN tblIngredient_Type IT ON IT.IngredientTypeID = I.IngredientTypeID 
				JOIN tblIngredient_Delivery_List IDL ON IDL.IngredientId = I.IngredientID 
					JOIN tblSupplier S ON S.SupplierID = IDL.SupplierID
						JOIN tblDelivery D ON D.DeliveryID = IDL.DeliveryID	
							JOIN tblRestaurant R ON R.RestaurantID = D.RestaurantID
								JOIN tblZIP Z ON Z.ZIPID = S.ZIPID
									JOIN tblSTATE ST ON ST.StateID = Z.StateID
					
WHERE 
P.ProductName = 'Spaghetti Bolognese'
AND R.RestaurantName = 'ROMA'
AND MONTH(D.DeliveryDate ) = 11 AND YEAR(D.DeliveryDate) = 2019
AND ST.StateAbr = 'WA'

GO

----  For Data Visualisation
SELECT P.ProductName, I.IngredientName, IDL.CO2KgPerPound, D.DeliveryDate, S.SupplierName  
FROM tblProduct_Ingredient PIT 
JOIN tblProduct P On P.ProductID = PIT.ProductID
JOIN tblIngredient I ON I.IngredientID = PIT.IngredientID
JOIN tblIngredient_Delivery_List IDL ON I.IngredientID = IDL.IngredientID
JOIN tblSupplier S ON S.SupplierID = IDL.SupplierID
JOIN tblDelivery D ON D.DeliveryID = IDL.DeliveryID
