-- MySQL dump 10.13  Distrib 9.0.1, for Linux (x86_64)
--
-- Host: localhost    Database: adminjs
-- ------------------------------------------------------
-- Server version	9.0.1

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

-- Check if the 'adminjs' database exists; create it if it doesn't
CREATE DATABASE IF NOT EXISTS adminjs;

-- Use the 'adminjs' database
USE adminjs;

--
-- Table structure for table `Organisation`
--

DROP TABLE IF EXISTS `Organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organisation` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(50) NOT NULL,
  `LongName` text NOT NULL,
  `CountdownDuration` int DEFAULT NULL,
  `WalkingExDelay` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organisation`
--

LOCK TABLES `Organisation` WRITE;
/*!40000 ALTER TABLE `Organisation` DISABLE KEYS */;
INSERT INTO `Organisation` VALUES (1,'sasasa','ssqsaa',2,1),(2,'new','newxx',11,11);
/*!40000 ALTER TABLE `Organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sessions`
--

DROP TABLE IF EXISTS `Sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sessions` (
  `sid` varchar(36) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sessions`
--

LOCK TABLES `Sessions` WRITE;
/*!40000 ALTER TABLE `Sessions` DISABLE KEYS */;
INSERT INTO `Sessions` VALUES ('0AvoYeNblpSkTjW3FxZjMbN5hoBR4sMN','2024-10-11 08:08:46','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2024-10-11T08:04:55.408Z\",\"secure\":false,\"httpOnly\":false,\"path\":\"/\"},\"user\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 08:04:55','2024-10-10 08:08:46'),('dDAsz-WqZcWCBvlFIqmdPcSiBntUtoAj','2024-10-11 08:23:24','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 03:10:18','2024-10-10 08:23:24'),('HHXNl8-Nm5xDmzOwe3qvKD5-45vqSU2y','2024-10-11 08:13:17','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2024-10-11T08:09:47.952Z\",\"secure\":false,\"httpOnly\":false,\"path\":\"/\"},\"user\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 08:09:48','2024-10-10 08:13:17'),('i9bsHPSLBwUXAiO8-_0LU7lBuNtwlpN9','2024-10-11 03:13:23','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 03:13:23','2024-10-10 03:13:23'),('jik_7upYaHJnlLy6DBa4rrEq_-zcY2oa','2024-10-11 08:41:45','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2024-10-11T08:41:39.218Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 08:41:39','2024-10-10 08:41:45'),('kTBXJvgX9vjfDmyBg-u7ke3HCRTGCpJP','2024-10-11 08:34:40','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2024-10-11T08:34:28.256Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 08:34:28','2024-10-10 08:34:40'),('o_I8HzjNeeo1Ta9Li5b5VT2vzcIXYb3Y','2024-10-11 03:13:40','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 03:13:40','2024-10-10 03:13:40'),('TunFiZeD9n7r6simbv_JtZ4B6sjoZbee','2024-10-11 08:28:18','{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2024-10-11T08:27:38.638Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"}}','2024-10-10 08:27:38','2024-10-10 08:28:18');
/*!40000 ALTER TABLE `Sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credential`
--

DROP TABLE IF EXISTS `credential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credential` (
  `ID` varchar(255) NOT NULL,
  `UserId` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PublicKey` blob NOT NULL,
  `WebAuthnUserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Counter` bigint NOT NULL,
  `DeviceType` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `BackedUp` tinyint(1) NOT NULL,
  `Transports` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastUsed` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `credentials__web_authn_user_i_d__user_id` (`WebAuthnUserID`,`UserId`) USING BTREE,
  UNIQUE KEY `credential__web_authn_user_i_d__user_id` (`WebAuthnUserID`,`UserId`) USING BTREE,
  UNIQUE KEY `credential__web_authn_user_i_d__user_i_d` (`WebAuthnUserID`,`UserId`),
  UNIQUE KEY `credential__web_authn_user_i_d` (`WebAuthnUserID`),
  KEY `idx_webauthn_user_id` (`WebAuthnUserID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='For SimpleWebAuthn';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credential`
--

LOCK TABLES `credential` WRITE;
/*!40000 ALTER TABLE `credential` DISABLE KEYS */;
INSERT INTO `credential` VALUES ('MC4xMzQyMDE2MDQ3MzEyNA','84abfbef-68d2-4e5a-bc0b-c6072b9b3e47',_binary 'b\'TZ\\n\\x96\\x87\\xbc?Ku\\xa0\\xefk\\xed\\xdaoQ_o\\xb6\\x893\\xb6}eJ\\x18\\x0c\\xa4\\xe1\\na9\\xd4\\x03\\x00\\xa8tFak/\\x02msz\\xbf\\xfe\\xab\\x91!\\xb9\\xcf\\xdd\\x15rm\\x7f/T\\xb4i\\x19\\xa4A\'','test-webauthn-1',1,NULL,1,NULL,'2024-10-01 14:00:00','2024-10-10 06:31:52');
/*!40000 ALTER TABLE `credential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `OrganisationID` int unsigned NOT NULL,
  `PId` int unsigned DEFAULT '0',
  `ShortName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LongName` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IdleDefinition` int DEFAULT NULL,
  `IdleTime` int DEFAULT NULL,
  `NoIdleTime` int DEFAULT NULL,
  `MinimumTime` int DEFAULT NULL,
  `DefaultDelayInterval` int DEFAULT NULL,
  `CalorieGoal` int DEFAULT NULL,
  `CountdownDuration` int DEFAULT NULL,
  `WalkingExDelay` int DEFAULT NULL,
  `WalkingExID` int unsigned DEFAULT NULL,
  `ExitEnabled` tinyint(1) DEFAULT NULL,
  `WalkingExPromptText` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NotificationDialogPromptText` varchar(130) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `OrganisationID` (`OrganisationID`) USING BTREE,
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`OrganisationID`) REFERENCES `organisation` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,1,0,'Dept1','Department One',1,10,20,30,5,100,60,5,1,1,'Prompt 1','Dialog 1'),(2,2,0,'Dept2','Department Two',2,15,25,35,10,200,120,10,2,1,'Prompt 2','Dialog 2'),(3,3,0,'Dept3','Department Three',3,20,30,40,15,300,180,15,3,1,'Prompt 3','Dialog 3'),(4,4,0,'Dept4','Department Four',4,25,35,45,20,400,240,20,4,1,'Prompt 4','Dialog 4');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise`
--

DROP TABLE IF EXISTS `exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Caption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` enum('A','I','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'repetition / duration',
  `CategoryID` int DEFAULT NULL,
  `Image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `VideoURL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Duration` datetime DEFAULT NULL,
  `Kilojoules` float DEFAULT NULL,
  `CalculationType` enum('C','M','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ExerciseDelayID` int unsigned DEFAULT NULL,
  `DepartmentID` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `DepartmentID` (`DepartmentID`) USING BTREE,
  CONSTRAINT `exercise_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise`
--

LOCK TABLES `exercise` WRITE;
/*!40000 ALTER TABLE `exercise` DISABLE KEYS */;
INSERT INTO `exercise` VALUES (1,'Caption1','A','Type1',1,'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain','http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4','2024-08-07 05:19:28',100,'C',1,1),(2,'Caption2','I','Type2',2,'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain','http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4','2024-08-07 05:19:28',200,'M',2,2),(3,'Caption3','D','Type3',NULL,'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain','http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4','2024-08-07 05:19:28',300,'O',3,3),(6,'aaaaaa','A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_category`
--

DROP TABLE IF EXISTS `exercise_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_category` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PID` int DEFAULT NULL,
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Status` int DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_category`
--

LOCK TABLES `exercise_category` WRITE;
/*!40000 ALTER TABLE `exercise_category` DISABLE KEYS */;
INSERT INTO `exercise_category` VALUES (1,1,'Sport',1),(2,1,'Basketball',1);
/*!40000 ALTER TABLE `exercise_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_delay`
--

DROP TABLE IF EXISTS `exercise_delay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_delay` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ExerciseID` int NOT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Duration` float DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UserID` (`UserID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_delay`
--

LOCK TABLES `exercise_delay` WRITE;
/*!40000 ALTER TABLE `exercise_delay` DISABLE KEYS */;
INSERT INTO `exercise_delay` VALUES (5,'ff83a44e-5e1d-44cb-a02a-505ff08e1e95',2,'2024-10-01 14:00:00',12);
/*!40000 ALTER TABLE `exercise_delay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_department`
--

DROP TABLE IF EXISTS `exercise_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_department` (
  `ExerciseID` int unsigned NOT NULL,
  `DepartmentID` int unsigned NOT NULL,
  PRIMARY KEY (`ExerciseID`,`DepartmentID`) USING BTREE,
  KEY `DepartmentID` (`DepartmentID`) USING BTREE,
  CONSTRAINT `ExerciseDepartment_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `exercise` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ExerciseDepartment_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_department`
--

LOCK TABLES `exercise_department` WRITE;
/*!40000 ALTER TABLE `exercise_department` DISABLE KEYS */;
INSERT INTO `exercise_department` VALUES (2,2);
/*!40000 ALTER TABLE `exercise_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_event`
--

DROP TABLE IF EXISTS `exercise_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_event` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ExerciseID` int NOT NULL,
  `PlanID` int NOT NULL,
  `StartTime` time DEFAULT NULL,
  `EndTime` time DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  `IsRepeat` tinyint DEFAULT NULL COMMENT '1-yes 0-no',
  `RepeatCount` int DEFAULT NULL,
  `Interval` int DEFAULT NULL COMMENT 'minutes',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='For exercise plan';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_event`
--

LOCK TABLES `exercise_event` WRITE;
/*!40000 ALTER TABLE `exercise_event` DISABLE KEYS */;
INSERT INTO `exercise_event` VALUES (1,1,1,'08:00:00','12:00:00',4,1,1,5,10),(2,2,1,'14:00:00','16:00:00',2,1,1,2,10);
/*!40000 ALTER TABLE `exercise_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_log`
--

DROP TABLE IF EXISTS `exercise_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_log` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ExerciseID` int unsigned NOT NULL,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Repetitions` int DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Source` enum('M','A','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `StartDateTime` datetime DEFAULT NULL,
  `EndDateTime` datetime DEFAULT NULL,
  `StandStartDateTime` datetime DEFAULT NULL,
  `StandEndDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_log`
--

LOCK TABLES `exercise_log` WRITE;
/*!40000 ALTER TABLE `exercise_log` DISABLE KEYS */;
INSERT INTO `exercise_log` VALUES (1,1,'4',12,12,'M','2024-08-22 14:00:00','2024-08-22 14:00:00','2024-08-11 14:00:00','2024-07-31 14:00:00'),(7,1,'84abfbef-68d2-4e5a-bc0b-c6072b9b3e47',0,12,'M','2024-09-30 14:00:00','2024-10-22 13:00:00','2024-10-14 13:00:00','2024-10-15 13:00:00');
/*!40000 ALTER TABLE `exercise_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_log_question`
--

DROP TABLE IF EXISTS `exercise_log_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_log_question` (
  `ExerciseLogID` int unsigned NOT NULL,
  `QuestionID` int NOT NULL,
  `Response` int DEFAULT NULL,
  PRIMARY KEY (`ExerciseLogID`,`QuestionID`) USING BTREE,
  KEY `QuestionID` (`QuestionID`) USING BTREE,
  CONSTRAINT `ExerciseLogQuestion_ibfk_1` FOREIGN KEY (`ExerciseLogID`) REFERENCES `exercise_log` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ExerciseLogQuestion_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_log_question`
--

LOCK TABLES `exercise_log_question` WRITE;
/*!40000 ALTER TABLE `exercise_log_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `exercise_log_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_plan`
--

DROP TABLE IF EXISTS `exercise_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_plan` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ContentType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `OrganisationID` int DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL COMMENT 'optional',
  `Status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'active/inactive',
  `Type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Frequency` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Day, WorkingDay, Weekend, Custom',
  `CustomFrequency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Mon,Tues,......',
  `IsAllDay` tinyint(1) DEFAULT NULL,
  `Intervals` int DEFAULT NULL COMMENT 'minutes of interval between workout sessions',
  `StartTimeZone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `StartDateTime` datetime DEFAULT NULL,
  `EndTimeZone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `EndDateTime` datetime DEFAULT NULL,
  `Priority` int DEFAULT NULL COMMENT '0-highest',
  `Attendees` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'emailAddress for Attendees',
  `Remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_plan`
--

LOCK TABLES `exercise_plan` WRITE;
/*!40000 ALTER TABLE `exercise_plan` DISABLE KEYS */;
INSERT INTO `exercise_plan` VALUES (10,'aaaa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','2024-10-10 06:49:14'),(11,'aaa','111','11',2,2,'1','1','1','1',1,1,'11','2024-10-08 13:00:00','11','2024-10-17 13:00:00',1,'12','121','2024-10-08 13:00:00');
/*!40000 ALTER TABLE `exercise_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helpful_hint`
--

DROP TABLE IF EXISTS `helpful_hint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `helpful_hint` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `HintOrder` int DEFAULT NULL,
  `DepartmentID` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `DepartmentID` (`DepartmentID`) USING BTREE,
  CONSTRAINT `HelpfulHints_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helpful_hint`
--

LOCK TABLES `helpful_hint` WRITE;
/*!40000 ALTER TABLE `helpful_hint` DISABLE KEYS */;
INSERT INTO `helpful_hint` VALUES (1,'edasdas',122,2),(2,'hello',0,2);
/*!40000 ALTER TABLE `helpful_hint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `microsoft_account`
--

DROP TABLE IF EXISTS `microsoft_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `microsoft_account` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `microsoftEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `oid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sub` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `isLinked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UserID` (`UserID`) USING BTREE,
  CONSTRAINT `microsoft_account_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `microsoft_account`
--

LOCK TABLES `microsoft_account` WRITE;
/*!40000 ALTER TABLE `microsoft_account` DISABLE KEYS */;
INSERT INTO `microsoft_account` VALUES (1,'84abfbef-68d2-4e5a-bc0b-c6072b9b3e47','admin@outlook.com','11222111','12121212',1);
/*!40000 ALTER TABLE `microsoft_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LongName` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CountdownDuration` int DEFAULT NULL,
  `WalkingExDelay` int DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
INSERT INTO `organisation` VALUES (1,'Default','Default Organization',0,0),(2,'Org2','Organization Two',121,112),(3,'Org3','Organization Three',22,12),(4,'Org4','Organization Four',22,11);
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Caption` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Order` int DEFAULT NULL,
  `MinCaption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `MaxCaption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Status` enum('A','I','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Type` enum('MC','TEXT','RATING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (4,'1',NULL,NULL,NULL,'A','2024-10-02 14:00:00','2024-10-23 13:00:00','TEXT');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `sid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('ChARoIx1ol2d0YJIh07qrhJOs0VzCKJ6','2024-09-18 06:10:19','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":true,\"httpOnly\":true,\"path\":\"/\"},\"adminUser\":{\"email\":\"admin@example.com\",\"role\":\"admin\"},\"challenge\":null}','2024-09-11 07:07:26','2024-09-17 06:10:19');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_response`
--

DROP TABLE IF EXISTS `survey_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey_response` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `DaysWorked` int DEFAULT NULL,
  `HoursWorked` int DEFAULT NULL,
  `PercentSitting` int DEFAULT NULL,
  `PercentStanding` int DEFAULT NULL,
  `PercentWalking` int DEFAULT NULL,
  `PercentHeavy` int DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UserID` (`UserID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey_response`
--

LOCK TABLES `survey_response` WRITE;
/*!40000 ALTER TABLE `survey_response` DISABLE KEYS */;
INSERT INTO `survey_response` VALUES (1,'3','2024-08-20',12,21,12,21,2121,12),(2,'3','2024-08-20',12,12,12,12,12,12);
/*!40000 ALTER TABLE `survey_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DepartmentID` int unsigned DEFAULT NULL,
  `GivenNames` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Surname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PreferredName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `JobTitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Passkey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` enum('M','F','O','X') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Height` int DEFAULT NULL,
  `Status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `AdminFlag` int DEFAULT NULL,
  `ExitEnabled` tinyint(1) DEFAULT NULL,
  `IsNew` tinyint(1) DEFAULT NULL,
  `CalorieGoal` int DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `DepartmentID` (`DepartmentID`) USING BTREE,
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('84abfbef-68d2-4e5a-bc0b-c6072b9b3e47',NULL,'','','','defaultadmin','','','admin@example.com','$2a$10$GWWezmCkuprKo4./OQZgIOvV99Fl1EqDlClUdd4LxFIDXBeqMJ8om','',NULL,'X',NULL,'A',0,0,1,2000,'2024-09-11 17:32:08','2024-09-11 17:32:08'),('ff83a44e-5e1d-44cb-a02a-505ff08e1e95',NULL,'','','','aaaa','','','kyonccw@outlook.com','$2a$10$6yPYXYz5NzC6ueBe3HWQVuYI4erPv3R0FKAxJEjgqTivNG4j5ytVm','',NULL,'X',NULL,'A',0,0,1,2000,'2024-10-10 05:31:59','2024-10-10 05:31:59');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_event`
--

DROP TABLE IF EXISTS `user_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_event` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `EventType` int DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UserID` (`UserID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_event`
--

LOCK TABLES `user_event` WRITE;
/*!40000 ALTER TABLE `user_event` DISABLE KEYS */;
INSERT INTO `user_event` VALUES (1,'84abfbef-68d2-4e5a-bc0b-c6072b9b3e47','2024-10-09',0);
/*!40000 ALTER TABLE `user_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_exercise_log`
--

DROP TABLE IF EXISTS `user_exercise_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_exercise_log` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EventID` int DEFAULT NULL,
  `EventType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Organisation / Personal',
  `Status` int DEFAULT NULL,
  `Duration` double DEFAULT NULL,
  `CreatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_exercise_log`
--

LOCK TABLES `user_exercise_log` WRITE;
/*!40000 ALTER TABLE `user_exercise_log` DISABLE KEYS */;
INSERT INTO `user_exercise_log` VALUES (1,'ff83a44e-5e1d-44cb-a02a-505ff08e1e95',1,'aaa',0,12,'2024-10-09 13:00:00');
/*!40000 ALTER TABLE `user_exercise_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorite`
--

DROP TABLE IF EXISTS `user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorite` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ExerciseID` int unsigned NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `ExerciseID` (`ExerciseID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorite`
--

LOCK TABLES `user_favorite` WRITE;
/*!40000 ALTER TABLE `user_favorite` DISABLE KEYS */;
INSERT INTO `user_favorite` VALUES (1,'ff83a44e-5e1d-44cb-a02a-505ff08e1e95',2,'2024-10-02 14:00:00');
/*!40000 ALTER TABLE `user_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_position`
--

DROP TABLE IF EXISTS `user_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_position` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UserID` (`UserID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_position`
--

LOCK TABLES `user_position` WRITE;
/*!40000 ALTER TABLE `user_position` DISABLE KEYS */;
INSERT INTO `user_position` VALUES (1,'ff83a44e-5e1d-44cb-a02a-505ff08e1e95','2024-10-02 14:00:00','aaa');
/*!40000 ALTER TABLE `user_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_setting` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='For store user setting like allow notification etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_setting`
--

LOCK TABLES `user_setting` WRITE;
/*!40000 ALTER TABLE `user_setting` DISABLE KEYS */;
INSERT INTO `user_setting` VALUES (1,'84abfbef-68d2-4e5a-bc0b-c6072b9b3e47','11111','1111');
/*!40000 ALTER TABLE `user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_weight`
--

DROP TABLE IF EXISTS `user_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_weight` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UserID` (`UserID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_weight`
--

LOCK TABLES `user_weight` WRITE;
/*!40000 ALTER TABLE `user_weight` DISABLE KEYS */;
INSERT INTO `user_weight` VALUES (1,'84abfbef-68d2-4e5a-bc0b-c6072b9b3e47','2024-10-10 13:00:00',122);
/*!40000 ALTER TABLE `user_weight` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-10  8:46:52
