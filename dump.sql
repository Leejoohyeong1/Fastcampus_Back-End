-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for osx10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: Fastcampus
-- ------------------------------------------------------
-- Server version	10.2.14-MariaDB

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
-- Table structure for table `DiaryList`
--

DROP TABLE IF EXISTS `DiaryList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DiaryList` (
  `No` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `Token` varchar(255) NOT NULL COMMENT '토큰',
  `authority` int(1) NOT NULL COMMENT '권한',
  `Contents` text DEFAULT NULL COMMENT '내용',
  `Date_created` date DEFAULT NULL,
  PRIMARY KEY (`No`),
  KEY `Token` (`Token`),
  CONSTRAINT `diarylist_ibfk_1` FOREIGN KEY (`Token`) REFERENCES `Userinfo` (`Login_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DiaryList`
--

LOCK TABLES `DiaryList` WRITE;
/*!40000 ALTER TABLE `DiaryList` DISABLE KEYS */;
INSERT INTO `DiaryList` VALUES (1,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3',2,'hello world','2018-04-24'),(2,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3',1,'내용이당22sssssstttt','2018-04-14'),(3,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3',1,'Tttt내용이당33ttttttttttttttttttttttkkkkkkkkksssssss\n\n 님 될것 같죠6:24 pm','2018-04-15'),(7,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3',1,'Tttttttttt 제발 님아 되어 주세요~~ ~제발\n\n님 좀 쩌는군\n6:57 pm','2018-04-25'),(25,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3',1,'Jkansdkjnakjsdnkajsdnkajsndkjansdjkansdjkansdjkansdjk6:47 pm6:55 pm','2018-04-25'),(27,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3',1,'La;jams;kasmnlkwnrg’nsdgkjdfnfgkjdafnbgkjansgjknsfjkdnjkdsgnjksadgfnjkdafngkjadnfgjkndfkgjndakjfgn6:48 pm','2018-04-25'),(34,'QqecB0L8fdRTVnSMLxcpkHWtB6l1',1,'7:51 pm riffs that have been released \nWe’d like \n\n\n\n7:52 pmDdddd\nDefddfg\nCgghtfh\nGfdchff\nFfhhb\n\n\nGod\n7:52 pmGdf day \n7:52 pm','2018-04-25');
/*!40000 ALTER TABLE `DiaryList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groupinfo`
--

DROP TABLE IF EXISTS `Groupinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groupinfo` (
  `No` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `mytoken` varchar(255) NOT NULL COMMENT '자신',
  `friendtoken` varchar(255) NOT NULL COMMENT '친구',
  `time` date DEFAULT NULL COMMENT '추가한 시가\n',
  PRIMARY KEY (`No`),
  UNIQUE KEY `mytoken` (`mytoken`,`friendtoken`),
  KEY `friendtoken` (`friendtoken`),
  CONSTRAINT `groupinfo_ibfk_1` FOREIGN KEY (`mytoken`) REFERENCES `Userinfo` (`Login_uid`),
  CONSTRAINT `groupinfo_ibfk_2` FOREIGN KEY (`friendtoken`) REFERENCES `Userinfo` (`Login_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groupinfo`
--

LOCK TABLES `Groupinfo` WRITE;
/*!40000 ALTER TABLE `Groupinfo` DISABLE KEYS */;
INSERT INTO `Groupinfo` VALUES (32,'QqecB0L8fdRTVnSMLxcpkHWtB6l1','e2Fbl6GkxwPFPtUaPEYcVna9jJF3',NULL),(33,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3','QqecB0L8fdRTVnSMLxcpkHWtB6l1',NULL);
/*!40000 ALTER TABLE `Groupinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Userinfo`
--

DROP TABLE IF EXISTS `Userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Userinfo` (
  `Userindex` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `UserEmail` varchar(255) DEFAULT NULL COMMENT 'email',
  `UserPwd` varchar(255) DEFAULT NULL COMMENT '비밀번호',
  `Name` varchar(255) DEFAULT NULL COMMENT '유저이름',
  `PushToken` varchar(255) DEFAULT NULL COMMENT 'FCM_Token',
  `Login_uid` varchar(255) DEFAULT NULL COMMENT 'uid_Token',
  PRIMARY KEY (`Userindex`),
  UNIQUE KEY `PushToken` (`PushToken`),
  UNIQUE KEY `Login_uid` (`Login_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Userinfo`
--

LOCK TABLES `Userinfo` WRITE;
/*!40000 ALTER TABLE `Userinfo` DISABLE KEYS */;
INSERT INTO `Userinfo` VALUES (202,'tkdrb4807@gmail.com',NULL,'이주형',NULL,'M4BRM3rQe1gYn68MM9MGep2S0ZG2'),(206,'tkdrb4807@gmail.com',NULL,'이주형',NULL,'e2Fbl6GkxwPFPtUaPEYcVna9jJF3'),(207,'lee@naver.com',NULL,'need',NULL,'izIosVQbPRgamKFQbnFkvDKdwMn1'),(208,'hoo@naver.com',NULL,'wedged',NULL,'pfBB6jkDtyRY99uqoV7TFM30bDZ2'),(216,'goo@naver.com','123123','goo',NULL,'jt3RsDz2qBMil4Q9jnFohvfm5Ul2'),(218,'hyeng@naver.com','123123','gg',NULL,'JdTVD2bKSkesx5bPqrc2avmXl6c2'),(219,'ww@naver.com','123123','123123',NULL,'qmVtCr9v6SNnaZ4bR5RQjIzH0cV2'),(221,'ync@naver.com','123123','gggg',NULL,'8spdxum1g6hxlZS4x9Z1rwurcEw2'),(222,'qweqwe@naver.com','123123','dgsdgsdf',NULL,'hMDDHJvM7uT1erWQU1DzuAuLWeh2'),(223,'oasdnasjkd@naver.comn','123123','rtnrasgf',NULL,'tiXpUoRSe3WTRdU9t5hb25P3VQP2'),(224,'www@nacver.com','123123','asdfsadf',NULL,'C2raw7SjGMc85JBHBKHINnYMHPv1'),(225,'123123@naver.com','123123','nrelgnaejkgn',NULL,'ZlINCBFMAbdAXqLNYIZ9uwyYpOi2'),(226,'aerngkjanegkjeng@naver.com','123123','asfdasdasdad',NULL,'P15ovtaAP9ZacDwyytP5PrOcc4X2'),(227,'jnsdfkjnsakjdfnajskdf@2naver.com','123123','qdsfasdfg',NULL,'kFNaREkXcKSNV2JUR8vYeq1ZzTs1'),(228,'akjsndakjsdnjk@naver.com','123123','a;fkgmakldfgmlkdfmng',NULL,'zKzm4uHDQONEyFC8i51A7FJduXh2'),(229,'lsjkldfnjksadfnjksndf@naver.com','123132','123123123123123',NULL,'8aWwmTzyiPgzBi4wZYF4a94TAJr2'),(230,'lknsdfkgjndfkjndjkfg@naver.com','123123','s;flam,al;dog',NULL,'1KOoPqW6MzgdXXYspb2a4vD6uo13'),(231,'asd@naver.com','123123','liamwdqd',NULL,'3VlLusQadGOHLnvXw8C1KSS3JW03'),(232,'qwdqwd@naver.com','123123','e;fklgmaegr',NULL,'7Vjbh2dWhGaBuMFrOdu79KhEfm42'),(233,'inojyes@gmail.com',NULL,'구민회',NULL,'WOGbhG0NpuV8wBg5z1JjMqNHE1j1'),(234,'ekjnkaerkaerjg@naver.com','123123',';ebmaefkmg',NULL,'hWXWJ4xp8RenFFY7MdarTFB8jJy1'),(235,'skdnfkjsdnfjk@naver.com','123123','12123123123',NULL,'nUSZoJi6wgegOPbanKPeXyw2hfr2'),(236,'ndfjkgnakjegn@naver.com','123123','aelirgmedfgedsfg',NULL,'dgaeaiLfYWdTxRkiVjqwkheEQK12'),(245,'bobplease88@gmail.com',NULL,'jooho park',NULL,'QqecB0L8fdRTVnSMLxcpkHWtB6l1');
/*!40000 ALTER TABLE `Userinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-30 18:39:26
