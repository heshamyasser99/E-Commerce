
CREATE TABLE Users(
	username VARCHAR(20),
	password VARCHAR(20),
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	email VARCHAR(50),
	CONSTRAINT users_pk PRIMARY KEY(username)
);

CREATE TABLE User_mobile_numbers(
	mobile_number VARCHAR(20),
	username VARCHAR(20),
	CONSTRAINT fk FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT pk PRIMARY KEY(mobile_number,username) 

);

CREATE TABLE User_Addresses(
	address VARCHAR(100),
	username VARCHAR(20),
	CONSTRAINT address_fk FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT address_pk PRIMARY KEY(address,username) 

);

CREATE TABLE Customer(
	username VARCHAR(20),
	points INT DEFAULT 0,
	CONSTRAINT cust_fk FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cust_pk PRIMARY KEY(username)
);



CREATE TABLE Admins(
	username VARCHAR(20) ,
	CONSTRAINT admin_fk FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT admin_pk PRIMARY KEY(username)
);

CREATE TABLE Vendor(
	username VARCHAR(20),
	activated BIT DEFAULT 0,
	company_name VARCHAR(20),
	bank_acc_no VARCHAR(20),
	admin_username VARCHAR(20),
	CONSTRAINT adm_fk FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT user_fk FOREIGN KEY(username) REFERENCES Users ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT ven_pk PRIMARY KEY(username)
);







CREATE TABLE Delivery_Person(
	username VARCHAR(20),
	is_activated BIT DEFAULT 0,
	CONSTRAINT del_fk FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT del_pk PRIMARY KEY(username)
);

CREATE TABLE Credit_Card(
	number VARCHAR(20),
	expiry_date date,
	cvv_code VARCHAR(4),
	CONSTRAINT cc_pk PRIMARY KEY(number)
);

