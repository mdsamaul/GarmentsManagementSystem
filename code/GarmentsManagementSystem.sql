-------------
--md. samaul islam
--mdsamaul843@gmail.com
 --------
 --using master
 -----------
 USE MASTER;
 GO

 --------
 --using master
 -----------
 USE MASTER;
 GO
 ----------------
 --create database GarmentsManagementSystem
 ----------------
 CREATE DATABASE GarmentsManagementSystem
 ON PRIMARY (
 NAME='GarmentsManagementSystem_file',
 FILENAME='D:\isdb\SQL\project\documentation\code\file\GarmentsManagementSystem_file.mdf',
 SIZE=10MB,
 MAXSIZE=100MB,
 FILEGROWTH=10%
 )
 LOG ON(
 NAME='GarmentsManagementSystem_log',
 FILENAME='D:\isdb\SQL\project\documentation\code\file\GarmentsManagementSystem_log.mdf',
 SIZE=10MB,
 MAXSIZE=70MB,
 FILEGROWTH=10%
 );
 GO

 -------------
 --useing GarmentsManagementSystem
 ------------
 USE GarmentsManagementSystem;
 GO

 /************************
 Createing roles table
	RoleID
	RoleName
	RoleDescription
	RoleAccessLavel
	RoleCreatedDate
 ************************/

 CREATE TABLE Roles
 (
	RoleID INT NOT NULL PRIMARY KEY IDENTITY(1001,1),
	RoleName VARCHAR(30) NOT NULL,
	Description VARCHAR(50),
	AccessLavel VARCHAR(30),
	CreatedDate DATETIME DEFAULT GETDATE(),
	CHECK(RoleName='Admin' OR RoleName='Manager' OR RoleName='Staff' OR RoleName = 'Customer Service' OR RoleName='Auditor')
 );
 GO

 
 ------------
 /************************
 Createing Departments table
	DepartmentID
	DepartmentName
	DepartmentDescription
	ManagerID
	Location
 ************************/
 CREATE TABLE Departments
 (
	DepartmentID INT NOT NULL PRIMARY KEY IDENTITY(101,1),
	DepartmentName VARCHAR(30) NOT NULL,
	DepartmentDescription VARCHAR(80),
	ManagerID INT,
	Location VARCHAR(50)
 );
 GO


 ------------
 /************************
 Createing Admin table
	AdminID
	UserName
	Password
	FirstName
	LastName
	Email
	Phone
	RoleID
	DepartmentID
 ************************/
 --created admin table

 CREATE TABLE Admin
 (
	AdminID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	UserName VARCHAR(40) NOT NULL UNIQUE,
	Password VARCHAR(255) NOT NULL CHECK(Password LIKE '%[A-Z]%' AND Password LIKE('%[0-9]%') AND Password LIKE('%[!@#$%^&*()_+-=.,<>/?;:"{}\|`~]%') AND LEN(Password)>=6),
	FirstName VARCHAR(40) NOT NULL,
	LastName VARCHAR(40) NOT NULL,
	Email VARCHAR(100) NOT NULL CHECK(RIGHT(Email,10)='@gmail.com'),
	Phone VARCHAR(40) NOT NULL CHECK(Phone NOT LIKE('[^0-9]')),
	RoleID INT NOT NULL REFERENCES Roles(RoleID),
	DepartmentID INT NOT NULL REFERENCES Departments(DepartmentID)
 );
 GO

 
 ------------
 /************************
 Createing Staff table
	StaffID
	UserName
	Password
	FirstName
	LastName
	Email
	Phone
	RoleID
	DepartmentID
 ************************/

