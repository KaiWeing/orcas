create table ORDERS
(
  ORDR_ID number(15) not null,
  VERSION number(15) default "0" not null,
  BPAR_ID number(15) not null,
  ORDERDATE date not null,
  TRACKING_NUMBER varchar2(20) not null,
  STATUS varchar2(10) not null,
  SHIPPING_STREET varchar2(50) not null,
  SHIPPING_CITY varchar2(30) not null,
  SHIPPING_STATE varchar2(2),
  SHIPPING_ZIPCODE varchar2(10) not null,
  SHIPPING_COUNTRY varchar2(2) not null,

  constraint ORDR_PK primary key (ORDR_ID),

  index ORDR_BPAR_FK_GEN_IX (BPAR_ID),
  constraint ORDR_UC unique (TRACKING_NUMBER),

  constraint ORDR_BPAR_FK foreign key (BPAR_ID) references BUSINESS_PARTNERS (BPAR_ID)
);

