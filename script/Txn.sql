SELECT * FROM test.user_roles;

use test;

truncate table TRANSACTION;
truncate table LineItem;

drop table TRANSACTION;
drop table LineItem;

CREATE TABLE TRANSACTION
(
id int(6) unsigned zerofill not null auto_increment primary key,
discountPercentage varchar(255),
discountedAmount varchar(255),
subTotal varchar(255),
mobileNumber varchar(255),
FinalAmount varchar(255),
creation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
modification_time DATETIME ON UPDATE CURRENT_TIMESTAMP
); 


SELECT discountedAmount,subTotal,FinalAmount FROM TRANSACTION WHERE creation_time BETWEEN CURDATE()
 AND DATE_ADD(CURDATE(), INTERVAL 1 day);


select * from users

select * from user_roles


update users set pass



CREATE TABLE LINEITEM
(
ID INT(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT PRIMARY KEY,
TRANSACTIONNUMBER INT(6),
ITEMNUMBER VARCHAR(255),
ITEMDESC VARCHAR(255),
PRICE VARCHAR(255),
QUANTITY VARCHAR(255),
LINETOTAL VARCHAR(255),
creation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
modification_time DATETIME ON UPDATE CURRENT_TIMESTAMP
); 


select * from TRANSACTION;

select * from LINEITEM;

