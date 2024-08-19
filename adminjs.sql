/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : localhost:3306
 Source Schema         : adminjs

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 13/08/2024 22:47:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for credential
-- ----------------------------
DROP TABLE IF EXISTS `credential`;
CREATE TABLE `credential`  (
  `ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UserId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PublicKey` blob NOT NULL,
  `WebAuthnUserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Counter` bigint NOT NULL,
  `DeviceType` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BackedUp` tinyint(1) NOT NULL,
  `Transports` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastUsed` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `credentials__web_authn_user_i_d__user_id`(`WebAuthnUserID` ASC, `UserId` ASC) USING BTREE,
  INDEX `idx_webauthn_user_id`(`WebAuthnUserID` ASC) USING BTREE,
  UNIQUE INDEX `credential__web_authn_user_i_d__user_id`(`WebAuthnUserID` ASC, `UserId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'For SimpleWebAuthn' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of credential
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `OrganisationID` int UNSIGNED NOT NULL,
  `PId` int UNSIGNED NULL DEFAULT 0,
  `ShortName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LongName` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IdleDefinition` int NULL DEFAULT NULL,
  `IdleTime` int NULL DEFAULT NULL,
  `NoIdleTime` int NULL DEFAULT NULL,
  `MinimumTime` int NULL DEFAULT NULL,
  `DefaultDelayInterval` int NULL DEFAULT NULL,
  `CalorieGoal` int NULL DEFAULT NULL,
  `CountdownDuration` int NULL DEFAULT NULL,
  `WalkingExDelay` int NULL DEFAULT NULL,
  `WalkingExID` int UNSIGNED NULL DEFAULT NULL,
  `ExitEnabled` tinyint(1) NULL DEFAULT NULL,
  `WalkingExPromptText` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `NotificationDialogPromptText` varchar(130) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `OrganisationID`(`OrganisationID` ASC) USING BTREE,
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`OrganisationID`) REFERENCES `organisation` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, 1, 0, 'Dept1', 'Department One', 1, 10, 20, 30, 5, 100, 60, 5, 1, 1, 'Prompt 1', 'Dialog 1');
INSERT INTO `department` VALUES (2, 2, 0, 'Dept2', 'Department Two', 2, 15, 25, 35, 10, 200, 120, 10, 2, 1, 'Prompt 2', 'Dialog 2');
INSERT INTO `department` VALUES (3, 3, 0, 'Dept3', 'Department Three', 3, 20, 30, 40, 15, 300, 180, 15, 3, 1, 'Prompt 3', 'Dialog 3');
INSERT INTO `department` VALUES (4, 4, 0, 'Dept4', 'Department Four', 4, 25, 35, 45, 20, 400, 240, 20, 4, 1, 'Prompt 4', 'Dialog 4');

