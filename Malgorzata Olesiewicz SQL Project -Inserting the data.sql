---Malgorzata Paulina Olesiewicz, ID: 1975361

USE malgooPROJECT


------------------------------ PRODUCT TYPE TABLE 
EXECUTE addproducttype
@PTName = 'Soup',
@PDescr = 'Keeps you warm in winter'
GO

EXECUTE addproducttype
@PTName = 'Warm dish',
@PDescr = 'Something more substantial'
GO

EXECUTE addproducttype
@PTName = 'Sandwich',
@PDescr = 'Boring but does the tick'
GO

EXECUTE addproducttype
@PTName = 'Coffee',
@PDescr = 'Never enough of it'
GO

EXECUTE addproducttype
@PTName = 'Salad',
@PDescr = 'Always a great choice'
GO

------------------------------ PRODUCT TABLE 
SELECT* FROM tblPRODUCT

EXECUTE addproduct
@PName = 'BLT',
@PTName = 'Sandwich'
GO

EXECUTE addproduct
@PName = 'Tomato Soup',
@PTName = 'Soup'
GO

EXECUTE addproduct
@PName = 'Curry with Rice',
@PTName = 'Warm Dish'
GO

EXECUTE addproduct
@PName = 'Spaghetti Bolognese',
@PTName = 'Warm Dish'
GO

EXECUTE addproduct
@PName = 'Cesar Salad',
@PTName = 'Salad'
GO


------------------------------ INGREDIENT TYPE TABLE 
INSERT INTO tblIngredient_Type (IngredientTypeName,IngredientTypeDesc)
VALUES ('Dairy', 'Not so good for your stomach')

INSERT INTO tblIngredient_Type (IngredientTypeName,IngredientTypeDesc)
VALUES ('Meat', 'Protein')


INSERT INTO tblIngredient_Type (IngredientTypeName,IngredientTypeDesc)
VALUES ('Vegetable', 'So deliciouse')

INSERT INTO tblIngredient_Type (IngredientTypeName,IngredientTypeDesc)
VALUES ('Fuit', 'So deliciouse')

INSERT INTO tblIngredient_Type (IngredientTypeName,IngredientTypeDesc)
VALUES ('Wholegrain', 'Nutritious')

------------------------------ INGREDIENT TABLE 

EXECUTE addingredient
@IName = 'Beef',
@ITName = 'Meat'
GO

EXECUTE addingredient
@IName = 'Chicken',
@ITName = 'Meat'
GO

EXECUTE addingredient
@IName = 'Milk',
@ITName = 'Dairy'
GO

EXECUTE addingredient
@IName = 'Salad',
@ITName = 'Vegetable'

GO

EXECUTE addingredient
@IName = 'Corn',
@ITName = 'Vegetable'
GO

EXECUTE addingredient
@IName = 'Tomato',
@ITName = 'Vegetable' 
GO

EXECUTE addingredient
@IName = 'Potato',
@ITName = 'Vegetable'
GO

EXECUTE addingredient
@IName = 'Rice',
@ITName = 'Wholegrain'
GO
------------------------------ DELIVERY TYPE TABLE 

INSERT INTO tblDelivery_type (DeliveryTypeName, DeliveryTypeDesc)
VALUES('Weekly', 'Takes place every Monday'), 
('Daily', 'For products which need to be fresh'), 
('Ocassional', 'Does not fit into other categories')

------------------------------ DELIVERY TABLE 

