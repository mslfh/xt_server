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
  `ID` char(36) NOT NULL,
  `UserId` char(36) NOT NULL,
  `PublicKey` blob NOT NULL,
  `WebAuthnUserID` char(36) NOT NULL,
  `Counter` bigint NOT NULL,
  `DeviceType` varchar(32) DEFAULT NULL,
  `BackedUp` tinyint(1) NOT NULL,
  `Transports` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `WebAuthnUserID` (`WebAuthnUserID`,`UserId`),
  KEY `idx_webauthn_user_id` (`WebAuthnUserID`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `Credentials_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Credentials`
--

LOCK TABLES `Credentials` WRITE;
/*!40000 ALTER TABLE `Credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `Credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExerciseDelay`
--

DROP TABLE IF EXISTS `ExerciseDelay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExerciseDelay` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(36) NOT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Duration` float DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_ExerciseDelay_UserID` (`UserID`),
  CONSTRAINT `fk_ExerciseDelay_UserID` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  CONSTRAINT `ExerciseDepartment_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `exercises` (`ID`),
  CONSTRAINT `ExerciseDepartment_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`ID`)
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
  `UserID` char(36) DEFAULT NULL,
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
  CONSTRAINT `ExerciseLog_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `exercises` (`ID`),
  CONSTRAINT `ExerciseLog_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `QuestionID` char(36) NOT NULL,
  `Response` int DEFAULT NULL,
  PRIMARY KEY (`ExerciseLogID`,`QuestionID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `ExerciseLogQuestion_ibfk_1` FOREIGN KEY (`ExerciseLogID`) REFERENCES `ExerciseLog` (`ID`),
  CONSTRAINT `ExerciseLogQuestion_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`ID`)
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
  `UserID` char(36) NOT NULL,
  `ExerciseID` int unsigned NOT NULL,
  PRIMARY KEY (`UserID`,`ExerciseID`),
  KEY `ExerciseID` (`ExerciseID`)
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
  CONSTRAINT `HelpfulHints_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HelpfulHints`
--

LOCK TABLES `HelpfulHints` WRITE;
/*!40000 ALTER TABLE `HelpfulHints` DISABLE KEYS */;
/*!40000 ALTER TABLE `HelpfulHints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Question` (
  `ID` char(36) NOT NULL,
  `Caption` text NOT NULL,
  `Order` int DEFAULT NULL,
  `MinCaption` varchar(50) DEFAULT NULL,
  `MaxCaption` varchar(50) DEFAULT NULL,
  `Status` enum('A','I','D') DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Type` enum('MC','TEXT','RATING') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
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
  KEY `DepartmentID` (`DepartmentID`)
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
  `UserID` char(36) NOT NULL,
  `Date` date DEFAULT NULL,
  `DaysWorked` int DEFAULT NULL,
  `HoursWorked` int DEFAULT NULL,
  `PercentSitting` int DEFAULT NULL,
  `PercentStanding` int DEFAULT NULL,
  `PercentWalking` int DEFAULT NULL,
  `PercentHeavy` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `SurveyResponse_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SurveyResponse`
--

LOCK TABLES `SurveyResponse` WRITE;
/*!40000 ALTER TABLE `SurveyResponse` DISABLE KEYS */;
/*!40000 ALTER TABLE `SurveyResponse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SurveyResponses`
--

DROP TABLE IF EXISTS `SurveyResponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SurveyResponses` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `DaysWorked` int DEFAULT NULL,
  `HoursWorked` int DEFAULT NULL,
  `PercentSitting` int DEFAULT NULL,
  `PercentStanding` int DEFAULT NULL,
  `PercentWalking` int DEFAULT NULL,
  `PercentHeavy` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `SurveyResponses_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SurveyResponses`
--

LOCK TABLES `SurveyResponses` WRITE;
/*!40000 ALTER TABLE `SurveyResponses` DISABLE KEYS */;
/*!40000 ALTER TABLE `SurveyResponses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `ID` char(36) NOT NULL,
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
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('1',1,'John','Doe','Johnny','johndoe','example.com','Engineer','john.doe@example.com','password123','passkey123','1990-01-01','M',180,'A',1,1,1,2000,'2024-08-07 06:17:44','2024-08-07 06:17:44'),('2',2,'Jane','Smith','Janey','janesmith','example.com','Manager','jane.smith@example.com','password123','passkey123','1985-05-05','F',165,'A',1,1,1,1800,'2024-08-07 06:17:44','2024-08-07 06:17:44'),('3',1,'Alice','Johnson','Ali','alicejohnson','example.com','Analyst','alice.johnson@example.com','password123','passkey123','1992-02-02','F',170,'A',1,0,1,1900,'2024-08-07 06:17:44','2024-08-07 07:23:26'),('4',3,'Bob','Brown','Bobby','bobbrown','example.com','Developer','bob.brown@example.com','password123','passkey123','1988-08-08','M',175,'A',1,1,1,1950,'2024-08-07 06:17:44','2024-08-07 06:17:44');
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
  `UserID` char(36) NOT NULL,
  `Date` date DEFAULT NULL,
  `EventType` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserEvents_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `UserID` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserPosition_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPosition`
--

LOCK TABLES `UserPosition` WRITE;
/*!40000 ALTER TABLE `UserPosition` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserPosition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserPositions`
--

DROP TABLE IF EXISTS `UserPositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPositions` (
  `ID` char(36) NOT NULL,
  `UserID` char(36) NOT NULL,
  `Date` datetime NOT NULL,
  `Position` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserPositions_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPositions`
--

LOCK TABLES `UserPositions` WRITE;
/*!40000 ALTER TABLE `UserPositions` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserPositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserWeight`
--

DROP TABLE IF EXISTS `UserWeight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserWeight` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `UserWeight_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserWeight`
--

LOCK TABLES `UserWeight` WRITE;
/*!40000 ALTER TABLE `UserWeight` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserWeight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credentials` (
  `ID` char(36) NOT NULL,
  `UserId` char(36) NOT NULL,
  `PublicKey` blob NOT NULL,
  `WebAuthnUserID` char(36) NOT NULL,
  `Counter` bigint NOT NULL,
  `DeviceType` varchar(32) DEFAULT NULL,
  `BackedUp` tinyint(1) NOT NULL,
  `Transports` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `credentials__web_authn_user_i_d__user_id` (`WebAuthnUserID`,`UserId`),
  KEY `idx_webauthn_user_id` (`WebAuthnUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `OrganisationID` int unsigned NOT NULL,
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
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`OrganisationID`) REFERENCES `organisation` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,1,'Dept1','Department One',1,10,20,30,5,100,60,5,1,1,'Prompt 1','Dialog 1'),(2,2,'Dept2','Department Two',2,15,25,35,10,200,120,10,2,1,'Prompt 2','Dialog 2'),(3,3,'Dept3','Department Three',3,20,30,40,15,300,180,15,3,1,'Prompt 3','Dialog 3'),(4,4,'Dept4','Department Four',4,25,35,45,20,400,240,20,4,1,'Prompt 4','Dialog 4');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exerciseDelay`
--

DROP TABLE IF EXISTS `exerciseDelay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exerciseDelay` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(36) NOT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Duration` float DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `exerciseDelay_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exerciseDelay`
--

LOCK TABLES `exerciseDelay` WRITE;
/*!40000 ALTER TABLE `exerciseDelay` DISABLE KEYS */;
/*!40000 ALTER TABLE `exerciseDelay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exerciseDepartments`
--

DROP TABLE IF EXISTS `exerciseDepartments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exerciseDepartments` (
  `ExerciseID` int unsigned NOT NULL,
  `DepartmentID` int unsigned NOT NULL,
  PRIMARY KEY (`ExerciseID`,`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exerciseDepartments`
--

LOCK TABLES `exerciseDepartments` WRITE;
/*!40000 ALTER TABLE `exerciseDepartments` DISABLE KEYS */;
/*!40000 ALTER TABLE `exerciseDepartments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exerciseLog`
--

DROP TABLE IF EXISTS `exerciseLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exerciseLog` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ExerciseID` int unsigned NOT NULL,
  `UserID` char(36) NOT NULL,
  `Repetitions` int DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `Source` enum('M','A','O') DEFAULT NULL,
  `StartDateTime` datetime DEFAULT NULL,
  `EndDateTime` datetime DEFAULT NULL,
  `StandStartDateTime` datetime DEFAULT NULL,
  `StandEndDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exerciseLog`
--

LOCK TABLES `exerciseLog` WRITE;
/*!40000 ALTER TABLE `exerciseLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `exerciseLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exerciseLogQuestions`
--

DROP TABLE IF EXISTS `exerciseLogQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exerciseLogQuestions` (
  `ExerciseLogID` int unsigned NOT NULL,
  `QuestionID` char(36) NOT NULL,
  `Response` int DEFAULT NULL,
  PRIMARY KEY (`ExerciseLogID`,`QuestionID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `exerciseLogQuestions_ibfk_1` FOREIGN KEY (`ExerciseLogID`) REFERENCES `exerciseLog` (`ID`),
  CONSTRAINT `exerciseLogQuestions_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `questions` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exerciseLogQuestions`
--

LOCK TABLES `exerciseLogQuestions` WRITE;
/*!40000 ALTER TABLE `exerciseLogQuestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exerciseLogQuestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercises` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) NOT NULL,
  `Caption` varchar(50) NOT NULL,
  `Image` blob,
  `VideoURL` text,
  `Duration` datetime NOT NULL,
  `Status` enum('A','I','D') NOT NULL,
  `Kilojoules` float NOT NULL,
  `CalculationType` enum('C','M','O') NOT NULL,
  `ExerciseDelayID` int unsigned NOT NULL,
  `DepartmentID` int unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `exercises_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercises`
--

LOCK TABLES `exercises` WRITE;
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` VALUES (1,'Type1','Caption1',_binary 'Image1','VideoURL1','2024-08-07 05:19:28','A',100,'C',1,1),(2,'Type2','Caption2',_binary 'Image2','VideoURL2','2024-08-07 05:19:28','I',200,'M',2,2),(3,'Type3','Caption3',_binary 'Image3','VideoURL3','2024-08-07 05:19:28','D',300,'O',3,3),(4,'Type4','Caption4',_binary 'Image4','VideoURL4','2024-08-07 05:19:28','A',400,'C',4,4);
/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favouriteExercises`
--

DROP TABLE IF EXISTS `favouriteExercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favouriteExercises` (
  `UserID` char(36) NOT NULL,
  `ExerciseID` int unsigned NOT NULL,
  PRIMARY KEY (`UserID`,`ExerciseID`),
  KEY `ExerciseID` (`ExerciseID`),
  CONSTRAINT `favouriteExercises_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`),
  CONSTRAINT `favouriteExercises_ibfk_2` FOREIGN KEY (`ExerciseID`) REFERENCES `exercises` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favouriteExercises`
--

LOCK TABLES `favouriteExercises` WRITE;
/*!40000 ALTER TABLE `favouriteExercises` DISABLE KEYS */;
/*!40000 ALTER TABLE `favouriteExercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(50) NOT NULL,
  `LongName` text NOT NULL,
  `CountdownDuration` int DEFAULT NULL,
  `WalkingExDelay` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
INSERT INTO `organisation` VALUES (1,'dsaa','sdad',122,11),(2,'test','test',121,112),(3,'aaa','aaa',22,12),(4,'ddd','ff',22,11),(5,'Org1','Organization One',10,5),(6,'Org2','Organization Two',15,10),(7,'Org3','Organization Three',20,15),(8,'Org4','Organization Four',25,20);
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `ID` char(36) NOT NULL,
  `Caption` text NOT NULL,
  `Order` int DEFAULT NULL,
  `MinCaption` varchar(50) DEFAULT NULL,
  `MaxCaption` varchar(50) DEFAULT NULL,
  `Status` enum('A','I','D') DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Type` enum('MC','TEXT','RATING') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `SettingKey` varchar(250) NOT NULL,
  `SettingValue` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`SettingKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userWeights`
--

DROP TABLE IF EXISTS `userWeights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userWeights` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `UserID` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userWeights`
--

LOCK TABLES `userWeights` WRITE;
/*!40000 ALTER TABLE `userWeights` DISABLE KEYS */;
/*!40000 ALTER TABLE `userWeights` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-07 13:06:16
