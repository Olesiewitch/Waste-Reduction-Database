---Malgorzata Paulina Olesiewicz, ID: 1975361



CREATE DATABASE malgooPROJECT
GO

USE malgooPROJECT 
GO


CREATE TABLE tblLOCATION_TYPE 
(LocactionTypeID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
LocactionTypeName varchar (50) NOT NULL, 
LocationTypeDesc varchar (100) NULL)

GO

CREATE TABLE tblLOCATION 
(LocationID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
LocationStreet varchar(50) NOT NULL, 
LocationNumber INT NOT NULL, 
LocationZIP INT, 
LocationState varchar(10), 
LocationTypeID INT FOREIGN KEY REFERENCES tblLOCATION_TYPE (LocactionTypeID) NOT NULL)
GO

CREATE TABLE tblRESTAURANT_TYPE
(RestaurantTypeID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
RestaurantTypeName varchar(100) NOT NULL, 
RestaurantTypeDesc varchar(500) NULL)

GO 


CREATE TABLE tblRESTAURANT 
(RestaurantID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
RestaurantName varchar(50) NOT NULL, 
RestaurantCapacity INT NOT NULL,
LocationID INT FOREIGN KEY REFERENCES tblLOCATION (LocationID) NOT NULL, 
RestaurantTypeID INT FOREIGN KEY REFERENCES tblRESTAURANT_TYPE (RestaurantTypeID) NOT NULL)
GO 

CREATE TABLE tblORDER 
(OrderID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
OrderDate DATE DEFAULT GetDate(), 
RestaurantID INT FOREIGN KEY REFERENCES tblRESTAURANT (RestaurantID) NOT NULL)

GO 


CREATE TABLE tblWASTE_TYPE 
(WasteTypeID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
WatesTypeName varchar(50)NOT NULL, 
WasteTypeDescr varchar(50) NULL)

GO 

CREATE TABLE tblWASTE
(WasteID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
WasteName varchar(50) NOT NULL, 
WasteRecycleCategory INT NULL, 
WasteTypeID INT FOREIGN KEY REFERENCES tblWASTE_TYPE (WasteTypeID) NOT NULL)
GO 

CREATE TABLE tblWASTE_LIST
(WasteListID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
DisposalDate Date DEFAULT GetDate() NOT NULL, 
CollectionDate Date NULL, 
TotalWeight Numeric (4,2) NOT NULL, 
WasteID INT FOREIGN KEY REFERENCES tblWaste (WasteID) NOT NULL, 
RestaurantID INT FOREIGN KEY REFERENCES tblRESTAURANT(RestaurantID) NOT NULL)
GO 


CREATE TABLE tblPRODUCT_TYPE
(ProductTypeID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
ProductTypeName varchar(50), 
ProductTypeDescr varchar(500))
GO

CREATE TABLE tblPRODUCT 
(ProductID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
ProductName varchar(50), 
ProductTypeID INT FOREIGN KEY REFERENCES tblPRODUCT_TYPE (ProductTypeID) NOT NULL)


CREATE TABLE tblPRODUCT_ORDER
(ProductOrderID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
Quantity INT NOT NULL,
ProductID INT FOREIGN KEY REFERENCES tblPRODUCT (ProductID) NOT NULL, 
OrderID INT FOREIGN KEY REFERENCES tblORDER (OrderID) NOT NULL, 
)

GO

CREATE TABLE tblINGREDIENT_TYPE 
(IngredientTypeID INT IDENTITY (1,1) PRIMARY KEY NOt NULL, 
IngredientTypeName varchar(50) NOT NULL,
IngredientTypeDesc varchar(500) NULL)
GO

CREATE TABLE tblINGREDIENT 
(IngredientID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
IngredientName varchar(50), 
IngredientTypeID INT FOREIGN KEY REFERENCES tblINGREDIENT_TYPE (IngredientTypeID) NOT NULL)

CREATE TABLE tblPRODUCT_INGREDIENT 
(ProductIngredientID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
Quantity NUMERIC (6,2) NOT NULL, 
IngredientID INT FOREIGN KEY REFERENCES tblINGREDIENT (IngredientID) NOT NULL, 
ProductID INT FOREIGN KEY REFERENCES tblPRODUCT (ProductID) NOT NULL)
GO 

CREATE TABLE tblSUPPLIER 
(SupplierID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
SupplierName varchar(50) NOT NULL, 
SupplierSteet varchar (50)NOT NULL, 
SupplierZIP INT NOT NULL,
SupplierState varchar(10),
)
GO

CREATE TABLE tblINGREDIENT_DELIVERY_LIST
(IngredientDeliveryListID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
CO2KgPerPound Numeric(6,2) NOT NULL,
Quantity Numeric(6,2) NOT NULL,
IngredientID INT FOREIGN KEY REFERENCES tblINGREDIENT (IngredientID) NOT NULL, 
SupplierID INT FOREIGN KEY REFERENCES tblSUPPLIER (SupplierID) NOT NULL, 
DeliveryID INT  FOREIGN KEY REFERENCES tblDelivery(DeliveryID) NOT NULL)
GO

CREATE TABLE tblDELIVERY_TYPE
(DeliveryTypeID INT IDENTITY (1,1) PRIMARY KEY NOt NULL, 
DeliveryTypeName varchar(50) NOT NULL,
DeliveryTypeDesc varchar(500) NULL)
GO

CREATE TABLE tblDELIVERY
(DeliveryID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
DeliveryName varchar(50), 
OrderDate DATE DEFAULT GETDATE() NOT NULL, 
DeliveryDate DATE DEFAULT GETDATE() NULL,
DeliveryTypeID INT FOREIGN KEY REFERENCES tblDELIVERY_TYPE (DeliveryTypeID) NOT NULL)
GO 

USE malgooPROJECT

ALTER TABLE tblDelivery
ADD RestaurantID INT FOREIGN KEY REFERENCES tblRestaurant (RestaurantID) NOT NULL 
GO 

CREATE TABLE tblZIP 
(ZIPID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
ZIPState varchar(4) Not null,
ZIPNumber INT Not NULL)

ALTER TABLE tblLocation
DROP COLUMN LocationState, 
LocationZIP

ALTER TABLE tblLocation 
ADD ZIPID INT FOREIGN KEY REFERENCES tblZIP (ZIPID) NOT NULL
GO

ALTER TABLE tblSupplier 
DROP COLUMN SupplierState, 
SupplierZIP

ALTER TABLE tblSupplier 
ADD ZIPID INT FOREIGN KEY REFERENCES tblZIP (ZIPID) NOT NULL
GO

ALTER TABLE tblSupplier
DROP COLUMN SupplierSteet
GO

ALTER TABLE tblSupplier
ADD  SupplierStreet varchar(50)
GO

ALTER TABLE tblSupplier
ADD  SupplierCity varchar(50)
GO

CREATE TABLE tblState
(StateID INT IDENTITY (1,1) PRIMARY KEY NOT NULL, 
StateAbr varchar(4)  NOT NULL)

ALTER TABLE tblZIP
ADD StateID INT FOREIGN KEY REFERENCES tblState(StateID) NOT NULL

ALTER TABLE tblState 
ADD StateName varchar(50)

ALTER TABLE tblWaste_Type
ADD WasteTypeName varchar(50)