CREATE TABLE Staff(
	StaffID INT NOT NULL IDENTITY(101,1) PRIMARY KEY,
	UserName VARCHAR(80) NOT NULL UNIQUE,
	Password VARCHAR(255) NOT NULL CHECK(Password LIKE ('%[A-Z]%') AND Password LIKE('%[0-9]%') AND Password LIKE('%[`~!@#$%^&*()_+=-{}|\":;/.,<>? ]%') AND LEN(Password) >5),
	FirstName VARCHAR(80) NOT NULL,
	LastName VARCHAR(80) ,
	Email VARCHAR(80) NOT NULL UNIQUE CHECK(RIGHT(Email,10)='@gmail.com'),
	Phone VARCHAR(16) NOT NULL UNIQUE CHECK(Phone NOT LIKE ('%[^0-9]%')),
	RoleID INT NOT NULL REFERENCES Roles(RoleID),
	DepartmentID INT NOT NULL REFERENCES Departments(DepartmentID)
);
GO




 ------------
 /************************
 Createing CustomerService table
	CustomerServiceID
	UserName
	Password
	FirstName
	LastName
	Email
	Phone
	RoleID
	DepartmentID
 ************************/
 ------------


CREATE TABLE CustomerService(
	CustomerServiceID INT NOT NULL PRIMARY KEY IDENTITY(1001,1),
	UserName VARCHAR(80) NOT NULL UNIQUE,
	Password VARCHAR(255) NOT NULL CHECK(Password LIKE('%[A-Z]%') AND Password LIKE ('%[0-9]%') AND Password LIKE('%[!`~@#$%^&*()_+=-?><,./";:\|{}]%')),
	FirstName VARCHAR(80) NOT NULL,
	LastName VARCHAR(80),
	Email VARCHAR(80) UNIQUE CHECK(RIGHT(Email,10) = '@gmail.com'),
	Phone VARCHAR(16) UNIQUE CHECK(Phone NOT LIKE('%[^0-9]%')),
	RoleID INT NOT NULL REFERENCES Roles(RoleID),
	DepartmentID INT NOT NULL REFERENCES Departments(DepartmentID)
);
GO

 ------------
 /************************
 Createing  Auditor table
	AuditorID
	UserName
	Password
	FirstName
	LastName
	Email
	Phone
	RoleID
	DepartmentID
 ************************/
 ------------
 CREATE TABLE Auditor(
	AuditorID INT NOT NULL PRIMARY KEY IDENTITY(1001,1),
	UserName VARCHAR(80) NOT NULL UNIQUE,
	Password VARCHAR(255) NOT NULL CHECK(Password LIKE('%[A-Z]%') AND Password LIKE ('%[0-9]%') AND Password LIKE('%[!`~@#$%^&*()_+=-?><,./";:\|{}]%')),
	FirstName VARCHAR(80) NOT NULL,
	LastName VARCHAR(80),
	Email VARCHAR(80) UNIQUE CHECK(RIGHT(Email,10) = '@gmail.com'),
	Phone VARCHAR(16) UNIQUE CHECK(Phone NOT LIKE('%[^0-9]%')),
	RoleID INT NOT NULL REFERENCES Roles(RoleID),
	DepartmentID INT NOT NULL REFERENCES Departments(DepartmentID)
 );
 GO


 ------------
 /************************
 Createing Managers table
	ManagerID
	UserName
	Password
	FirstName
	LastName
	DepartmentID
	RoleID
	Phone
	Email
	HireDate
	Salary
 ************************/

 CREATE TABLE Managers
 (
	ManagerID INT NOT NULL PRIMARY KEY IDENTITY(10001,1),
	UserName VARCHAR(80) NOT NULL UNIQUE,
	Password VARCHAR(255) NOT NULL CHECK(Password LIKE('%[A-Z]%') AND Password LIKE ('%[0-9]%') AND Password LIKE('%[!`~@#$%^&*()_+=-?><,./";:\|{}]%')),
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30),
	DepartmentID INT NOT NULL REFERENCES Departments(DepartmentID),
	Phone VARCHAR(16) UNIQUE CHECK(Phone NOT LIKE'%[^0-9]%'),
	Email VARCHAR(30) NOT NULL UNIQUE CHECK(RIGHT(Email,10)='@gmail.com'),
	HireDate DATETIME NOT NULL,
	Salary MONEY NOT NULL CHECK(Salary >0),
	RoleID INT NOT NULL REFERENCES Roles(RoleID)
);
GO



 --============= Alter Departments table foregin key	ManagerID INT NOT NULL REFERENCES Managers(ManagerID),

 ALTER TABLE Departments
	ADD CONSTRAINT FK_Constraint_Dep
	FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID);
