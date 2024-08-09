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

--
-- Table structure for table `Credentials`
--

DROP TABLE IF EXISTS `Credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Credentials` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int unsigned NOT NULL,
  `PublicKey` blob NOT NULL,
  `WebAuthnUserID` char(36) NOT NULL,
  `Counter` bigint NOT NULL,
  `DeviceType` varchar(32) DEFAULT NULL,
  `BackedUp` tinyint(1) NOT NULL,
  `Transports` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `credentials__web_authn_user_i_d__user_id` (`WebAuthnUserID`,`UserID`),
  KEY `UserID` (`UserID`),
  KEY `idx_webauthn_user_id` (`WebAuthnUserID`),
  CONSTRAINT `Credentials_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Credentials`
--

LOCK TABLES `Credentials` WRITE;
/*!40000 ALTER TABLE `Credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `Credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `OrganisationID` int unsigned DEFAULT NULL,
  `ShortName` varchar(50) NOT NULL,
  `LongName` text NOT NULL,
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
  `WalkingExPromptText` varchar(250) DEFAULT NULL,
  `NotificationDialogPromptText` varchar(130) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `OrganisationID` (`OrganisationID`),
  CONSTRAINT `Department_ibfk_1` FOREIGN KEY (`OrganisationID`) REFERENCES `Organisation` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Exercise`
--

DROP TABLE IF EXISTS `Exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Exercise` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) NOT NULL,
  `Caption` varchar(50) NOT NULL,
  `Image` blob,
  `VideoURL` text,
  `Duration` datetime DEFAULT NULL,
  `Status` enum('A','I','D') DEFAULT NULL,
  `Kilojoules` float DEFAULT NULL,
  `CalculationType` enum('C','M','O') DEFAULT NULL,
  `ExerciseDelayID` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exercise`
--

LOCK TABLES `Exercise` WRITE;
/*!40000 ALTER TABLE `Exercise` DISABLE KEYS */;
INSERT INTO `Exercise` VALUES (1,'Cardio','Morning Jog',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExerciseDelay`
--

DROP TABLE IF EXISTS `ExerciseDelay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExerciseDelay` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int unsigned NOT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Duration` float DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `ExerciseDelay_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExerciseDelay`
--

LOCK TABLES `ExerciseDelay` WRITE;
/*!40000 ALTER TABLE `ExerciseDelay` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExerciseDelay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExerciseDepartment`
--

DROP TABLE IF EXISTS `ExerciseDepartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExerciseDepartment` (
  `ExerciseID` int unsigned NOT NULL,
  `DepartmentID` int unsigned NOT NULL,
  PRIMARY KEY (`ExerciseID`,`DepartmentID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `ExerciseDepartment_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `ExerciseDepartment_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExerciseDepartment`
--

LOCK TABLES `ExerciseDepartment` WRITE;
/*!40000 ALTER TABLE `ExerciseDepartment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExerciseDepartment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExerciseLog`
--

DROP TABLE IF EXISTS `ExerciseLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExerciseLog` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ExerciseID` int unsigned DEFAULT NULL,
  `UserID` int unsigned DEFAULT NULL,
  `Repetitions` int DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Source` enum('M','A','O') DEFAULT NULL,
  `StartDateTime` datetime DEFAULT NULL,
  `EndDateTime` datetime DEFAULT NULL,
  `StandStartDateTime` datetime DEFAULT NULL,
  `StandEndDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ExerciseID` (`ExerciseID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `ExerciseLog_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `ExerciseLog_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExerciseLog`
--

LOCK TABLES `ExerciseLog` WRITE;
/*!40000 ALTER TABLE `ExerciseLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExerciseLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExerciseLogQuestion`
--

DROP TABLE IF EXISTS `ExerciseLogQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExerciseLogQuestion` (
  `ExerciseLogID` int unsigned NOT NULL,
  `QuestionID` int unsigned NOT NULL,
  `Response` int DEFAULT NULL,
  PRIMARY KEY (`ExerciseLogID`,`QuestionID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `ExerciseLogQuestion_ibfk_1` FOREIGN KEY (`ExerciseLogID`) REFERENCES `ExerciseLog` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `ExerciseLogQuestion_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExerciseLogQuestion`
--

LOCK TABLES `ExerciseLogQuestion` WRITE;
/*!40000 ALTER TABLE `ExerciseLogQuestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExerciseLogQuestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FavouriteExercises`
--

DROP TABLE IF EXISTS `FavouriteExercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FavouriteExercises` (
  `UserID` int unsigned NOT NULL,
  `ExerciseID` int unsigned NOT NULL,
  PRIMARY KEY (`UserID`,`ExerciseID`),
  KEY `ExerciseID` (`ExerciseID`),
  CONSTRAINT `FavouriteExercises_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `FavouriteExercises_ibfk_2` FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FavouriteExercises`
--

LOCK TABLES `FavouriteExercises` WRITE;
/*!40000 ALTER TABLE `FavouriteExercises` DISABLE KEYS */;
/*!40000 ALTER TABLE `FavouriteExercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HelpfulHints`
--

DROP TABLE IF EXISTS `HelpfulHints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HelpfulHints` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Hint` text NOT NULL,
  `HintOrder` int DEFAULT NULL,
  `DepartmentID` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `HelpfulHints_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HelpfulHints`
--

LOCK TABLES `HelpfulHints` WRITE;
/*!40000 ALTER TABLE `HelpfulHints` DISABLE KEYS */;
/*!40000 ALTER TABLE `HelpfulHints` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organisation`
--

LOCK TABLES `Organisation` WRITE;
/*!40000 ALTER TABLE `Organisation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Question` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Caption` text NOT NULL,
  `Order` int DEFAULT NULL,
  `MinCaption` varchar(50) DEFAULT NULL,
  `MaxCaption` varchar(50) DEFAULT NULL,
  `Status` enum('A','I','D') DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Type` enum('MC','TEXT','RATING') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
INSERT INTO `Question` VALUES (1,'What is your favorite color?',NULL,NULL,NULL,NULL,NULL,NULL,'MC');
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registrations`
--

DROP TABLE IF EXISTS `Registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registrations` (
  `RegistrationKey` char(36) NOT NULL,
  `DepartmentID` int unsigned DEFAULT NULL,
  `Seats` int DEFAULT NULL,
  PRIMARY KEY (`RegistrationKey`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `Registrations_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registrations`
--

LOCK TABLES `Registrations` WRITE;
/*!40000 ALTER TABLE `Registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `Registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Settings`
--

DROP TABLE IF EXISTS `Settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Settings` (
  `SettingKey` varchar(250) NOT NULL,
  `SettingValue` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`SettingKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Settings`
--

LOCK TABLES `Settings` WRITE;
/*!40000 ALTER TABLE `Settings` DISABLE KEYS */;
INSERT INTO `Settings` VALUES ('Theme','Dark');
/*!40000 ALTER TABLE `Settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SurveyResponse`
--

DROP TABLE IF EXISTS `SurveyResponse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SurveyResponse` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int unsigned DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `DaysWorked` int DEFAULT NULL,
  `HoursWorked` int DEFAULT NULL,
  `PercentSitting` int DEFAULT NULL,
  `PercentStanding` int DEFAULT NULL,
  `PercentWalking` int DEFAULT NULL,
  `PercentHeavy` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `SurveyResponse_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SurveyResponse`
--

LOCK TABLES `SurveyResponse` WRITE;
/*!40000 ALTER TABLE `SurveyResponse` DISABLE KEYS */;
/*!40000 ALTER TABLE `SurveyResponse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `DepartmentID` int unsigned DEFAULT NULL,
  `GivenNames` varchar(50) NOT NULL,
  `Surname` varchar(50) NOT NULL,
  `PreferredName` varchar(50) DEFAULT NULL,
  `Username` varchar(255) NOT NULL,
  `Domain` varchar(255) DEFAULT NULL,
  `JobTitle` varchar(50) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Passkey` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` enum('M','F','O','X') DEFAULT NULL,
  `Height` int DEFAULT NULL,
  `Status` char(1) DEFAULT NULL,
  `AdminFlag` int DEFAULT NULL,
  `ExitEnabled` tinyint(1) DEFAULT NULL,
  `IsNew` tinyint(1) DEFAULT NULL,
  `CalorieGoal` int DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserEvents`
--

DROP TABLE IF EXISTS `UserEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserEvents` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int unsigned DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `EventType` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserEvents_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserEvents`
--

LOCK TABLES `UserEvents` WRITE;
/*!40000 ALTER TABLE `UserEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserPosition`
--

DROP TABLE IF EXISTS `UserPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPosition` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int unsigned DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserPosition_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPosition`
--

LOCK TABLES `UserPosition` WRITE;
/*!40000 ALTER TABLE `UserPosition` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserPosition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserWeight`
--

DROP TABLE IF EXISTS `UserWeight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserWeight` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int unsigned DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserWeight_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserWeight`
--

LOCK TABLES `UserWeight` WRITE;
/*!40000 ALTER TABLE `UserWeight` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserWeight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userWeight`
--

DROP TABLE IF EXISTS `userWeight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userWeight` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userWeight`
--

LOCK TABLES `userWeight` WRITE;
/*!40000 ALTER TABLE `userWeight` DISABLE KEYS */;
INSERT INTO `userWeight` VALUES (1,'1','2024-07-31 14:00:00',222);
/*!40000 ALTER TABLE `userWeight` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-08 14:59:18