INSERT INTO tblDelivery(OrderDate, DeliveryDate , DeliveryTypeID, RestaurantID)
VALUES ('20191127 11:00:00 am','20191129 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type  WHERE DeliveryTypeName = 'Daily'), (SELECT RestaurantID FROM tblRestaurant Where RestaurantName = 'ROMA')), 
('20191120 11:00:00 am','20191126 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type WHERE DeliveryTypeName = 'Weekly'), (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'ROMA' )), 
('20191120 11:00:00 am','20191127 11:00:00 am', 
(Select DeliveryTypeID FROM tblDelivery_Type WHERE DeliveryTypeName = 'Ocassional'), (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'ROMA' )), 
('20191127 11:00:00 am','20191129 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type  WHERE DeliveryTypeName = 'Daily'), (SELECT RestaurantID FROM tblRestaurant Where RestaurantName = 'Thai Tom')), 
('20191120 11:00:00 am','20191126 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type WHERE DeliveryTypeName = 'Weekly'), (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Burger Magic' )), 
('20191120 11:00:00 am','20191127 11:00:00 am', 
(Select DeliveryTypeID FROM tblDelivery_Type WHERE DeliveryTypeName = 'Ocassional'), (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Xiangs' )) 
INSERT INTO tblDelivery(OrderDate, DeliveryDate , DeliveryTypeID, RestaurantID)
VALUES ('20191120 11:00:00 am','20191121 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type  WHERE DeliveryTypeName = 'Daily'), (SELECT RestaurantID FROM tblRestaurant Where RestaurantName = 'ROMA')), 
('20191110 11:00:00 am','20191111 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type WHERE DeliveryTypeName = 'Weekly'), (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'ROMA' )), 
('20190720 11:00:00 am','20190727 11:00:00 am', 
(Select DeliveryTypeID FROM tblDelivery_Type WHERE DeliveryTypeName = 'Ocassional'), (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'ROMA' )),
('20190713 11:00:00 am','20190715 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type  WHERE DeliveryTypeName = 'Daily'), (SELECT RestaurantID FROM tblRestaurant Where RestaurantName = 'ROMA')), 
('20190712 11:00:00 am','20190716 11:00:00 am',
(Select DeliveryTypeID FROM tblDelivery_Type  WHERE DeliveryTypeName = 'Daily'), (SELECT RestaurantID FROM tblRestaurant Where RestaurantName = 'ROMA')) 

------------------------------ STATE TABLE 

INSERT INTO tblState (StateAbr, StateName)
VALUES ('WA', 'Washington'), ('CA', 'California'), 
('AL','ALASKA')

------------------------------ ZIP TABLE 
INSERT INTO tblZIP (ZIPNumber, StateID)
VALUES (984111, (SELECT StateID FROM tblState WHERE Stateabr = 'WA')), 
(984100, (SELECT StateID FROM tblState WHERE Stateabr = 'WA')),
(987600, (SELECT StateID FROM tblState WHERE Stateabr = 'WA')),
(988800, (SELECT StateID FROM tblState WHERE Stateabr = 'CA')),
(900000, (SELECT StateID FROM tblState WHERE Stateabr = 'AL'))

------------------------------ SUPPLIER TYPE TABLE 

INSERT INTO tblSupplier(SupplierName, SupplierStreet, ZIPID, SupplierCity)
VALUES('Wholefood', 'NE 51St Street',(SELECT ZIPID FROM tblZIP WHERE ZIPNumber = 984111),'Portland')
GO 

INSERT INTO tblSupplier(SupplierName, SupplierStreet, ZIPID, SupplierCity)
VALUES('Calfood', 'NE 51St Street',(SELECT ZIPID FROM tblZIP WHERE ZIPNumber = 988800),'San Francisco')

GO 

EXECUTE addnewsupplierWithNewZIP
@SupName = 'Food', 
@SupStreet = '51st Street',
@SupCity = 'Washington',
@ZIPNumber = 910000, 
@StateAbr = 'WA'

------------------------------ LOCATION TYPE TABLE 

USE malgooPROJECT

INSERT INTO tblLocation_Type(LocactionTypeName, LocationTypeDesc)
VALUES('Small complex', 'medium size area for serving food')

INSERT INTO tblLocation_Type(LocactionTypeName, LocationTypeDesc)
VALUES('Little corner', 'small area devoted puerly for serving coffee')

INSERT INTO tblLocation_Type(LocactionTypeName, LocationTypeDesc)
VALUES('individual Restaurant', 'Entire location dedicated for the restaurant')

------------------------------ LOCATION TABLE 

INSERT INTO tblLocation( LocationStreet, LocationNumber, LocationTypeID, ZIPID)
VALUES( 'University Ave', 45, (SELECT LocationTypeID FROM tblLOCATION_TYPE 
					WHERE LocationTypeName = 'individual Restaurant'),
							(SELECT ZIPID FROM tblZIP WHERE ZIPNumber =984111 ))

INSERT INTO tblLocation( LocationStreet, LocationNumber, LocationTypeID, ZIPID)
VALUES( 'University Ave', 51, (SELECT LocationTypeID FROM tblLOCATION_TYPE 
					WHERE LocationTypeName LIKE '%little%'),
							(SELECT ZIPID FROM tblZIP WHERE ZIPNumber =984111 ))
							
INSERT INTO tblLocation( LocationStreet, LocationNumber, LocationTypeID, ZIPID)
VALUES( 'University Ave', 99, (SELECT LocationTypeID FROM tblLOCATION_TYPE 
					WHERE LocationTypeName LIKE '%little%'),
							(SELECT ZIPID FROM tblZIP WHERE ZIPNumber =984111 ))

INSERT INTO tblLocation( LocationStreet, LocationNumber, LocationTypeID, ZIPID)
VALUES( '45th Street', 51, (SELECT LocationTypeID FROM tblLOCATION_TYPE 
					WHERE LocationTypeName LIKE '%small%'),
							(SELECT ZIPID FROM tblZIP WHERE ZIPNumber =984111 ))

INSERT INTO tblLocation( LocationStreet, LocationNumber, LocationTypeID, ZIPID)
VALUES( 'University Ave', 95, (SELECT LocationTypeID FROM tblLOCATION_TYPE 
					WHERE LocationTypeName = 'individual Restaurant'),
							(SELECT ZIPID FROM tblZIP WHERE ZIPNumber =984111 ))

INSERT INTO tblLocation( LocationStreet, LocationNumber, LocationTypeID, ZIPID)
VALUES( '45th Street', 99, (SELECT LocationTypeID FROM tblLOCATION_TYPE 
					WHERE LocationTypeName LIKE 'individual Restaurant'),
							(SELECT ZIPID FROM tblZIP WHERE ZIPNumber =984111 ))

------------------------------ RESTAURANT TYPE TABLE 

INSERT INTO tblRESTAURANT_TYPE(RestaurantTypeName, RestaurantTypeDesc)
VALUES ('Italian', 'Traditional Italian Food'), 
('Asian Fussion', 'Chinese, Vietnamise and Thai cuisine combined'), 
('American', 'Traditional American Food')

GO
------------------------------ RESTAURANT TABLE 

INSERT INTO tblRESTAURANT (RestaurantName, RestaurantCapacity, LocationID, RestaurantTypeID) 
VALUES('Thai Tom',25, (SELECT LocationID FROM tblLOCATION WHERE LocationStreet ='University Ave' AND
LocationNumber = 51),(SELECT RestaurantTypeID FROM tblRESTAURANT_TYPE WHERE RestaurantTypeName = 'Asian Fussion' ))

INSERT INTO tblRESTAURANT (RestaurantName, RestaurantCapacity, LocationID, RestaurantTypeID) 
VALUES('Burger Magic',45, (SELECT LocationID FROM tblLOCATION WHERE LocationStreet ='University Ave' AND
LocationNumber = 45),(SELECT RestaurantTypeID FROM tblRESTAURANT_TYPE WHERE RestaurantTypeName LIKE '%American%'))


INSERT INTO tblRESTAURANT (RestaurantName, RestaurantCapacity, LocationID, RestaurantTypeID) 
VALUES('Roma',35, (SELECT LocationID FROM tblLOCATION WHERE LocationStreet ='University Ave' AND
LocationNumber = 95),(SELECT RestaurantTypeID FROM tblRESTAURANT_TYPE WHERE RestaurantTypeName = 'Italian' ))



INSERT INTO tblRESTAURANT (RestaurantName, RestaurantCapacity, LocationID, RestaurantTypeID) 
VALUES('Xiangs',55, (SELECT LocationID FROM tblLOCATION WHERE LocationStreet ='45th Street' AND
LocationNumber = 99),(SELECT RestaurantTypeID FROM tblRESTAURANT_TYPE WHERE RestaurantTypeName = 'Asian Fussion' ))


------------------------------ INGREDIENT DELIVERY LIST TABLE 
EXECUTE newIngredientDelivery
@Quan = 30 ,
@InName = 'Tomato', 
@SupName = 'CalFood' , 
@ResName = 'ROMA',
@DelOrderDate = '20191127 11:00:00 am',
@DeDeDate = '20191129 11:00:00 am', 
@DeType = 'Daily',
@CO2PerPound = 28.00

GO 

EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Milk', 
@SupName = 'Food' ,  
@ResName = 'ROMA',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191126 11:00:00 am', 
@DeType = 'Weekly',
@CO2PerPound = 9.05

GO

EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Beef', 
@SupName = 'Food' ,  
@ResName = 'ROMA',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191126 11:00:00 am', 
@DeType = 'Weekly', 
@CO2PerPound = 60.05
GO


EXECUTE newIngredientDelivery
@Quan = 25 ,
@InName = 'Chicken', 
@SupName = 'Good Food' ,  
@ResName = 'ROMA',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191126 11:00:00 am', 
@DeType = 'Weekly' , 
@CO2PerPound = 40.05

GO 

EXECUTE newIngredientDelivery
@Quan = 9 ,
@InName = 'Rice', 
@SupName = 'Calfood' , 
@ResName = 'ROMA',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191127 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 25.05

GO 

EXECUTE newIngredientDelivery
@Quan = 30 ,
@InName = 'Tomato', 
@SupName = 'Good Food' , 
@ResName = 'Thai Tom',
@DelOrderDate = '20191127 11:00:00 am',
@DeDeDate = '20191129 11:00:00 am', 
@DeType = 'Daily', 
@CO2PerPound = 15.05

GO

EXECUTE newIngredientDelivery
@Quan = 15 ,
@InName = 'Milk', 
@SupName = 'Food' ,  
@ResName = 'Burger Magic',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191126 11:00:00 am', 
@DeType = 'Weekly', 
@CO2PerPound = 7.05
GO 

EXECUTE newIngredientDelivery
@Quan = 30 ,
@InName = 'Rice', 
@SupName = 'Good Food' , 
@ResName = 'Xiangs',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191127 11:00:00 am', 
@DeType = 'Ocassional',
@CO2PerPound = 22.05
GO 


EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Milk', 
@SupName = 'calfood' , 
@ResName = 'Xiangs',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191127 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 8.05

GO 



EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Beef', 
@SupName = 'Good Food' , 
@ResName = 'ROMA',
@DelOrderDate = '20190720 11:00:00 am',
@DeDeDate = '20190727 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 48.05

GO 


EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Beef', 
@SupName = 'Good Food' , 
@ResName = 'ROMA',
@DelOrderDate = '20190713 11:00:00 am',
@DeDeDate = '20190715 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 48.05

GO 


EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Tomato', 
@SupName = 'Good Food' , 
@ResName = 'ROMA',
@DelOrderDate = '20190713 11:00:00 am',
@DeDeDate = '20190715 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 8.05

GO 

EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Milk', 
@SupName = 'Good Food' , 
@ResName = 'ROMA',
@DelOrderDate = '20190713 11:00:00 am',
@DeDeDate = '20190715 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 8.05

GO 


EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Milk', 
@SupName = 'Good Food' , 
@ResName = 'ROMA',
@DelOrderDate = '20191110 11:00:00 am',
@DeDeDate = '20191111 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 8.05

GO 

EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Milk', 
@SupName = 'Good Food' , 
@ResName = 'ROMA',
@DelOrderDate = '20191110 11:00:00 am',
@DeDeDate = '20191111 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 8.05

GO 

EXECUTE newIngredientDelivery
@Quan = 10 ,
@InName = 'Milk', 
@SupName = 'calfood' , 
@ResName = 'ROMA',
@DelOrderDate = '20191120 11:00:00 am',
@DeDeDate = '20191127 11:00:00 am', 
@DeType = 'Ocassional', 
@CO2PerPound = 28.05

GO 

------------------------------ PRODUCT INGREDIENT TABLE 
INSERT INTO tblPRODUCT_INGREDIENT (Quantity, IngredientId, ProductID)
VALUES (0.25, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Milk'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Curry with Rice')),
(0.20, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Rice'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Curry with Rice')),
(0.25, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Milk'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Spaghetti Bolognese')),
(0.5, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Tomato'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Spaghetti Bolognese')),
(0.5, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Beef'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Spaghetti Bolognese'))


INSERT INTO tblPRODUCT_INGREDIENT (Quantity, IngredientId, ProductID)
VALUES (0.25, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Salad'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Cesar Salad')),
(0.20, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Tomato'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Cesar Salad')),
(0.25, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Corn'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Cesar Salad')),
(0.75, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Tomato'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Tomato Soup')),
(0.25, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Rice'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'Tomato Soup')),
(0.3, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Salad'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'BLT')),
(0.3, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Tomato'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'BLT')),
(0.3, (SELECT IngredientID FROM tblIngredient WHERE IngredientName = 'Beef'), (SELECT ProductID FROM tblPRODUCT WHERE ProductName = 'BLT'))

------------------------------ WASTE  TYPE TABLE 

INSERT INTO tblWASTE_TYPE (WasteTypeName, WasteTypeDescr)
VALUES ('Recyclable', 'Waste can be reused'), 
('Non-recyclable','Goes strait to the landfield')

------------------------------ WASTE TABLE 

INSERT INTO tblWASTE(WasteName, WasteRecycleCategory, WasteTypeID)
VALUES ('Paper', 1,(SELECT WasteTypeID FROM tblWaste_Type WHERE WasteTypeName = 'Recyclable')),
('Compost', 2,(SELECT WasteTypeID FROM tblWaste_Type WHERE WasteTypeName = 'Recyclable')), 
('Plastic', 3,(SELECT WasteTypeID FROM tblWaste_Type WHERE WasteTypeName = 'Recyclable')), 
('Other', NULL,(SELECT WasteTypeID FROM tblWaste_Type WHERE WasteTypeName = 'Recyclable'))


------------------------------ WASTE LIST TABLE  

INSERT INTO tblWASTE_LIST(DisposalDate, CollectionDate, TotalWeight, WasteID, RestaurantID)
VALUES('20191120 08:00:00 pm', '20191121 06:00:00 am', 333.2, (SELECT WasteID FROM tblWaste WHERE WasteName='Other'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Roma')), 
('20191121 08:00:00 pm', '20191122 06:00:00 am', 3.2, (SELECT WasteID FROM tblWaste  WHERE WasteName='Paper'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Roma')),
('20191120 08:00:00 pm', '20191121 06:00:00 am', 20, (SELECT WasteID FROM tblWaste  WHERE WasteName='Compost'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Roma')),
('20191120 08:00:00 pm', '20191121 06:00:00 am', 80, (SELECT WasteID FROM tblWaste  WHERE WasteName='Other'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Burger Magic')), 
('20191121 08:00:00 pm', '20191122 06:00:00 am', 6.4, (SELECT WasteID FROM tblWaste  WHERE WasteName='Paper'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Burger Magic')),
('20191120 08:00:00 pm', '20191121 06:00:00 am', 10, (SELECT WasteID FROM tblWaste WHERE WasteName='Compost'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Burger Magic')),
('20191120 08:00:00 pm', '20191121 06:00:00 am', 33, (SELECT WasteID FROM tblWaste  WHERE WasteName='Other'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Thai Tom')), 
('20191121 08:00:00 pm', '20191122 06:00:00 am', 0.5, (SELECT WasteID FROM tblWaste  WHERE WasteName='Paper'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Thai Tom')),
('20191120 08:00:00 pm', '20191121 06:00:00 am', 10, (SELECT WasteID FROM tblWaste  WHERE WasteName='Compost'),
		(SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Thai Tom'))

------------------------------ ORDER TABLE 

INSERT INTO tblORDER (OrderDate, RestaurantID)
VALUES ('20191127 11:00:00 am', (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Roma')),
('20190716 11:00:00 am', (SELECT RestaurantID FROM tblRestaurant WHERE RestaurantName = 'Roma'))

------------------------------ PRODUCT ORDER TABLE 
INSERT INTO tblProduct_Order(Quantity, ProductID, OrderID)
VALUES(1,(SELECT ProductID FROM tblProduct P WHERE P.ProductName = 'Spaghetti Bolognese'),
(SELECT OrderID FROM tblOrder O WHERE O.OrderDate = '20191127 11:00:00 am')),
(2,(SELECT ProductID FROM tblProduct P WHERE P.ProductName = 'Spaghetti Bolognese'),
(SELECT OrderID FROM tblOrder O WHERE O.OrderDate = '20190716 11:00:00 am'))