GO
 ------------
 /************************
 Createing customer table
	CustomerId
	FirstName
	LastName
	Email
	Phone
	Address
	City
	State
	PostalCode
	Country
	RegistrationDate
	DateOfBirth
	Gender
 ************************/
 --------------------------
 CREATE TABLE Customers(
	CustomerId INT NOT NULL PRIMARY KEY IDENTITY(101,1),
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL UNIQUE,
	Phone VARCHAR(16) NOT NULL,
	Address VARCHAR(100),
	City VARCHAR(30),
	State VARCHAR(30),
	PostalCode VARCHAR(30),
	Country VARCHAR(30),
	RegistrationDate DATETIME NOT NULL,
	DateOfBirth DATETIME NOT NULL,
	Gender VARCHAR(20) NOT NULL,
	CHECK (Phone NOT LIKE '%[^0-9]%'),
	CHECK(RIGHT(Email,10)='@gmail.com')
 );
 GO


 ------------
 /************************
 Createing Employees table
	EmployeeId
	FirstName
	LastName
	RollID
	Phone
	Email	
	Address
	City
	State
	PostalCode
	Country
	HireDate
	DateOfBirth
	Gender
	Salary
	EmergencyContact
	DepartmentID
	Status
	
 ************************/

 -----------------
 --create employees table
 -----------------

 CREATE TABLE Employees
 (
	EmployeeId INT NOT NULL PRIMARY KEY IDENTITY(101,1),
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	RoleID INT REFERENCES Roles(RoleID),
	Phone VARCHAR(16) NOT NULL UNIQUE CHECK (Phone NOT LIKE '%[^0-9]%'),
	Email VARCHAR(30) NOT NULL UNIQUE CHECK(RIGHT(Email,10)='@gmail.com'),
	Address VARCHAR(100),
	City VARCHAR(30),
	State VARCHAR(30),
	PostalCode VARCHAR(30),
	Country VARCHAR(30),
	HireDate DATETIME NOT NULL,	
	DateOfBirth DATETIME NOT NULL,
	Gender VARCHAR(20) NOT NULL,
	Salary MONEY NOT NULL CHECK(Salary >0),
	EmergencyContact VARCHAR(16) UNIQUE NOT NULL CHECK (EmergencyContact NOT LIKE '%[^0-9]%'),
	DepartmentID INT REFERENCES Departments(DepartmentID),
	Status VARCHAR(30) NOT NULL CHECK(Status = 'Active' OR Status = 'Inactive' OR Status = 'On Leave')
 );
 GO

 
 ------------
 /************************
 Createing ParentCategorys table
	ParentCategoryID
	ParentCategoryName
	ParentCategoryDescription

	
 ************************/

 CREATE TABLE ParentCategorys
 (
	ParentCategoryID INT NOT NULL PRIMARY KEY IDENTITY(101,1),
	ParentCategoryName VARCHAR(100) NOT NULL,
	ParentCategoryDescription VARCHAR(100)
 );
 GO
 
 ------------
 /************************
 Createing Categorys table
	CategoryID
	CategoryName
	CategoryDescription
	ParentCategoryID foreign key
	
 ************************/
 CREATE TABLE Categorys
 (
	CategoryID INT NOT NULL IDENTITY(101,1) PRIMARY KEY,
	CategoryName VARCHAR(100),
	CategoryDescription VARCHAR(255),
	ParentCategoryID INT REFERENCES ParentCategorys(ParentCategoryID)
 );
 GO

 

  ------------
 /************************
 Createing Suppliers table
	SupplierID PRIMARY KEY
	SupplierName
	ContactName
	Phone
	Email
	Address
	City
	State
	PostalCode
	Country
	CompanyWebsite
	SupplyCategory
	RegistrationDate
	
 ************************/
 CREATE TABLE Suppliers
 (
	SupplierID INT NOT NULL IDENTITY(1001,1) PRIMARY KEY,
	SupplierName VARCHAR(100) NOT NULL,
	ContactName VARCHAR(100) NOT NULL,
	Phone VARCHAR(15) NOT NULL CHECK(Phone NOT LIKE '%[^0-9]%'),
	Email VARCHAR(100) CHECK(RIGHT(Email,10)='@gmail.com'),
	Address VARCHAR(255),
	City VARCHAR(80),
	State VARCHAR(80),
	PostalCode VARCHAR(20),
	Country VARCHAR(80),
	CompanyWebsite VARCHAR(80),
	SupplyCategory VARCHAR(80),
	RegistrationDate DATETIME
 );
 GO


 ------------
 /************************
 Createing Products table
	ProductId PRIMARY KEY
	ProductName
	CategoryID FOREIGN KEY
	Description
	Price
	Stock
	SupplierID foreign key
	Size
	Color
	Material
	Season
	ReleseDate
	Discount
	
 ************************/

 CREATE TABLE Products
 (
	ProductID INT NOT NULL IDENTITY(101,1) PRIMARY KEY,
	ProductName VARCHAR(100) NOT NULL,
	CategoryID INT NOT NULL REFERENCES Categorys(CategoryID),
	Description VARCHAR(300),
	Price MONEY NOT NULL CHECK(Price>0),
	Stock INT CHECK(Stock>0),
	SupplierID INT NOT NULL  REFERENCES Suppliers(SupplierID),
	Size VARCHAR(10) CHECK(Size = 'S' OR Size='M'OR Size='L' OR Size= 'XL' OR Size='XXL'),
	Color VARCHAR(50),
	Material VARCHAR(50),
	Season VARCHAR(50),
	ReleseDate DATETIME DEFAULT GETDATE(),
	Discount FLOAT DEFAULT(0.00) CHECK(Discount>0)
 )
 GO

 ------------
 /************************
 Createing Orders table
	OrderID
	CustomerId FOREIGN KEY
	OrderDate
	RequiredDate
	ShipperdDate
	ShippingAddress
	ShippingCity
	ShippingState
	ShippingPostalCode
	ShippingCountry
	TotalAmount
	PaymentStatus
	OrderStatus
	PaymentMethod
	
	
 ************************/

 CREATE TABLE Orders
 (
	OrderID INT NOT NULL IDENTITY(101,1) PRIMARY KEY,
	CustomerID INT NOT NULL REFERENCES Customers(CustomerId),
	OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
	RequiredDate DATETIME NOT NULL DEFAULT GETDATE(),
	ShipperdDate DATETIME NOT NULL DEFAULT GETDATE(),
	ShippingAddress VARCHAR(255),
	ShippingCity VARCHAR(55),
	ShippingState VARCHAR(55),
	ShippingPostalCode VARCHAR(25),
	ShippingCountry VARCHAR(55),
	TotalAmount MONEY CHECK(TotalAmount>0),
	PaymentStatus VARCHAR(55) CHECK(PaymentStatus='Paid' OR PaymentStatus='Pending' OR PaymentStatus='Cancelled'),
	OrderStatus VARCHAR(55) CHECK(OrderStatus='Processing'OR OrderStatus='Shipped' OR OrderStatus='Delivered' OR OrderStatus ='Returned'),
	PaymentMethod VARCHAR(50) 
 );
 GO


 ------------
 /************************
 Createing OrderDetails table
	OrderDetailID PRIMARY KEY
	OrderID Foreign key
	ProductID
	Quantity
	UnitPrice
	Discount
	TotalPrice
	
	
 ************************/
 CREATE TABLE OrderDetails
 (
	OrderDetailID INT NOT NULL PRIMARY KEY IDENTITY(101,1),
	OrderID INT NOT NULL REFERENCES Orders(OrderID),
	ProductID INT NOT NULL REFERENCES Products(ProductID),
	Quantity INT NOT NULL CHECK(Quantity>0),
	UnitPrice MONEY NOT NULL CHECK(UnitPrice >0),
	Discount FLOAT DEFAULT(0.00),
	TotalPrice MONEY CHECK(TotalPrice>0)
 );
 GO


 
 ------------
 /************************
 Createing Warehouse table
	WarehouseID PRIMARY KEY
	WarehouseName
	Location
	Capacity
	ManagerID
	Phone
	Email
	
 ************************/
 CREATE TABLE Warehouse
 (
	WarehouseID INT NOT NULL IDENTITY(101,1) PRIMARY KEY,
	WarehouseName VARCHAR(90) NOT NULL,
	Location VARCHAR(255),
	Capacity INT NOT NULL,
	ManagerID INT NOT NULL REFERENCES ManagerS(ManagerID),
	Phone VARCHAR(16) NOT NULL CHECK(Phone NOT LIKE '%[^0-9]%'),
	Email VARCHAR(55) CHECK(RIGHT(Email, 10)='@gmail.com')
 );
 GO

 ------------
 /************************
 Createing Inventory table
	InventoryID PRIMARY KEY
	ProductID
	WarehouseID
	QuantityOnHand
	ReorderLevel
	LastRestockDate
	UnitPrice
	TotalValue
	
	
 ************************/
 CREATE TABLE Inventory
 (
	InventoryID INT NOT NULL IDENTITY(1001,1) PRIMARY KEY,
	ProductID INT NOT NULL REFERENCES Products(ProductID),
	WarehouseID INT NOT NULL REFERENCES Warehouse(WarehouseID),
	QuantityOnHand INT NOT NULL,
	ReorderLevel INT,
	LastRestockDate DATETIME DEFAULT GETDATE(),
	UnitPrice MONEY CHECK(UnitPrice > 0),
	TotalValue MONEY CHECK(TotalValue>0)
 );
 GO


 ------------
 /************************
 Createing Shift table
	ShiftID PRIMARY KEY
	ShiftName (Morning, Evening, Night)
	StartTime
	EndTime
	ManagerID
	DepartmentID

	
	
 ************************/
 CREATE TABLE Shift
 (
	ShiftID INT NOT NULL IDENTITY(101,1) PRIMARY KEY,
	ShiftName VARCHAR(20) NOT NULL CHECK(ShiftName='Morning' OR ShiftName='Evening' OR ShiftName='Night'),
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	ManagerID INT REFERENCES Managers(ManagerID),
	DepartmentID INT REFERENCES Departments(DepartmentID)
 );
 GO
 ------------
 /************************
 Createing Attendance table
	AttendanceID PRIMARY KEY
	EmployeeID Foreing key
	AttendanceDate
	ClockInTime
	ClockOutTime
	Status
	Reason Absent, Leave
	WorkHours (ClockInTime - ClockOutTime)
	ShiftId Foreign key	
	
 ************************/

 CREATE TABLE Attendance
 (
	AttendanceID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	EmployeeID INT NOT NULL REFERENCES Employees(EmployeeID),
	AttendanceDate DATETIME NOT NULL DEFAULT GETDATE(),
	ClockInTime TIME NOT NULL,
	ClockOutTime TIME NOT NULL,
	Status VARCHAR(50) NOT NULL CHECK(Status='Present' OR  Status='Absent' OR Status='Leave' OR Status='Late' OR Status='Half-Day'),
	Reason VARCHAR(50) NOT NULL CHECK(Reason='Absent'OR Reason='Leave'),
	WorkHours INT NOT NULL ,
	ShiftId INT NOT NULL REFERENCES Shift(ShiftID)
 );
 GO
