-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: mysql1.cs.clemson.edu    Database: chaoh_201308_cpsc462
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Books` (
  `id` int(10) NOT NULL,
  `bookName` varchar(100) DEFAULT NULL,
  `bookAuthor` varchar(100) DEFAULT NULL,
  `bookOwner` int(10) DEFAULT NULL,
  `bookProfile` varchar(100) DEFAULT NULL,
  `bookValue` int(10) DEFAULT NULL,
  `bookBorrower` int(10) DEFAULT NULL,
  `bookStatus` int(10) DEFAULT NULL,
  `bookLoveCount` int(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (1,'iosbook','chaoh',1,'iosbook-1.png',10,1,0,5),(2,'iosAdvance','chaoh',3,'iosbook-2.png',5,1,0,6),(3,'iosdesign','chaoh',2,'iosbook-3.png',10,1,0,7);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Borrow`
--

DROP TABLE IF EXISTS `Borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Borrow` (
  `userID` int(100) DEFAULT NULL,
  `borrowDate` text,
  `returnDate` text,
  `bookID` int(100) DEFAULT NULL,
  `borrowID` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`borrowID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Borrow`
--

LOCK TABLES `Borrow` WRITE;
/*!40000 ALTER TABLE `Borrow` DISABLE KEYS */;
INSERT INTO `Borrow` VALUES (1,'2014-10-08','2014-10-20',3,1),(1,'2014-10-08','2014-10-20',3,2),(1,'2014-10-08','2014-10-20',3,3),(1,'2014-10-08','2014-10-09',3,4),(1,'2014-10-09','2014-10-10',3,5),(1,'2014-10-09','2014-10-21',2,6),(1,'2014-10-09','2014-10-10',3,7),(1,'2014-10-14','2014-11-06',2,8),(1,'2014-10-18','2015-02-17',1,9),(1,'2014-10-22','2015-02-22',1,10);
/*!40000 ALTER TABLE `Borrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) DEFAULT NULL,
  `userPassword` varchar(100) DEFAULT NULL,
  `userProfile` varchar(100) DEFAULT NULL,
  `userValue` int(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (0,'null','0','null.png',0),(1,'chaoh','123','1.png',1000),(2,'runzhw','456','garfield.png',100),(3,'zian','789','3.png',10),(6,'jingweiz','123','null.png',0),(7,'pargas','111','null.png',0),(8,'Di','123','8.png',0),(9,'hello','','null.png',0),(10,'hello','1234','null.png',0),(11,'qqq','1234','null.png',0),(12,'jhull2','12345','null.png',0),(13,'wangguan','123','null.png',0),(14,'123','123',NULL,NULL),(15,'123','123',NULL,NULL),(16,'qweasd','qweasd',NULL,NULL);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadata`
--

DROP TABLE IF EXISTS `metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadata` (
  `table_name` varchar(100) DEFAULT NULL,
  `table_attribute` varchar(100) DEFAULT NULL,
  `show_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadata`
--

LOCK TABLES `metadata` WRITE;
/*!40000 ALTER TABLE `metadata` DISABLE KEYS */;
INSERT INTO `metadata` VALUES ('Users','id','ID'),('Users','userName','Name'),('Users','userPassword','Password'),('Users','userProfile','Photo'),('Users','userValue','Current Money'),('Books','id','ID'),('Books','bookName','Book Name'),('Books','bookOwner','Owener'),('Books','bookProfile','Book Front Page'),('Books','bookValue','Cost'),('Books','bookBorrower','Borrower'),('Books','bookStatus','Status'),('Books','bookLoveCount','Like'),('Borrow','borrowID','ID'),('Borrow','userID','userID'),('Borrow','bookID','bookID'),('Borrow','borrowDate','borrowDate'),('Borrow','returnDate','returnDate');
/*!40000 ALTER TABLE `metadata` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-25 21:45:36