-- ----------------------------
-- Table structure for exercise
-- ----------------------------
DROP TABLE IF EXISTS `exercise`;
CREATE TABLE `exercise`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Caption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` enum('A','I','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CategoryID` int NULL DEFAULT NULL,
  `Image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `VideoURL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `Duration` datetime NULL DEFAULT NULL,
  `Kilojoules` float NULL DEFAULT NULL,
  `CalculationType` enum('C','M','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ExerciseDelayID` int UNSIGNED NULL DEFAULT NULL,
  `DepartmentID` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `DepartmentID`(`DepartmentID` ASC) USING BTREE,
  CONSTRAINT `exercise_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise
-- ----------------------------
INSERT INTO `exercise` VALUES (1, 'Caption1', 'A', 'Type1', 1, 'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain', 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', '2024-08-07 05:19:28', 100, 'C', 1, 1);
INSERT INTO `exercise` VALUES (2, 'Caption2', 'I', 'Type2', 2, 'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain', 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', '2024-08-07 05:19:28', 200, 'M', 2, 2);
INSERT INTO `exercise` VALUES (3, 'Caption3', 'D', 'Type3', NULL, 'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain', 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', '2024-08-07 05:19:28', 300, 'O', 3, 3);
INSERT INTO `exercise` VALUES (4, 'Caption4', 'A', 'Type4', NULL, 'https://th.bing.com/th/id/OIP.8XLECwYGdt3DBa45yi83RAHaE8?rs=1&pid=ImgDetMain', 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4', '2024-08-07 05:19:28', 400, 'C', 4, 4);

-- ----------------------------
-- Table structure for exercise_category
-- ----------------------------
DROP TABLE IF EXISTS `exercise_category`;
CREATE TABLE `exercise_category`  (
  `ID` int NOT NULL,
  `PID` int NULL DEFAULT NULL,
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Status` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_category
-- ----------------------------
INSERT INTO `exercise_category` VALUES (1, 1, 'Sport', 1);
INSERT INTO `exercise_category` VALUES (2, 1, 'Basketball', 1);

-- ----------------------------
-- Table structure for exercise_delay
-- ----------------------------
DROP TABLE IF EXISTS `exercise_delay`;
CREATE TABLE `exercise_delay`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ExerciseID` int NOT NULL,
  `DateTime` datetime NULL DEFAULT NULL,
  `Duration` float NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `exerciseDelay_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_delay
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_department
-- ----------------------------
DROP TABLE IF EXISTS `exercise_department`;
CREATE TABLE `exercise_department`  (
  `ExerciseID` int UNSIGNED NOT NULL,
  `DepartmentID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`ExerciseID`, `DepartmentID`) USING BTREE,
  INDEX `DepartmentID`(`DepartmentID` ASC) USING BTREE,
  CONSTRAINT `ExerciseDepartment_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `exercise` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ExerciseDepartment_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_department
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_event
-- ----------------------------
DROP TABLE IF EXISTS `exercise_event`;
CREATE TABLE `exercise_event`  (
  `ID` int NOT NULL,
  `ExerciseID` int NOT NULL,
  `PlanID` int NOT NULL,
  `StartTime` time NULL DEFAULT NULL,
  `EndTime` time NULL DEFAULT NULL,
  `Duration` int NULL DEFAULT NULL,
  `Weight` int NULL DEFAULT NULL,
  `IsRepeat` tinyint NULL DEFAULT NULL COMMENT '1-yes 0-no',
  `RepeatCount` int NULL DEFAULT NULL,
  `Interval` int NULL DEFAULT NULL COMMENT 'minutes',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'For exercise plan' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_event
-- ----------------------------
INSERT INTO `exercise_event` VALUES (1, 1, 1, '08:00:00', '12:00:00', 4, 1, 1, 5, 10);
INSERT INTO `exercise_event` VALUES (2, 2, 1, '14:00:00', '16:00:00', 2, 1, 1, 2, 10);

-- ----------------------------
-- Table structure for exercise_log
-- ----------------------------
DROP TABLE IF EXISTS `exercise_log`;
CREATE TABLE `exercise_log`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ExerciseID` int UNSIGNED NOT NULL,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Repetitions` int NULL DEFAULT NULL,
  `Duration` int NULL DEFAULT NULL,
  `Source` enum('M','A','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `StartDateTime` datetime NULL DEFAULT NULL,
  `EndDateTime` datetime NULL DEFAULT NULL,
  `StandStartDateTime` datetime NULL DEFAULT NULL,
  `StandEndDateTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_log
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_log_question
-- ----------------------------
DROP TABLE IF EXISTS `exercise_log_question`;
CREATE TABLE `exercise_log_question`  (
  `ExerciseLogID` int UNSIGNED NOT NULL,
  `QuestionID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Response` int NULL DEFAULT NULL,
  PRIMARY KEY (`ExerciseLogID`, `QuestionID`) USING BTREE,
  INDEX `QuestionID`(`QuestionID` ASC) USING BTREE,
  CONSTRAINT `ExerciseLogQuestion_ibfk_1` FOREIGN KEY (`ExerciseLogID`) REFERENCES `exercise_log` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ExerciseLogQuestion_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_log_question
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_plan
-- ----------------------------
DROP TABLE IF EXISTS `exercise_plan`;
CREATE TABLE `exercise_plan`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `OrganisationID` int NULL DEFAULT NULL,
  `DepartmentID` int NULL DEFAULT NULL COMMENT 'optional',
  `Status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Frequency` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Day, WorkingDay, Weekend, Custom',
  `CustomFrequency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `StartDate` datetime NULL DEFAULT NULL,
  `EndDate` datetime NULL DEFAULT NULL,
  `Level` int NULL DEFAULT NULL,
  `Priority` int NULL DEFAULT NULL,
  `CreatedAt` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exercise_plan
-- ----------------------------
INSERT INTO `exercise_plan` VALUES (1, 'DefaultPlan', 1, NULL, 'active', NULL, 'default', 'Day', NULL, '2024-08-14 21:37:15', '2025-01-01 21:37:24', 1, 1, '2024-08-13 21:37:37');

-- ----------------------------
-- Table structure for helpful_hint
-- ----------------------------
DROP TABLE IF EXISTS `helpful_hint`;
CREATE TABLE `helpful_hint`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `HintOrder` int NULL DEFAULT NULL,
  `DepartmentID` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `DepartmentID`(`DepartmentID` ASC) USING BTREE,
  CONSTRAINT `HelpfulHints_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of helpful_hint
-- ----------------------------

-- ----------------------------
-- Table structure for organisation
-- ----------------------------
DROP TABLE IF EXISTS `organisation`;
CREATE TABLE `organisation`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LongName` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CountdownDuration` int NULL DEFAULT NULL,
  `WalkingExDelay` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of organisation
-- ----------------------------
INSERT INTO `organisation` VALUES (1, 'Default', 'Default Organization', 0, 0);
INSERT INTO `organisation` VALUES (2, 'Org2', 'Organization Two', 121, 112);
INSERT INTO `organisation` VALUES (3, 'Org3', 'Organization Three', 22, 12);
INSERT INTO `organisation` VALUES (4, 'Org4', 'Organization Four', 22, 11);

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Caption` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Order` int NULL DEFAULT NULL,
  `MinCaption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `MaxCaption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Status` enum('A','I','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `StartTime` datetime NULL DEFAULT NULL,
  `EndTime` datetime NULL DEFAULT NULL,
  `Type` enum('MC','TEXT','RATING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for survey_response
-- ----------------------------
DROP TABLE IF EXISTS `survey_response`;
CREATE TABLE `survey_response`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Date` date NULL DEFAULT NULL,
  `DaysWorked` int NULL DEFAULT NULL,
  `HoursWorked` int NULL DEFAULT NULL,
  `PercentSitting` int NULL DEFAULT NULL,
  `PercentStanding` int NULL DEFAULT NULL,
  `PercentWalking` int NULL DEFAULT NULL,
  `PercentHeavy` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `SurveyResponse_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of survey_response
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DepartmentID` int UNSIGNED NULL DEFAULT NULL,
  `GivenNames` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Surname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PreferredName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `JobTitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Passkey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DOB` date NULL DEFAULT NULL,
  `Gender` enum('M','F','O','X') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Height` int NULL DEFAULT NULL,
  `Status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `AdminFlag` int NULL DEFAULT NULL,
  `ExitEnabled` tinyint(1) NULL DEFAULT NULL,
  `IsNew` tinyint(1) NULL DEFAULT NULL,
  `CalorieGoal` int NULL DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `DepartmentID`(`DepartmentID` ASC) USING BTREE,
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 1, 'John', 'Doe', 'Johnny', 'johndoe', 'example.com', 'Engineer', 'john.doe@example.com', 'password123', 'passkey123', '1990-01-01', 'M', 180, 'A', 1, 1, 1, 2000, '2024-08-07 16:17:44', '2024-08-07 16:17:44');
INSERT INTO `user` VALUES ('2', 2, 'Jane', 'Smith', 'Janey', 'janesmith', 'example.com', 'Manager', 'jane.smith@example.com', 'password123', 'passkey123', '1985-05-05', 'F', 165, 'A', 1, 1, 1, 1800, '2024-08-07 16:17:44', '2024-08-07 16:17:44');
INSERT INTO `user` VALUES ('3', 1, 'Alice', 'Johnson', 'Ali', 'alicejohnson', 'example.com', 'Analyst', 'alice.johnson@example.com', 'password123', 'passkey123', '1992-02-02', 'F', 170, 'A', 1, 0, 1, 1900, '2024-08-07 16:17:44', '2024-08-07 17:23:26');
INSERT INTO `user` VALUES ('4', 3, 'Bob', 'Brown', 'Bobby', 'bobbrown', 'example.com', 'Developer', 'bob.brown@example.com', 'password123', 'passkey123', '1988-08-08', 'M', 175, 'A', 1, 1, 1, 1950, '2024-08-07 16:17:44', '2024-08-07 16:17:44');

-- ----------------------------
-- Table structure for user_event
-- ----------------------------
DROP TABLE IF EXISTS `user_event`;
CREATE TABLE `user_event`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Date` date NULL DEFAULT NULL,
  `EventType` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `UserEvents_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_event
-- ----------------------------

-- ----------------------------
-- Table structure for user_exercise_log
-- ----------------------------
DROP TABLE IF EXISTS `user_exercise_log`;
CREATE TABLE `user_exercise_log`  (
  `ID` int NOT NULL,
  `UserID` int NOT NULL,
  `EventID` int NULL DEFAULT NULL,
  `EventType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Organisation / Personal',
  `Status` int NULL DEFAULT NULL,
  `Duration` double NULL DEFAULT NULL,
  `CreatedAt` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_exercise_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite`;
CREATE TABLE `user_favorite`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ExerciseID` int UNSIGNED NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ExerciseID`(`ExerciseID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for user_position
-- ----------------------------
DROP TABLE IF EXISTS `user_position`;
CREATE TABLE `user_position`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Date` datetime NULL DEFAULT NULL,
  `Position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `UserPosition_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_position
-- ----------------------------

-- ----------------------------
-- Table structure for user_setting
-- ----------------------------
DROP TABLE IF EXISTS `user_setting`;
CREATE TABLE `user_setting`  (
  `ID` int NOT NULL,
  `UserID` int NULL DEFAULT NULL,
  `Content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'For store user setting like allow notification etc.' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_setting
-- ----------------------------

-- ----------------------------
-- Table structure for user_weight
-- ----------------------------
DROP TABLE IF EXISTS `user_weight`;
CREATE TABLE `user_weight`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Date` datetime NULL DEFAULT NULL,
  `Weight` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `UserWeight_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_weight
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
