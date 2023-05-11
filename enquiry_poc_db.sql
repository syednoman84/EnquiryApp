DROP SCHEMA IF EXISTS enquiry_poc_db;
CREATE SCHEMA enquiry_poc_db;
USE `enquiry_poc_db`;

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `detail` VARCHAR(200) DEFAULT NULL,
  `city` VARCHAR(100) DEFAULT NULL,
  `country` VARCHAR(100) DEFAULT NULL,
  `zip` INT(11) DEFAULT NULL,
  PRIMARY KEY (`addressId`)
) ENGINE=INNODB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

INSERT INTO `address` VALUES (9,'63, Zone-1',NULL,NULL,NULL),(10,'A-8, Kolar','Mumbai','India',777777),(11,'Addr 1, Zone-1',NULL,NULL,NULL),(12,'Addr 2, Kolar','Mumbai','India',777777),(23,'63, Zone-1, MP Nagar','Pune','India',666666),(24,'63, Zone-1, MP Nagar','Mumbai','India',444444),(25,'63, Zone-1, MP Nagar','Pune','India',555555),(26,'63, Zone 1, MP Nagar','Bhopal','India',462011),(27,'64, Zone 1, MP Nagar','Bhopal','India',462011),(28,'64, Zone 1, MP Nagar','Bhopal','India',462011),(29,'63, Zone-1, MP Nagar','Bhopal','India',462011),(32,'63, Zone-1, MP Nagar',NULL,NULL,NULL),(33,'63, Zone 1, MP Nagar, Bhopal, India',NULL,NULL,NULL),(34,'63, Zone 1, MP Nagar','Bhopal','India',462044),(35,'63, Zone 1, MP Nagar','Bhopal','India',458752),(36,'63, Zone-1, MP Nagar',NULL,NULL,NULL),(37,'Testing address',NULL,NULL,NULL),(38,'Testing Addr 2',NULL,NULL,NULL),(39,'63, Zone 1, MP Nagar, Bhopal',NULL,NULL,NULL);


DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contactId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) DEFAULT NULL,
  `email` VARCHAR(45) DEFAULT NULL,
  `phone` VARCHAR(100) DEFAULT NULL,
  `localAddress` BIGINT(20) DEFAULT NULL,
  `permanentAddress` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (`contactId`),
  KEY `fk1_address_idx` (`localAddress`),
  KEY `fk1_address_idx1` (`permanentAddress`),
  CONSTRAINT `fk1_address` FOREIGN KEY (`localAddress`) REFERENCES `address` (`addressId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk2_address` FOREIGN KEY (`permanentAddress`) REFERENCES `address` (`addressId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

INSERT INTO `contact` VALUES (6,'Official','contact@ezeon.net','9630130106',9,10),(7,'Admin','admin@apt.com','9630130106',11,12),(18,'Virkam Thakur','vikrahakur@gmail.com','9303580884',NULL,23),(19,'Virkam Thakur','vikramn.thakur@gmail.com','9303580884',NULL,24),(20,'Vinay Kumar','vinay@ezeon.net','88888888',NULL,25),(22,'Test Inst 2','test2.inst@ezeon.net','999999',NULL,27),(23,'Test Inst 2','test2.inst@ezeon.net','999999',NULL,28),(24,'EZEE','shusya@ezeon.net','09713912642',NULL,29),(27,'Tapasya Shukla','shukla.ta@ezeon.net','9713912642',NULL,32),(28,'Test Enquiry','test@ezeon.net','9869666666',NULL,33),(29,'Test Inst','test@ezeon.net','99999999',NULL,34),(30,'Surya Academy','surya@gmail.com','9999999',NULL,35),(31,'Virkam Thakur','vikramn.test@gmail.com','9303580884',NULL,36),(32,'Test','test@ezeon.net','9999999',NULL,37),(33,'Test 2','test2@ezeon.net','8888888',NULL,38),(34,'Rohit','rohit@ezeon.net','88888888',NULL,39);


DROP TABLE IF EXISTS `enquirysource`;
CREATE TABLE `enquirysource` (
  `enquirySourceId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`enquirySourceId`)
) ENGINE=INNODB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

INSERT INTO `enquirysource` VALUES (1,'Google Search'),(2,'Website'),(3,'Newspaper'),(10,'Just Dial'),(11,'Website Partner 2');

