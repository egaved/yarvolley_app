-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: yarvolley
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `league`
--

DROP TABLE IF EXISTS `league`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league`
--

LOCK TABLES `league` WRITE;
/*!40000 ALTER TABLE `league` DISABLE KEYS */;
INSERT INTO `league` VALUES (2,'Высшая лига 2025',1);
/*!40000 ALTER TABLE `league` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match`
--

DROP TABLE IF EXISTS `match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `location` varchar(100) NOT NULL,
  `is_upcoming` tinyint(1) NOT NULL,
  `team1_id` int NOT NULL,
  `team2_id` int NOT NULL,
  `league_id` int NOT NULL,
  `team1_total_score` int DEFAULT NULL,
  `team2_total_score` int DEFAULT NULL,
  `winner_team_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_match_league` (`league_id`),
  KEY `fk_match_team1` (`team1_id`),
  KEY `fk_match_team2` (`team2_id`),
  CONSTRAINT `fk_match_league` FOREIGN KEY (`league_id`) REFERENCES `league` (`id`),
  CONSTRAINT `fk_match_team1` FOREIGN KEY (`team1_id`) REFERENCES `team` (`id`),
  CONSTRAINT `fk_match_team2` FOREIGN KEY (`team2_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match`
--

LOCK TABLES `match` WRITE;
/*!40000 ALTER TABLE `match` DISABLE KEYS */;
INSERT INTO `match` VALUES (1,'2025-06-15 18:30:00','зал ЯГТУ',1,4,5,2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `birth_year` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  `team_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_player_team` (`team_id`),
  CONSTRAINT `fk_player_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (3,'Веденин Егор',2003,183,4);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `set`
--

DROP TABLE IF EXISTS `set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `set` (
  `id` int NOT NULL AUTO_INCREMENT,
  `set_number` int NOT NULL,
  `team1_score` int DEFAULT NULL,
  `team2_score` int DEFAULT NULL,
  `match_id` int NOT NULL,
  `winner_team_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_set_match` (`match_id`),
  KEY `fk_set_winner` (`winner_team_id`),
  CONSTRAINT `fk_set_match` FOREIGN KEY (`match_id`) REFERENCES `match` (`id`),
  CONSTRAINT `fk_set_winner` FOREIGN KEY (`winner_team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `set`
--

LOCK TABLES `set` WRITE;
/*!40000 ALTER TABLE `set` DISABLE KEYS */;
/*!40000 ALTER TABLE `set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standing`
--

DROP TABLE IF EXISTS `standing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `standing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_amount` int NOT NULL,
  `wins` int NOT NULL,
  `losses` int NOT NULL,
  `position` int NOT NULL,
  `balance` int NOT NULL,
  `points` int NOT NULL,
  `updated_at` date NOT NULL,
  `league_id` int NOT NULL,
  `team_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_standing_league` (`league_id`),
  KEY `fk_standing_team` (`team_id`),
  CONSTRAINT `fk_standing_league` FOREIGN KEY (`league_id`) REFERENCES `league` (`id`),
  CONSTRAINT `fk_standing_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standing`
--

LOCK TABLES `standing` WRITE;
/*!40000 ALTER TABLE `standing` DISABLE KEYS */;
INSERT INTO `standing` VALUES (1,0,0,0,0,0,0,'2025-06-15',2,4);
/*!40000 ALTER TABLE `standing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `league_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_team_league` (`league_id`),
  CONSTRAINT `fk_team_league` FOREIGN KEY (`league_id`) REFERENCES `league` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (4,'Сумерки',2),(5,'ЯРЗ',2);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'yarvolley'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-19 20:27:07