CREATE TABLE Delivery(
	id int IDENTITY,
	type VARCHAR(20),
	time_duration int,
	fees DECIMAL(5,3),
	username VARCHAR(20),
	CONSTRAINT deli_fk FOREIGN KEY(username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT deli_pk PRIMARY KEY(id)
);

CREATE TABLE Todays_Deals(
	deal_id INT IDENTITY,
	deal_amount INT,
	expiry_date DATETIME,
	admin_username VARCHAR(20),
	CONSTRAINT deal_fk FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT deal_pk PRIMARY KEY(deal_id)
);


CREATE TABLE offer(
	offer_id INT IDENTITY,
	offer_amount INT,
	expiry_date DATETIME,
	CONSTRAINT off_pk PRIMARY KEY(offer_id)
);

CREATE TABLE Wishlist(
	username VARCHAR(20),
	name VARCHAR(20),
	CONSTRAINT wish_fk FOREIGN KEY(username) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT wish_pk PRIMARY KEY(username,name)
);

CREATE TABLE Giftcard(
	code VARCHAR(10),
	expiry_date DATETIME,
	amount INT,
	username VARCHAR(20),
	CONSTRAINT gift_fk FOREIGN KEY(username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT gift_pk PRIMARY KEY(code)
);

CREATE TABLE Customer_CreditCard(
	customer_name VARCHAR(20),
	cc_number VARCHAR(20),
	CONSTRAINT ccc_fk FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CCC_num_fk FOREIGN KEY(cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ccc_pk PRIMARY KEY(customer_name,cc_number)
);


CREATE TABLE Orders(
	order_no INT IDENTITY,
	order_date DATETIME,
	total_amount DECIMAL(10,2) DEFAULT 0,
	cash_amount DECIMAL(10,2) DEFAULT 0,
	credit_amount DECIMAL(10,2) DEFAULT 0,
	payment_type VARCHAR(100),
	order_status VARCHAR(20) DEFAULT 'Not Processed',
	remaining_days INT,
	time_limit DATETIME,
	Gift_Card_code_used VARCHAR(10),
	customer_name VARCHAR(20),
	delivery_id INT,
	creditCard_number VARCHAR(20),

	CONSTRAINT ord_cust_fk FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE ,
	CONSTRAINT ord_gift_fk FOREIGN KEY(Gift_Card_code_used) REFERENCES Giftcard ON DELETE NO ACTION ON UPDATE NO ACTION ,
	CONSTRAINT ord_del_fk FOREIGN KEY(delivery_id) REFERENCES Delivery ON DELETE NO ACTION ON UPDATE NO ACTION ,
	CONSTRAINT ord_cred_fk FOREIGN KEY(creditCard_number) REFERENCES Credit_Card ON DELETE SET NULL ON UPDATE CASCADE ,

	CONSTRAINT ord_pk PRIMARY KEY(order_no)
);


CREATE TABLE Product(
	serial_no INT IDENTITY,
	product_name VARCHAR(20),
	category VARCHAR(20),
	product_description TEXT,
	final_price DECIMAL(10,2),
	price DECIMAL(10,2),
	color VARCHAR(20),
	available BIT DEFAULT 1,
	rate INT,
	vendor_username VARCHAR(20),
	customer_username VARCHAR(20),
	customer_order_id INT,

	CONSTRAINT ven_prod_fk FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cust_prod_fk FOREIGN KEY(customer_username) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT ord_prod_fk FOREIGN KEY(customer_order_id) REFERENCES Orders ON DELETE NO ACTION ON UPDATE NO ACTION,

	CONSTRAINT prod_pk PRIMARY KEY(serial_no)
);

CREATE TABLE CustomerAddstoCartProduct(
	serial_no INT,
	customer_name VARCHAR(20),

	CONSTRAINT cus_p_fk FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ser_p_fk FOREIGN KEY(serial_no) REFERENCES Product ON DELETE NO ACTION ON UPDATE NO ACTION,
	
	CONSTRAINT cus_p_pk PRIMARY KEY(serial_no,customer_name)
);

CREATE TABLE Todays_Deals_Product(
	deal_id INT,
	serial_no INT,

	CONSTRAINT deal_prod_fk FOREIGN KEY(deal_id) REFERENCES Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ser_prod_fk FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE NO ACTION,

	CONSTRAINT deal_ser_pk PRIMARY KEY(deal_id,serial_no)
);

CREATE TABLE offersOnProduct(
	offer_id INT,
	serial_no INT,
	
	CONSTRAINT off_prod_fk FOREIGN KEY(offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ser_off_fk FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT off_ser_pk PRIMARY KEY(offer_id,serial_no)
);


CREATE TABLE Customer_Question_Product(
	serial_no INT,
	customer_name VARCHAR(20),
	question VARCHAR(50),
	answer TEXT,

	CONSTRAINT ser_q_fk FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cus_q_fk FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,

	CONSTRAINT ser_cus_pk PRIMARY KEY(serial_no,customer_name)
);

CREATE TABLE Wishlist_Product(
	username VARCHAR(20),
	Wish_name VARCHAR(20),
	serial_no INT,

	CONSTRAINT wish_p_fk FOREIGN KEY(username,Wish_name) REFERENCES Wishlist ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ser_pr_fk FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON  UPDATE NO ACTION,

	CONSTRAINT wish_p_pk PRIMARY KEY(username,Wish_name,serial_no)
);

CREATE TABLE Admin_Customer_Giftcard(
	code VARCHAR(10),
	customer_name VARCHAR(20),
	admin_username VARCHAR(20),
	remaining_points INT,

	CONSTRAINT cust_gift_fk FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT code_fk FOREIGN KEY (code) REFERENCES Giftcard ON DELETE NO ACTION ON  UPDATE NO ACTION,
	CONSTRAINT adm_gift_fk FOREIGN KEY (admin_username) REFERENCES Admins ON DELETE NO ACTION ON UPDATE NO ACTION,

	CONSTRAINT adm_cust_gift_pk PRIMARY KEY(code,customer_name,admin_username)

);

CREATE TABLE Admin_Delivery_Order(
	delivery_username VARCHAR(20),
	order_no INT,
	admin_username VARCHAR(20),
	delivery_window  VARCHAR(50),


	
	CONSTRAINT adm_ord_fk FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE SET NULL ON UPDATE NO ACTION,
	

	CONSTRAINT ord_ord_fk FOREIGN KEY(order_no) REFERENCES Orders ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT del_ord_fk FOREIGN KEY(delivery_username) REFERENCES Delivery_Person ON DELETE NO ACTION ON UPDATE NO ACTION,
	
	CONSTRAINT adm_del_ord_pk PRIMARY KEY(delivery_username,order_no)
);


--
GO 

CREATE PROC customerRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
INSERT INTO Users(username,first_name,last_name,password,email) VALUES
(@username,@first_name,@last_name,@password,@email)
INSERT INTO Customer(username) VALUES(@username)

GO

CREATE PROC vendorRegister 
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),
@company_name VARCHAR(20),
@bank_acc_no VARCHAR(20)
AS
INSERT INTO Users(username,first_name,last_name,password,email) VALUES
(@username,@first_name,@last_name,@password,@email)
INSERT INTO Vendor(username,company_name,bank_acc_no) VALUES
(@username,@company_name,@bank_acc_no)

GO

CREATE PROC userLogin
@username VARCHAR(20),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS 

IF @username IN (SELECT username FROM Users)
	BEGIN
		DECLARE @pass VARCHAR(20)
		SELECT TOP 1 @pass=password FROM Users WHERE username =@username
		print ' ' +@username + ' ' +@pass
		IF @password=@pass
		BEGIN
			SET @success=1
			IF @username IN (SELECT username FROM Customer)
			BEGIN 
			SET @type=0
			END
			IF @username IN (SELECT username FROM Vendor)
			BEGIN 
			SET @type=1
			END
			IF @username IN (SELECT username FROM Admins)
			BEGIN 
			SET @type=2
			END
			IF @username IN (SELECT username FROM Delivery_Person)
			BEGIN 
			SET @type=3
			END
		END
		ELSE
		BEGIN
		SET @success=0
		SET @type=-1
		END
		


	END 
ELSE
	BEGIN 
		SET @success=0
		SET @type=-1
	END

GO


CREATE PROC addMobile
@username VARCHAR(20),
@mobile_number VARCHAR(20)
AS
INSERT INTO User_mobile_numbers(username,mobile_number)
VALUES(@username,@mobile_number)


GO

CREATE PROC addAddress
@username VARCHAR(20),
@address VARCHAR(100)
AS
INSERT INTO User_Addresses(username,address) VALUES
(@username,@address)

GO





--ADMIN


GO 

CREATE PROC activateVendors
@admin_username VARCHAR(20),
@vendor_username VARCHAR(20)
AS
DECLARE @is_act BIT
SELECT @is_act=activated FROM Vendor WHERE username=@vendor_username
print @is_act
IF @is_act=0 
BEGIN
UPDATE Vendor
SET activated=1,admin_username=@admin_username 
WHERE username=@vendor_username
END

GO



CREATE PROC inviteDeliveryPerson
@delivery_username VARCHAR(20),
@delivery_email VARCHAR(50)
AS
INSERT INTO Users(username,email) VALUES(@delivery_username,@delivery_email)
INSERT INTO Delivery(username) VALUES(@delivery_username)

GO

CREATE PROC reviewOrders 
AS 
SELECT * FROM Orders

GO

CREATE PROC updateOrderStatusInProcess
@order_no INT
AS
UPDATE Orders SET order_status='In Process' WHERE order_no=@order_no

GO

CREATE PROC addDelivery
@delivery_type VARCHAR(20),
@time_duration INT,
@fees DECIMAL(5,3),
@admin_username VARCHAR(20)
AS
INSERT INTO Delivery(type,time_duration,fees,username) 
VALUES(@delivery_type,@time_duration,@fees,@admin_username)

GO


CREATE PROC assignOrdertoDelivery
@delivery_username VARCHAR(20),
@order_no INT,
@admin_username VARCHAR(20)
AS 
INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username) VALUES
(@delivery_username,@order_no,@admin_username)


GO

CREATE PROC createTodaysDeal
@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME
AS
INSERT INTO Todays_Deals(deal_amount,admin_username,expiry_date) VALUES
(@deal_amount,@admin_username,@expiry_date)

GO

CREATE PROC checkTodaysDealOnProduct 
@serial_no INT,
@activeDeal INT OUTPUT
AS
IF @serial_no IN (SELECT serial_no FROM Todays_Deals_Product)
BEGIN 
SET @activeDeal=1
END
ELSE
BEGIN
SET @activeDeal=0
END

GO


CREATE PROC removeExpiredDeal
@deal_id INT
AS
DECLARE @time DATETIME 
SELECT TOP 1 @time =expiry_date FROM Todays_Deals WHERE deal_id=@deal_id
IF @time IS NOT NULL
BEGIN
	IF GETDATE()>@time
		BEGIN 
		DECLARE @prod INT
		SELECT TOP 1 @prod=serial_no FROM Todays_Deals_Product WHERE deal_id=@deal_id
		IF @prod IS NOT NULL
		BEGIN
		UPDATE Product SET final_price=price WHERE serial_no=@prod
		END
		DELETE FROM Todays_Deals_Product WHERE deal_id=@deal_id
	END
END

GO

CREATE PROC addTodaysDealOnProduct
@deal_id INT,
@serial_no INT
AS
DECLARE @activeDeal BIT
DECLARE @discount INT 
DECLARE @date DATETIME
DECLARE @price INT
EXEC checkTodaysDealOnProduct @serial_no,@activeDeal OUTPUT
IF @activeDeal=1
BEGIN
	DECLARE @deal INT
	SELECT TOP 1 @deal=deal_id FROM Todays_Deals_Product WHERE serial_no=@serial_no
	EXEC removeExpiredDeal @deal
	DECLARE @activeDeal2 BIT
	EXEC checkTodaysDealOnProduct @serial_no,@activeDeal2 OUTPUT
	IF @activeDeal2=0
	BEGIN
		
		SELECT TOP 1 @date=expiry_date FROM Todays_Deals WHERE deal_id=@deal_id	
		IF GETDATE()<@date
		BEGIN
		SELECT TOP 1 @discount=deal_amount FROM Todays_Deals WHERE deal_id=@deal_id
		SELECT TOP 1 @price=price FROM Product WHERE serial_no=@serial_no
		UPDATE Product SET final_price=@price-(@price*@discount/100) WHERE serial_no=@serial_no
		INSERT INTO Todays_Deals_Product(deal_id,serial_no) VALUES(@deal_id,@serial_no)
	END
	END
END
ELSE
BEGIN
		SELECT TOP 1 @date=expiry_date FROM Todays_Deals WHERE deal_id=@deal_id	
		IF GETDATE()<@date
		BEGIN
		SELECT TOP 1 @discount=deal_amount FROM Todays_Deals WHERE deal_id=@deal_id
		SELECT TOP 1 @price=price FROM Product WHERE serial_no=@serial_no
		UPDATE Product SET final_price=@price-(@price*@discount/100) WHERE serial_no=@serial_no
		INSERT INTO Todays_Deals_Product(deal_id,serial_no) VALUES(@deal_id,@serial_no)
	END

END

GO


CREATE PROC createGiftCard
@code VARCHAR(10),
@expiry_date DATETIME,
@amount INT,
@admin_username VARCHAR(20)
AS
INSERT INTO Giftcard(code,expiry_date,amount,username) 
VALUES(@code,@expiry_date,@amount,@admin_username)

GO

CREATE PROC removeExpiredGiftCard
@code VARCHAR(10)
AS
DECLARE @date DATETIME
SELECT TOP 1 @date=expiry_date FROM Giftcard WHERE code=@code
IF GETDATE()>@date
BEGIN
		
		UPDATE C SET C.points =C.points-A.remaining_points 
		FROM Customer C INNER JOIN Admin_Customer_Giftcard A  ON C.username=A.customer_name WHERE A.code=@code


		DELETE FROM Admin_Customer_Giftcard WHERE code=@code

END

GO

CREATE PROC giveGiftCardtoCustomer
@code VARCHAR(10),
@customer_name VARCHAR(20),
@admin_username VARCHAR(20)
AS
DECLARE @amount INT 
SELECT TOP 1 @amount=amount FROM Giftcard WHERE code=@code
DECLARE @cust_pnts INT
SELECT TOP 1 @cust_pnts=points FROM Customer WHERE username=@customer_name
UPDATE Customer SET points=@amount+@cust_pnts WHERE username=@customer_name
INSERT INTO Admin_Customer_Giftcard(code,customer_name,admin_username,remaining_points)
VALUES(@code,@customer_name,@admin_username,@amount)

GO


CREATE PROC checkGiftCardOnCustomer
@code VARCHAR(10),
@activeGiftCard BIT OUTPUT
AS 
IF @code IN ( SELECT code FROM Admin_Customer_Giftcard)
BEGIN
SET @activeGiftCard=1
END
ELSE
BEGIN
SET @activeGiftCard=0
END

--------VENDOR------------------

--

--postProduct Done Tested
go
CREATE PROC  postProduct
@vendorUsername varchar(20),
@product_name varchar(20),
@category varchar(20),
@product_description text,
@price decimal(10,2),
@color varchar(20)
AS
INSERT INTO Product (vendor_username, product_name , category , product_description , price,final_price , color,available ) 
values(@vendorUsername,	@product_name , @category , @product_description , @price,@price, @color,1)

--viewOffers
go
CREATE PROC viewOffers
AS 
SELECT * FROM offer
EXEC viewOffers
--vendorviewProducts Done Tested
go
CREATE PROC vendorviewProducts
@vendorname varchar(20)
AS
SELECT *
FROM Product
WHERE vendor_username = @vendorname

--EditProduct Done Tested
go
CREATE PROC EditProduct
@vendorname varchar(20), 
@serialnumber int, 
@product_name varchar(20), 
@category varchar(20),
@product_description text,
@price decimal(10,2),
@color varchar(20)
AS
Update Product
set 
product_name = @product_name,
category = @category,
product_description = @product_description,
price = @price,
final_price=@price,
color = @color
where serial_no = @serialnumber and vendor_username = @vendorname

--deleteProduct Done Tested
go
CREATE PROC deleteProduct
@vendorname varchar(20),
@serialnumber int
AS
if @serialnumber in (SELECT serial_no from product)
BEGIN
delete from Product
where vendor_username=@vendorname and serial_no= @serialnumber 
END
ELSE
BEGIN
Print 'There is no item with that serial or it is not your product'
END

--viewQuestions Done Tested?(add question for TEST)
go
CREATE PROC viewQuestions
@vendorname varchar(20)
AS
SELECT P.serial_no, CQP.customer_name, CQP.question, CQP.answer
FROM Product P INNER JOIN Customer_Question_Product CQP on P.serial_no=CQP.serial_no
WHERE vendor_username=@vendorname
--answerQuestions Done (add question for TEST)
go
CREATE PROC answerQuestions
@vendorname varchar(20),
@serialno int,
@customername varchar(20),
@answer text
AS
Update Customer_Question_Product 
Set
answer= @answer
where serial_no=@serialno and customer_name=@customername
and @vendorname in (select vendor_username from Product where serial_no=@serialno)

--addOffer Done Tested
go
CREATE PROC addOffer
@offeramount int,
@expiry_date datetime
AS
INSERT INTO offer (offer_amount , expiry_date)
values(@offeramount,@expiry_date)

--checkOfferonProduct Done Tested
go
CREATE PROC checkOfferonProduct
@serial int,
@activeoffer bit OUTPUT
AS
set @activeoffer = 0
 if  @serial IN (SELECT serial_no 
 FROM offersOnProduct)
 BEGIN 
 set @activeoffer = 1
 END
 
--checkandremoveExpiredoffer Done Tested
go
CREATE PROC checkandremoveExpiredoffer
@offerid int
AS
DECLARE @prod INT
 Set @prod = -1
 Select @prod = serial_no from offersOnProduct 
 where offer_id=@offerid and @offerid not in(SELECT O.offer_id FROM offer O
							WHERE O.expiry_date>current_timestamp)
IF @prod <> -1
BEGIN
UPDATE Product SET final_price=price
WHERE serial_no=@prod
END
IF @offerid not in(SELECT O.offer_id FROM offer O WHERE O.expiry_date>current_timestamp)
BEGIN
DELETE FROM offersOnProduct
WHERE offer_id= @offerid 
DELETE FROM offer
WHERE offer_id=@offerid 
END
--applyOffer Done Tested
go
CREATE PROC applyOffer
@vendorname varchar(20),
@offerid int,
@serial int
AS
--remove the pre-existing offer if it is expired
DECLARE @offalreadyon int
select @offalreadyon = offer_id from offersOnProduct where serial_no=@serial
print @offalreadyon
EXEC checkandremoveExpiredoffer @offalreadyon
--check if there is an offer on this product
DECLARE @thereisoffer BIT
EXEC checkOfferonProduct @serial, @thereisoffer OUTPUT
--application
IF @thereisoffer = 0
BEGIN
DECLARE @offeramount int
SELECT @offeramount= O1.offer_amount
FROM Offer O1 WHERE O1.offer_id=@offerid
INSERT INTO offersOnProduct values(@offerid,@serial)
SET @offeramount= 100-@offeramount
UPDATE Product
SET final_price= price*@offeramount/100 
WHERE vendor_username=@vendorname and serial_no=@serial
END
ELSE
BEGIN
print 'The product has an active offer'
END









--------------------DELIVERY--------------------
--acceptAdminInvitation DONE TESTED
go
CREATE PROC acceptAdminInvitation
@delivery_username varchar(20)
AS
update Delivery_Person
set is_activated = 1 where username=@delivery_username

--deliveryPersonUpdateInfo Done Tested
go
CREATE PROC deliveryPersonUpdateInfo
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
update Users
set first_name=@first_name,
last_name=@last_name,
password=@password,
email=@email
where username=@username

--viewmyorders Done Tested?
go
CREATE PROC viewmyorders
@deliveryperson varchar(20)
AS
SELECT * FROM Orders Ord 
WHERE Ord.order_no in 
(SELECT order_no from Admin_Delivery_Order ADO where ADO.delivery_username = @deliveryperson)
--specifyDeliveryWindow Done
go
CREATE PROC specifyDeliveryWindow
@delivery_username varchar(20),
@order_no int,
@delivery_window varchar(50)
AS
update Admin_Delivery_Order
set delivery_window=@delivery_window
where delivery_username=@delivery_username and order_no=@order_no

--updateOrderStatusOutForDelivery Done Tested?
go
CREATE PROC updateOrderStatusOutForDelivery
@order_no int
AS
update Orders
set order_status='Out for delivery'
where order_no= @order_no
--updateOrderStatusDelivered Done Tested?
go
CREATE PROC updateOrderStatusDelivered
@order_no int
AS
update Orders
set order_status='Delivered'
where order_no= @order_no


----------------------------------------------------------------

go 
create proc showProducts
As
select * 
From Product
Where available=1;

go
create proc ShowProductsbyPrice
As 
Select *
From Product
WHERE available=1
Order By Price

go
create proc searchbyname @text varchar(20)
As
Select *
From Product p
Where p.product_name like '%'+@text+'%'

go
create proc AddQuestion @serial int, @customer varchar(20), @Question varchar(50)
As
Insert into Customer_Question_Product (serial_no,customer_name,question) values (@serial,@customer,@Question);


go
create proc addToCart @customername varchar(20),@serial int
As 
Insert into CustomerAddstoCartProduct(customer_name,serial_no) values (@customername,@serial)

go
create proc removefromCart @customername varchar(20),@serial int
As
Delete from CustomerAddstoCartProduct
Where customer_name=@customername AND serial_no=@serial


go
create proc createWishlist @customername varchar(20),@name varchar(20)
As
Insert into Wishlist (username,name) values (@customername,@name)

go
create proc AddtoWishlist @customername varchar(20), @wishlistname varchar(20), @serial int
As 
Insert into Wishlist_Product(username,wish_name,serial_no) values (@customername,@wishlistname,@serial)

go
create proc removefromWishlist @customername varchar(20),@wishlistname varchar(20), @serial int
As 
delete from wishlist_product where username=@customername AND Wish_name=@wishlistname AND serial_no=@serial

go
create proc showWishlistProduct @customername varchar(20), @name varchar(20)
As 
Select P.* 
From Wishlist_Product W INNER JOIN Product P ON P.serial_no=W.serial_no
Where username=@customername AND Wish_name=@name

go
create proc viewMyCart @customer varchar(20)
As 
Select P.* 
From CustomerAddstoCartProduct C INNER JOIN Product P ON P.serial_no=C.serial_no
Where customer_name=@customer

go
create proc calculatepriceOrder @customername varchar(20), @sum decimal(10,2) output
As 
Select @sum=sum(p.final_price)
From CustomerAddstoCartProduct c inner join Product P on c.serial_no=p.serial_no


--J PRODUCTSINORDER, NEEDS REVIEW
go
create proc productsinorder @customername varchar(20), @orderID int
As 
Select *
into Temp
From Orders O inner join Product P on O.order_no = P.customer_order_id
where customer_name=@customername AND order_no=@orderID

UPDATE Product 
SET available = 0, customer_username=@customername,customer_order_id=@orderID
WHERE serial_no IN (SELECT serial_no FROM TEMP)

Delete from CustomerAddstoCartProduct 
where serial_no IN (SELECT serial_no FROM Temp)

drop table Temp

go
create proc emptyCart @customername varchar(20)
As 
delete from CustomerAddstoCartProduct where customer_name=@customername

--J MAKEORDER, NEEDS REVIEW
go
create proc makeOrder @customername varchar(20)
As
Declare @sum int
Exec calculatepriceOrder @customername, @sum OUTPUT
Insert into Orders (total_amount,customer_name,order_date) values (@sum,@customername,GETDATE())

Declare @orderno int
SELECT @orderno = max(order_no) From Orders 
SELECT serial_no INTO TE FROM CustomerAddstoCartProduct WHERE customer_name=@customername
UPDATE Product SET customer_username=@customername,available=0,customer_order_id=@orderno WHERE serial_no IN (select serial_no FROM TE)
Exec productsinorder @customername, @orderno
Exec emptyCart @customername

DROP TABLE TE
--J CANCELORDR NEED IMPLEMENTATION

go
create proc cancelOrder @orderid int
As 
If(Select order_status from Orders where order_no=@orderid)='not processed' OR (Select order_status from Orders where order_no=@orderid)='in process'
BEGIN

Select product_name
Into Temporary
From Product P inner join Orders O on P.customer_order_id=O.order_no
Where P.customer_order_id=@orderid

Update Product
Set available=1,rate=NULL,customer_username=NULL,customer_order_id=NULL
Where product_name in (select product_name from Temporary)

Declare @difference int
Select @difference=total_amount-(cash_amount+credit_amount)
From Orders
Where order_no=@orderid

Declare @GiftCode varchar(10)
Select @GiftCode=Gift_Card_code_used
From Orders
Where order_no=@orderid


Declare @GifExp datetime
Select @GifExp = expiry_date 
From Giftcard 
Where code=@GiftCode

Declare @name varchar(20)
Select @name=customer_name
From Orders
Where order_no=@orderid


Delete from Orders where order_no=@orderid

If @GifExp>GETDATE()
BEGIN

Update Customer 
Set points = points+@difference
where username=@name 
Update Admin_Customer_Giftcard
Set remaining_points=remaining_points+@difference
END
END

Drop table Temporary

--l ReturnProduct NEED IMPLEMENTATION
go
create proc returnProduct @serialno int, @orderid int
As 
Declare @Price int
Select @Price=final_price
From Product
Where serial_no=@serialno

Declare @Points int
Select @Points = total_amount-(cash_amount+credit_amount)
From Orders
Where order_no=@orderid

Declare @code varchar(10) 
Select @code = Gift_Card_code_used
From Orders
Where order_no=@orderid

Declare @ExpiryDate datetime
Select @ExpiryDate = expiry_date
From Giftcard
Where code=@code

Update Orders
Set total_amount=total_amount-@Price
Where order_no=@orderid

Update Product 
Set available=1,rate=NULL,customer_username=NULL,customer_order_id=NULL
Where serial_no=@serialno

If(@ExpiryDate>getdate())
BEGIN
if (@Points<@Price)
BEGIN
Update Admin_Customer_Giftcard
Set remaining_points=remaining_points+@Points

Update Customer
Set points = points + @Points
END

if (@Points>@Price)
BEGIN 
Update Admin_Customer_Giftcard
Set remaining_points=remaining_points+@Price

Update Customer
Set points = points + @Price
END
END
--M, NEEDS REVIEW 
go
create proc ShowproductsIBought @customername varchar(20)
As
Select * 
From Product
Where customer_username=@customername

go
create proc rate @serialno int,@rate int, @customername varchar(20)
As
Update Product
Set rate = @rate
Where serial_no=@serialno AND customer_username=@customername


go
create proc SpecifyAmount @customername varchar(20), @orderID int, @cash decimal(10,2), @credit decimal(10,2)
As

Declare @points int
Select @points=O.total_amount-(@cash+@credit)
From Orders O
Where O.order_no=@orderid AND O.customer_name=@customername

Update Orders
Set cash_amount=@cash, credit_amount=@credit
where order_no=@orderID AND customer_name=@customername


If (@cash>0)
BEGIN 
Update Orders
Set payment_type='Cash'
END

If(@credit>0)
BEGIN 
Update Orders
Set payment_type='Credit'
END

If (@points>0)
BEGIN
Update Customer
Set points=points-@points
Where username=@customername
END
If (@points>0 AND (Select Gift_Card_code_used from Orders Where order_no=@orderID) is not null)
BEGIN
Update Admin_Customer_Giftcard
Set remaining_points=remaining_points-@points
Where customer_name=@customername
END

go
create proc AddCreditCard @creditcardnumber varchar(20),@expirydate date, @cvv varchar(4),@customername varchar(20)
As
Insert into Credit_Card (number,expiry_date,cvv_code) values (@creditcardnumber,@expirydate,@cvv)
Insert into Customer_CreditCard(customer_name,cc_number) values (@customername,@creditcardnumber)

go
create proc ChooseCreditCard @creditcard varchar(20), @orderid int
As
Update Orders
Set creditCard_number=@creditcard
Where order_no=@orderid

go
create proc viewDeliveryTypes
As
Select *
From Delivery

go
create proc specifydeliverytype @orderid int, @deliveryID int
As
Declare @remaining int
Select @remaining = time_duration
from Delivery
where id=@deliveryID

Update Orders
Set delivery_id=@deliveryID, remaining_days=@remaining
Where order_no=@orderid

go
CREATE proc trackRemainingDays @orderid int, @customername varchar(20), @days int OUTPUT
As 

Select @days =D.time_duration-DATEDIFF(day,GETDATE(),O.order_date)
From Orders O INNER JOIN Delivery D ON O.delivery_id=D.id
Where O.order_no=@orderid AND O.customer_name=@customername

UPDATE Orders SET remaining_days=@days WHERE order_no=@orderid AND customer_name=@customername


GO

CREATE PROC recommend
@customername VARCHAR(20)
AS
SELECT TOP 3 P.serial_no FROM Product P INNER JOIN Wishlist_Product W ON W.serial_no=P.serial_no 
WHERE W.username<>@customername AND P.category IN
		(SELECT TOP 3 P1.category FROM Product P1 INNER JOIN CustomerAddstoCartProduct W1 ON W1.serial_no=P1.serial_no 
				WHERE W1.customer_name=@customername GROUP BY P1.category ORDER BY count(P1.category) DESC) 
		
		GROUP BY P.serial_no ORDER BY COUNT(*) DESC


Go


CREATE PROC showWishlistsForCustomer
@customername VARCHAR(20)
AS 
select name FROM Wishlist WHERE username=@customername

GO

CREATE PROC showCreditcardsForCustomer
@customername VARCHAR(20)
AS 
SELECT C.* FROM Credit_Card C INNER JOIN  Customer_CreditCard CC ON CC.cc_number=C.number WHERE CC.customer_name=@customername

-----------HESHAM EXTRA-----------------

go
CREATE PROC viewOrderCust
@customername varchar(20)
AS
SELECT * FROM Orders
WHERE customer_name=@customername

go
CREATE PROC viewCC
@customername varchar(20)
AS
SELECT * FROM Customer_CreditCard
WHERE @customername=customer_name


GO


GO

create proc LastOrder @customername varchar(20) , @orderid int OUTPUT , @totalamount decimal(10,2) OUTPUT

AS


Select @orderid=order_no, @totalamount=total_amount
From Orders
where customer_name=@customername AND order_no=(select max(order_no) from Orders)

-----------HESHAM EXTRA-----------------