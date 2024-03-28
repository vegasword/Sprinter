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
INSERT INTO `classroom` VALUES (1,'L1');
INSERT INTO `classroom` VALUES (2,'L2');
INSERT INTO `classroom` VALUES (3,'L3');
INSERT INTO `classroom` VALUES (4,'M1');
INSERT INTO `classroom` VALUES (5,'M2');
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (17,'Alexandre','Perché','alexandre.perche@edu.esiee-it.fr','b72f9ec8882817c455ca45534a82d3452db2216e88b23333586c41d217079b8c',0,NULL);
INSERT INTO `user` VALUES (18,'Julien','Acher','julien.acher@edu.esiee-it.fr','a64ae4e1d3bf2eec0d2b1d2b9f810999d68220f8d56aa4c264f5377de150b2b2',0,NULL);
INSERT INTO `user` VALUES (19,'Amine','Benguesmi','amine.benguesmi@edu.esiee-it.fr','5bf645c5d785c61c48088e7de780be99210475c5cf8e7eb9c85cd30869e03f70',0,NULL);
INSERT INTO `user` VALUES (20,'Ines','Berehili','ines.beherili@edu.esiee-it.fr','38f3c18519de136150820d7aa869d24e32f64e42f6643505c5d6c613b54081de',0,NULL);
INSERT INTO `user` VALUES (21,'Ilyas','Boialami','ilyas.boialami@edu.esiee-it.fr','5c819823881be042971f57d73538295d7ef5a67d23d938be080aafab294352bf',0,NULL);
INSERT INTO `user` VALUES (23,'Tom','Bourti','tom.bourti@edu.esiee-it.fr','fa0e560115fec04186618d87825d73f078d21a2246d3eec5a60dc99f744a4b31',0,NULL);
INSERT INTO `user` VALUES (24,'Baptiste','Comoy','baptiste.comoy@edu.esiee-it.fr','1c87369d5bf9507666684ae71e5b9301df7a9d4c577c6c8ead718cc2dbae3aca',0,NULL);
INSERT INTO `user` VALUES (25,'Eliott','Cormillot','eliott.cormillot@edu.esiee-it.fr','3d59e64190fa53c71026197f92b90ce9ca45459a6533572572656759d20a801d',0,NULL);
INSERT INTO `user` VALUES (26,'Kévin','D\'almeida','kevin.dalmeida@edu.esiee-it.fr','c348fae7a174ac02cf470eaf0820c0462a6d77d1c97e8012a07b03da6b1adc2e',0,NULL);
INSERT INTO `user` VALUES (27,'Antony','Dias','antony.dias@edu.esiee-it.fr','e78ee10b83de3f61eac29a902cf60823f3fbac3de5da26f4ebdd71253a129885',0,NULL);
INSERT INTO `user` VALUES (28,'Yanis','Gassa','yanis.gassa@edu.esiee-it.fr','0c835ca9524d6d6cabcc4dbaa03104d7d7920794b5d7c1c15e4a1257a6878959',0,NULL);
INSERT INTO `user` VALUES (29,'Mathias','Ghanem','mathias.ghanem@edu.esiee-it.fr','b8ca6c675d3e513d6c52488f0a8e098be1c91e56677af058b8f029d5a709f7df',0,NULL);
INSERT INTO `user` VALUES (30,'Alexis','Godet','alexis.godet@edu.esiee-it.fr','3ad42e2133b6546d0dec4edb3004eed9dedc3873cd36c28f8f296ac746e910f0',0,NULL);
INSERT INTO `user` VALUES (31,'Eloän','Hoarau','eloan.hoarau@edu.esiee-it.fr','7beccc543a4d2194838e460a6ab192af2905adc3296f3d41abf910e63464c231',0,NULL);
INSERT INTO `user` VALUES (32,'Sebastien','Hubert','sebastien.hubert@edu.esiee-it.fr','159ac13a5613355ba91cc10b9df0bef9994c63bc268971c3f40324a6906876a7',0,NULL);
INSERT INTO `user` VALUES (33,'Ahmad','Jaber','ahmad.jaber@edu.esiee-it.fr','d5d1a8983bce863110bd80bead69f83314d25bbb7e8e3bff45a7906c0d8aa1b5',0,NULL);
INSERT INTO `user` VALUES (34,'Leo','Kontente','leo.kontente@edu.esiee-it.fr','0b3c08e96d2f50346adff50e1af7e59ec12f893c58462927d183ea9cf0ac6fc9',0,NULL);
INSERT INTO `user` VALUES (35,'Kilian','Martin','kilian.martin@edu.esiee-it.fr','39ddb75760c9ec0eb69e709a6b7943a328092c3b224df15f8b5f83bdb18ec0d2',0,NULL);
INSERT INTO `user` VALUES (36,'Maxime','Penn','maxime.penn@edu.esiee-it.fr','c319f04428ec6059d2a16603f935b07ff4944938c1128baac9addd013aff3a5f',0,NULL);
INSERT INTO `user` VALUES (37,'Enzo','Pohu','enzo.pohu@edu.esiee-it.fr','3a44020299766d4071828c2f701d5602cd149279e4e4e43a6e47a7bd649e6aab',0,NULL);
INSERT INTO `user` VALUES (38,'Nicolas','Tenneguin','nicolas.tenneguin@edu.esiee-it.fr','d41766b8ebd1cba34c5d01e4b1fbc5a01e819aec902e382de77edaaf178140bf',0,NULL);
INSERT INTO `user` VALUES (39,'Malicia','Torrent','malicia.torrent@edu.esiee-it.fr','e43e845a05896a259e586575a6660a2d00b2e786a88a1ca4b494384c21a08faf',0,NULL);
INSERT INTO `user` VALUES (40,'Aurelien','Ziegler','aurelien.ziegler@edu.esiee-it.fr','87d417671f4f2e6478b877d27cc63fc966e5fcf7ca090fda5b0078480e2669de',0,NULL);
INSERT INTO `user` VALUES (41,'Charles','Zobiri','charles.zobiri@edu.esiee-it.fr','35c4baab2deb259f7495b99e7769378054bf53d70614ab81d3fcc55ca7c119e2',0,NULL);
INSERT INTO `user` VALUES (42,'Fraçois','Cornet','francois.cornet@esiee-it.fr','bbbddf1ee2e4442266ab8b447ad45f0af0b631095a7579db0a7a167720369fe2',1,NULL);
INSERT INTO `user` VALUES (43,'André','Desousa','andre.desousa@esiee-it.fr','92e0a24be07d700b093c2b52d2805f5324e29bc5264264eb3edfa1ceaa859179',1,NULL);
INSERT INTO `user` VALUES (44,'Joachim','Thibout','joachim.thibout@esiee-it.fr','9ca69d10b44cecbccae13ffda3eb7ef989cb6a936d5a6c33e85939486c272bd4',1,NULL);
INSERT INTO `user` VALUES (45,'Killian','Mejasson','killian.mejasson@edu.esiee-it.fr','ef82202153fc6393c19ef612f120b1d08f164cb96b9de438f346f905ebfacfa9',0,NULL);
INSERT INTO `user` VALUES (46,'Thibaud','Magniez','thibaud.magniez@esiee-it.fr','8142232e2e6355ab22727bfae677a1921ba4427480a59bafa48034f044259d14',1,NULL);
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

-- Dump completed on 2024-03-28 11:00:24