DROP TABLE IF EXISTS `institute`;
CREATE TABLE `institute` (
  `instituteId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `contactId` BIGINT(20) DEFAULT NULL,
  `name` VARCHAR(200) DEFAULT NULL,
  `doe` DATETIME DEFAULT NULL,
  PRIMARY KEY (`instituteId`),
  KEY `fk_contact_idx` (`contactId`),
  CONSTRAINT `fk_contact` FOREIGN KEY (`contactId`) REFERENCES `contact` (`contactId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
INSERT INTO `institute` VALUES (4,6,'EZEON Tech','2019-08-22 22:53:29'),(5,7,'APT Academy','2019-08-23 13:06:21'),(7,29,'Test Inst','2019-09-03 23:30:03'),(8,30,'Surya Academy','2019-09-04 00:17:20');

DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `courseId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) DEFAULT NULL,
  `fees` DOUBLE(15,3) DEFAULT NULL,
  `instituteId` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (`courseId`),
  KEY `fk_course_1_idx` (`instituteId`),
  CONSTRAINT `fk_course_1` FOREIGN KEY (`instituteId`) REFERENCES `institute` (`instituteId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

INSERT INTO `course` VALUES (1,'Java Core',40000.000,4),(2,'Android',20000.000,4),(3,'CA',50000.000,5),(4,'CS',90000.000,5),(7,'Spring Boot New',60000.000,4);

DROP TABLE IF EXISTS `enquiry`;
CREATE TABLE `enquiry` (
  `enquiryId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `contactId` BIGINT(20) DEFAULT NULL,
  `doe` DATETIME DEFAULT NULL,
  `nextCallDate` DATE DEFAULT NULL,
  `remark` VARCHAR(400) DEFAULT NULL,
  `committedFees` DOUBLE(15,3) DEFAULT NULL,
  `lastUpdate` DATETIME DEFAULT NULL,
  `instituteId` BIGINT(20) DEFAULT NULL,
  `enquirySourceId` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (`enquiryId`),
  KEY `contactId` (`contactId`),
  KEY `fk_enquiry_2_idx` (`instituteId`),
  KEY `fk_enquirysrc_3_idx` (`enquirySourceId`),
  CONSTRAINT `enquiry_fk` FOREIGN KEY (`contactId`) REFERENCES `contact` (`contactId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_enquiry_2` FOREIGN KEY (`instituteId`) REFERENCES `institute` (`instituteId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_enquirysrc_2` FOREIGN KEY (`enquirySourceId`) REFERENCES `enquirysource` (`enquirySourceId`) ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

INSERT INTO `enquiry` VALUES (3,18,'2019-08-23 18:07:15',NULL,'test 6',60000.000,'2019-08-23 18:07:15',4,1),(4,19,'2019-08-23 18:07:57',NULL,'test 6',60000.000,'2019-08-23 18:07:57',4,1),(5,20,'2019-08-24 12:46:33',NULL,'testing apt',140000.000,'2019-08-24 12:46:33',5,2),(9,28,'2019-08-31 19:09:20',NULL,'Testing remark',60000.000,'2019-08-31 19:09:20',4,1),(10,31,NULL,NULL,'Testing enquiry',60000.000,NULL,4,2),(11,32,'2019-09-06 15:01:54',NULL,'Testing 2',50000.000,'2019-09-06 15:01:54',4,1),(12,33,'2019-09-06 17:25:35',NULL,'Testing 2 remark',100000.000,'2019-09-06 17:25:35',4,1),(13,34,'2019-09-07 12:53:28',NULL,'He wants to join in 7 days',100000.000,'2019-09-07 12:53:28',4,3);

DROP TABLE IF EXISTS `enquirycourse`;
CREATE TABLE `enquirycourse` (
  `enquiryCourseId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `courseId` BIGINT(20) DEFAULT NULL,
  `enquiryId` BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (`enquiryCourseId`),
  KEY `fk_course_idx` (`courseId`),
  KEY `fk_enq_id_222_idx` (`enquiryId`),
  CONSTRAINT `fk_co_11` FOREIGN KEY (`courseId`) REFERENCES `course` (`courseId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_enq_id_222` FOREIGN KEY (`enquiryId`) REFERENCES `enquiry` (`enquiryId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

INSERT INTO `enquirycourse` VALUES (3,1,3),(4,2,3),(5,1,4),(6,2,4),(7,3,5),(8,4,5),(10,1,9),(11,2,9),(12,1,10),(13,2,10),(14,7,11),(15,1,12),(16,7,12),(17,1,13),(18,7,13);

DROP TABLE IF EXISTS `followup`;
CREATE TABLE `followup` (
  `followupId` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `enquiryId` BIGINT(20) DEFAULT NULL,
  `doe` DATETIME DEFAULT NULL,
  `detail` VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (`followupId`),
  KEY `fk_enqid_111_idx` (`enquiryId`),
  CONSTRAINT `fk_enqid_111` FOREIGN KEY (`enquiryId`) REFERENCES `enquiry` (`enquiryId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO `followup` VALUES (1,3,NULL,'Testing followup 1');