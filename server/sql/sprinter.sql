-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: sprinter
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (1,'L1'),(2,'L2'),(3,'L3'),(4,'M1'),(5,'M2');
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_student`
--

DROP TABLE IF EXISTS `classroom_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_student` (
  `classroom_id` int NOT NULL,
  `student_id` int NOT NULL,
  KEY `classroom_id` (`classroom_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `classroom_student_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classroom_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_student`
--

LOCK TABLES `classroom_student` WRITE;
/*!40000 ALTER TABLE `classroom_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint`
--

DROP TABLE IF EXISTS `sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprint` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `classroom_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `classroom_id` (`classroom_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `sprint_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `sprint_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint`
--

LOCK TABLES `sprint` WRITE;
/*!40000 ALTER TABLE `sprint` DISABLE KEYS */;
/*!40000 ALTER TABLE `sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint_tech`
--

DROP TABLE IF EXISTS `sprint_tech`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprint_tech` (
  `sprint_id` int NOT NULL,
  `tech_id` int NOT NULL,
  KEY `sprint_id` (`sprint_id`),
  CONSTRAINT `sprint_tech_ibfk_1` FOREIGN KEY (`sprint_id`) REFERENCES `sprint` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sprint_tech_ibfk_2` FOREIGN KEY (`sprint_id`) REFERENCES `tech` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint_tech`
--

LOCK TABLES `sprint_tech` WRITE;
/*!40000 ALTER TABLE `sprint_tech` DISABLE KEYS */;
/*!40000 ALTER TABLE `sprint_tech` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_group`
--

DROP TABLE IF EXISTS `student_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_group`
--

LOCK TABLES `student_group` WRITE;
/*!40000 ALTER TABLE `student_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_group_member`
--

DROP TABLE IF EXISTS `student_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_group_member` (
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `student_group_member_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `student_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_group_member_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_group_member`
--

LOCK TABLES `student_group_member` WRITE;
/*!40000 ALTER TABLE `student_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tech`
--

DROP TABLE IF EXISTS `tech`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tech` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `devicon` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`devicon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tech`
--

LOCK TABLES `tech` WRITE;
/*!40000 ALTER TABLE `tech` DISABLE KEYS */;
/*!40000 ALTER TABLE `tech` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `email` varchar(145) NOT NULL,
  `password` varchar(256) DEFAULT NULL,
  `is_teacher` tinyint(1) NOT NULL DEFAULT '0',
  `classroom_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_name` (`first_name`,`last_name`),
  KEY `classroom_id` (`classroom_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-28  9:33:53
