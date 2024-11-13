create table EMPLOYEE (
  Id int primary key,
  Ssn int not null,
  Name varchar(50) not null
);

create table STORE_MANAGER (
  Id int primary key,
  foreign key (Id) references EMPLOYEE (Id)
);

create table FLOOR_CLERK (
  Id int primary key,
  foreign key (Id) references EMPLOYEE (Id)
);

create table CUSTOMER (
  Id int primary key,
  Ssn int not null,
  Name varchar(50) not null,
  Phone varchar(50) not null,
  Address varchar(50) not null
);

create table PAYMENT_METHOD (
  Name varchar(100) primary key,
  Description text
);

create table PURCHASE (
  Id int primary key,
  Date date not null,
  Time time not null,
  Name varchar(100) not null,
  foreign key (Name) references PAYMENT_METHOD (Name)
);

create table DISCOUNT_PROGRAM (
  Id int primary key,
  Name varchar(100) not null,
  Description text
);

create table SHELF (
  Id int primary key,
  Location varchar(50),
  Area varchar(50)
);

create table PRODUCT (
  Id int primary key,
  Name varchar(50) not null,
  MDate timestamp not null,
  EDate timestamp not null,
  Quantity int not null,
  SuggestedPrice int not null,
  constraint CheckValidity check (MDate < EDate and Quantity >= 0)
);

create table BRAND(
  Id int primary key,
  Name varchar(50) not null
);

create table TRANSACTION_HISTORY (
  CustomerId int not null,
  ProductId int not null,
  PurchaseId int not null,
  BrandId int not null,
  Date date not null,
  Time time not null,
  Quantity int not null,
  primary key (CustomerId, ProductId, Date, Time),
  foreign key (CustomerId) references CUSTOMER (Id),
  foreign key (ProductId) references PRODUCT (Id),
  foreign key (PurchaseId) references PURCHASE (Id),
  foreign key (BrandId) references BRAND (Id)
);

create table BELONGS_TO (
  ProductId int not null,
  BrandId int not null,
  foreign key (ProductId) references PRODUCT (Id),
  foreign key (BrandId) references BRAND (Id)
);

create table RESTOCKS (
  FloorClerkId int not null,
  ShelfId int not null,
  unique (FloorClerkId, ShelfId),
  foreign key (FloorClerkId) references FLOOR_CLERK (Id),
  foreign key (ShelfId) references SHELF (Id)
);

create table CHECKS (
  StoreManagerId int not null,
  ProductId int not null,
  unique (StoreManagerId, ProductId),
  foreign key (StoreManagerId) references STORE_MANAGER (Id),
  foreign key (ProductId) references PRODUCT (Id)
);

create table IS_ON (
  ProductId int not null,
  ShelfId int not null,
  Quantity int not null,
  foreign key (ProductId) references PRODUCT (Id),
  foreign key (ShelfId) references SHELF (Id)
);

create table HAS (
  DiscountProgramId int not null,
  ProductId int not null,
  BrandId int not null,
  FromDate timestamp not null,
  ToDate timestamp not null,
  Percent int not null,
  foreign key (DiscountProgramId) references DISCOUNT_PROGRAM (Id),
  foreign key (ProductId) references PRODUCT (Id),
  foreign key (BrandId) references BRAND (Id),
  constraint DiscountPercent check (Percent >= 0 and Percent <= 80),
  constraint DateValidity check (FromDate < ToDate)
);

create table STORAGE_CONDITIONS (
  ShelfId int primary key,
  StorageCondition varchar(200),
  foreign key (ShelfId) references SHELF (Id)
);

create table RESTOCKS_SESSION (
  FloorClerkId int not null,
  ShelfId int not null,
  Date date not null,
  Time time not null,
  primary key (FloorClerkId, ShelfId, Date, Time),
  foreign key (FloorClerkId, ShelfId) references RESTOCKS (FloorClerkId, ShelfId)
);

create table CHECKS_SESSION (
  StoreManagerId int not null,
  ProductId int not null,
  Date date not null,
  Time time not null,
  StorewidePrice int not null,
  primary key (StoreManagerId, ProductId, Date, Time, StorewidePrice),
  foreign key (StoreManagerId, ProductId) references CHECKS (StoreManagerId, ProductId)
);