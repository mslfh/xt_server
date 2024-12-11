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

 Date: 29/11/2024 00:26:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for credential
-- ----------------------------
DROP TABLE IF EXISTS `credential`;
CREATE TABLE `credential`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UserId` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PublicKey` blob NOT NULL,
  `WebAuthnUserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Counter` bigint NOT NULL,
  `DeviceType` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BackedUp` tinyint(1) NOT NULL,
  `Transports` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastUsed` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `credentials__web_authn_user_i_d__user_id`(`WebAuthnUserID` ASC, `UserId` ASC) USING BTREE,
  UNIQUE INDEX `credential__web_authn_user_i_d__user_id`(`WebAuthnUserID` ASC, `UserId` ASC) USING BTREE,
  UNIQUE INDEX `credential__web_authn_user_i_d__user_i_d`(`WebAuthnUserID` ASC, `UserId` ASC) USING BTREE,
  UNIQUE INDEX `credential__web_authn_user_i_d`(`WebAuthnUserID` ASC) USING BTREE,
  INDEX `idx_webauthn_user_id`(`WebAuthnUserID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'For SimpleWebAuthn' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of credential
-- ----------------------------


-- ----------------------------
-- Table structure for organisation
-- ----------------------------
DROP TABLE IF EXISTS `organisation`;
CREATE TABLE `organisation`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LongName` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` tinyint(1) NULL DEFAULT NULL,
  `CountdownDuration` int NULL DEFAULT NULL,
  `WalkingExDelay` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of organisation
-- ----------------------------
INSERT INTO `organisation` VALUES (1, 'Default', 'Default Organization', NULL, 0, 0);


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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, 1, 0, 'Dept1', 'Department One', 1, 10, 20, 30, 5, 100, 60, 5, 1, 1, 'Prompt 1', 'Dialog 1');
INSERT INTO `department` VALUES (2, 1, 0, 'Dept2', 'Department Two', 2, 15, 25, 35, 10, 200, 120, 10, 2, 1, 'Prompt 2', 'Dialog 2');
INSERT INTO `department` VALUES (3, 1, 0, 'Dept3', 'Department Three', 3, 20, 30, 40, 15, 300, 180, 15, 3, 1, 'Prompt 3', 'Dialog 3');
INSERT INTO `department` VALUES (4, 1, 0, 'Dept4', 'Department Four', 4, 25, 35, 45, 20, 400, 240, 20, 4, 1, 'Prompt 4', 'Dialog 4');

-- ----------------------------
-- Table structure for exercise
-- ----------------------------
DROP TABLE IF EXISTS `exercise`;
CREATE TABLE `exercise`  (
  `ID` CHAR(36) NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Caption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` enum('A','I','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `VideoURL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `Duration` INTEGER NULL DEFAULT NULL,
  `Kilojoules` float NULL DEFAULT NULL,
  `CalculationType` enum('R','M') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `S3key` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Bucket` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Mime` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercise
-- ----------------------------
INSERT INTO exercise  (ID, Type, Caption, Status, Image, VideoURL, Duration, Kilojoules, CalculationType, S3key, Bucket, Mime, Comment) 
VALUES
('C4029D0F-5F6E-4D99-8447-00398CFFB86E', 'Easy', 'Biceps Curl', 'A', NULL, 'XT_Biceps Curls', 30, 0.00991443, 'M', NULL, NULL, NULL, NULL),
('C7D16CB7-99B9-4138-AE25-0772D3118E56', 'Easy', 'Double Knee Lifts', 'A', NULL, 'XT_Chair_a_Knee Lifts_26s', 0, 0.008116883, 'R', NULL, NULL, NULL, NULL),
('3C7D65AC-DF7F-47BE-90AB-080C9CA4DD50', 'Moderate', 'Push Throughs', 'A', NULL, 'XT_Chair_a_Push Throughs_27s', 0, 0.008447828, 'R', NULL, NULL, NULL, NULL),
('E5353D2F-DBEF-4C4A-B935-0A4FE6FE1FC6', 'Moderate', 'Chair Squats', 'A', NULL, 'XT_Chair_a_Squats_37s', 31, 0.01053642, 'R', NULL, NULL, NULL, NULL),
('ABF8D819-9572-4486-8B35-158CB6262255', 'Easy', 'Arm Pumps with Foot Tap', 'A', NULL, 'XT_Chair_ArmPumpswithFoot Tap22', 22, 0.00738961, 'M', NULL, NULL, NULL, NULL),
('1BBA273C-79F6-4D83-8C8B-19A5040419A8', 'Easy', 'Chair Push Ups', 'A', NULL, 'XT_Chair_ChairPushups37', 25, 0.009155844, 'R', NULL, NULL, NULL, NULL),
('756FDD13-1F45-4B0A-A585-2400D64811F8', 'Easy', 'Front Raise to Triceps Press', 'A', NULL, 'XT_Chair_FrontRaisetoTricepsPress35', 30, 0.006493506, 'R', NULL, NULL, NULL, NULL),
('0D72E8FE-F042-4189-AF25-2A98C8C69EC8', 'Easy', 'Hip Flexions', 'A', NULL, 'XT_Chair_HipFlexions37', 37, 0.00421645, 'M', NULL, NULL, NULL, NULL),
('DCEC09A3-3B7F-490A-BC55-2DB28A98703B', 'Easy', 'Hip Flexions with Knee Extensions', 'A', NULL, 'XT_Chair_HipFlexionswithKneeExtensions35', 33, 0.005329004, 'M', NULL, NULL, NULL, NULL),
('C2BDFDD9-D7B5-4670-9A89-2E414539062A', 'Easy', 'Single Leg Lifts', 'A', NULL, 'XT_Chair_LegLifts23', 35, 0.0024329, 'R', NULL, NULL, NULL, NULL),
('46AD1ECA-7D71-41D7-8678-32470555DE3F', 'Easy', 'Seated Crunch', 'A', NULL, 'XT_Chair_Seated Crunch_30s', 38, 0.00108, 'R', NULL, NULL, NULL, NULL),
('14B6F9C2-E6B0-4059-ABA8-34A5CC1C9444', 'Easy', 'Seated Knee Hugs', 'A', NULL, 'XT_Chair_SeatedKneeHugs38', 39, 0.007324675, 'R', NULL, NULL, NULL, NULL),
('67839D23-86E0-4F90-B6BB-36DEF1BAA839', 'Easy', 'Seated March', 'A', NULL, 'XT_Chair_SeatedMarch23', 0, 0.00725974, 'M', NULL, NULL, NULL, NULL),
('E3D1330A-1BC1-4A25-8EDF-3C386F623BAE', 'Moderate', 'Take a Roll', 'A', NULL, 'XT_Facility_a_Chair Walk_89s', 33, 0.008658009, 'M', NULL, NULL, NULL, NULL),
('2B71DD33-E0FB-40D6-BE82-3E7BECBDC2AB', 'Moderate', 'Stair Climb', 'A', NULL, 'XT_Facility_a_Stair Climb_50s', 46, 0.011055029, 'R', NULL, NULL, NULL, NULL),
('970E98C9-2F47-4255-9E35-3EFE890A124F', 'Moderate', 'Step Ups', 'A', NULL, 'XT_Facility_a_Step Ups_35s', 48, 0.0110367, 'R', NULL, NULL, NULL, NULL),
('B4DFEE5F-3CDA-4CA4-8066-3F96AD73DDC7', 'Easy', 'Toe Raises', 'A', NULL, 'XT_Facility_a_Toe Raises_52s', 0, 0.009964935, 'R', NULL, NULL, NULL, NULL),
('EDA1B00D-9E0A-4574-A6B3-43ED2A91E42B', 'Easy', 'Take a Hike', 'A', NULL, 'XT_Facility_a_Walk_73s', 37, 0.003008333, 'M', NULL, NULL, NULL, NULL),
('A5A17737-1C72-4C30-8D93-46E1A1079E41', 'Moderate', 'Wall Touches', 'A', NULL, 'XT_Facility_a_Wall Touches_32s', 0, 0.011814116, 'R', NULL, NULL, NULL, NULL),
('DF7AE4B9-7296-4D9F-8C8A-4E3507A8AD67', 'Moderate', 'Bear_Crawl', 'A', NULL, 'XT_Facility_Bear Crawl_30s', 50, 0.010322511, 'M', NULL, NULL, NULL, NULL),
('1F520C2A-44F1-41D4-AC5B-4F9B872C3928', 'Challenging', 'Crab Walk', 'A', NULL, 'XT_Facility_Crab Crawl_33s', 3, 0.010415152, 'M', NULL, NULL, NULL, NULL),
('1D8BBD88-CA94-4BC4-B847-5BED9A3C01DC', 'Challenging', 'Crocodile Walk', 'A', NULL, 'XT_Facility_Crocodile Crawl_37s', 30, 0.011463203, 'M', NULL, NULL, NULL, NULL),
('A31F864F-F7B8-473F-BF89-6394D8089C48', 'Challenging', 'Hop Scotch', 'A', NULL, 'XT_Facility_Hop Scotch', 37, 0.012927644, 'R', NULL, NULL, NULL, NULL),
('5CD43220-DE26-4B2B-AEB4-6498AC4A201F', 'Challenging', 'Walking Lunge', 'A', NULL, 'XT_Facility_Walking Lunge_39s', 46, 0.01164329, 'R', NULL, NULL, NULL, NULL);
-- ----------------------------
-- Table structure for exercise_category
-- ----------------------------
DROP TABLE IF EXISTS `exercise_category`;
CREATE TABLE `exercise_category`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PID` int NULL DEFAULT NULL,
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Status` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ExerciseID` int NOT NULL,
  `DateTime` datetime NULL DEFAULT NULL,
  `Duration` float NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercise_delay
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_department
-- ----------------------------
DROP TABLE IF EXISTS `exercise_department`;
CREATE TABLE `exercise_department`  (
  `ExerciseID` CHAR(36) NOT NULL,
  `DepartmentID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`ExerciseID`, `DepartmentID`) USING BTREE,
  INDEX `DepartmentID`(`DepartmentID` ASC) USING BTREE,
  CONSTRAINT `ExerciseDepartment_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `exercise` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ExerciseDepartment_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercise_department
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_event
-- ----------------------------
DROP TABLE IF EXISTS `exercise_event`;
CREATE TABLE `exercise_event`  (
  `ID` int NOT NULL AUTO_INCREMENT,
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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'For exercise plan' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercise_log
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_log_question
-- ----------------------------
DROP TABLE IF EXISTS `exercise_log_question`;
CREATE TABLE `exercise_log_question`  (
  `ExerciseLogID` int UNSIGNED NOT NULL,
  `QuestionID` int NOT NULL,
  `Response` int NULL DEFAULT NULL,
  PRIMARY KEY (`ExerciseLogID`, `QuestionID`) USING BTREE,
  INDEX `QuestionID`(`QuestionID` ASC) USING BTREE,
  CONSTRAINT `ExerciseLogQuestion_ibfk_1` FOREIGN KEY (`ExerciseLogID`) REFERENCES `exercise_log` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ExerciseLogQuestion_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercise_log_question
-- ----------------------------

-- ----------------------------
-- Table structure for exercise_plan
-- ----------------------------
DROP TABLE IF EXISTS `exercise_plan`;
CREATE TABLE `exercise_plan`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ContentType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `OrganisationID` int NULL DEFAULT NULL,
  `DepartmentID` int NULL DEFAULT NULL COMMENT 'optional',
  `Status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'active/inactive',
  `Type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Frequency` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Day, WorkingDay, Weekend, Custom',
  `CustomFrequency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Mon,Tues,......',
  `IsAllDay` tinyint(1) NULL DEFAULT NULL,
  `Intervals` int NULL DEFAULT NULL COMMENT 'minutes of interval between workout sessions',
  `StartTimeZone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `StartDateTime` datetime NULL DEFAULT NULL,
  `EndTimeZone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EndDateTime` datetime NULL DEFAULT NULL,
  `Priority` int NULL DEFAULT NULL COMMENT '0-highest',
  `Attendees` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'emailAddress for Attendees',
  `Remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CreatedAt` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercise_plan
-- ----------------------------
INSERT INTO `exercise_plan` VALUES (10, 'aaaa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '2024-10-10 06:49:14');
INSERT INTO `exercise_plan` VALUES (11, 'aaa', '111', '11', 2, 2, '1', '1', '1', '1', 1, 1, '11', '2024-10-08 13:00:00', '11', '2024-10-17 13:00:00', 1, '12', '121', '2024-10-08 13:00:00');

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `s3Key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of helpful_hint
-- ----------------------------
INSERT INTO `helpful_hint` VALUES (1, 'hello', 1, 1);

-- ----------------------------
-- Table structure for microsoft_account
-- ----------------------------
DROP TABLE IF EXISTS `microsoft_account`;
CREATE TABLE `microsoft_account`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `microsoftEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `oid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sub` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `isLinked` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `microsoft_account_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of microsoft_account
-- ----------------------------
INSERT INTO `microsoft_account` VALUES (1, '84abfbef-68d2-4e5a-bc0b-c6072b9b3e47', 'admin@outlook.com', '11222111', '12121212', 1);

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Caption` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Order` int NULL DEFAULT NULL,
  `MinCaption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `MaxCaption` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Status` enum('A','I','D') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `StartTime` datetime NULL DEFAULT NULL,
  `EndTime` datetime NULL DEFAULT NULL,
  `Type` enum('MC','TEXT','RATING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for registration
-- ----------------------------
DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration`  (
  `RegistrationKey` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DepartmentID` int UNSIGNED NULL DEFAULT NULL,
  `Seats` int NULL DEFAULT NULL,
  PRIMARY KEY (`RegistrationKey`) USING BTREE,
  INDEX `DepartmentID`(`DepartmentID` ASC) USING BTREE,
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registration
-- ----------------------------

-- ----------------------------
-- Table structure for reports
-- ----------------------------
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date` datetime NOT NULL,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reports
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `sid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expires` datetime NULL DEFAULT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Table structure for survey_response
-- ----------------------------
DROP TABLE IF EXISTS `survey_response`;
CREATE TABLE `survey_response`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date` date NULL DEFAULT NULL,
  `DaysWorked` int NULL DEFAULT NULL,
  `HoursWorked` int NULL DEFAULT NULL,
  `PercentSitting` int NULL DEFAULT NULL,
  `PercentStanding` int NULL DEFAULT NULL,
  `PercentWalking` int NULL DEFAULT NULL,
  `PercentHeavy` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of survey_response
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `ID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DepartmentID` int UNSIGNED NULL DEFAULT NULL,
  `GivenNames` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Surname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PreferredName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `JobTitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('84abfbef-68d2-4e5a-bc0b-c6072b9b3e47', NULL, '', '', '', 'defaultadmin', '', '', 'admin@example.com', '$2a$10$GWWezmCkuprKo4./OQZgIOvV99Fl1EqDlClUdd4LxFIDXBeqMJ8om', '', NULL, 'X', NULL, 'A', 0, 0, 1, 2000, '2024-09-12 03:32:08', '2024-09-12 03:32:08');

-- ----------------------------
-- Table structure for user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite`;
CREATE TABLE `user_favorite`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ExerciseID` int UNSIGNED NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ExerciseID`(`ExerciseID` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_favorite
-- ----------------------------
INSERT INTO `user_favorite` VALUES (1, 'ff83a44e-5e1d-44cb-a02a-505ff08e1e95', 2, '2024-10-03 00:00:00');

-- ----------------------------
-- Table structure for user_position
-- ----------------------------
DROP TABLE IF EXISTS `user_position`;
CREATE TABLE `user_position`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date` datetime NULL DEFAULT NULL,
  `Position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_position
-- ----------------------------
INSERT INTO `user_position` VALUES (1, 'ff83a44e-5e1d-44cb-a02a-505ff08e1e95', '2024-10-02 14:00:00', 'aaa');

-- ----------------------------
-- Table structure for user_setting
-- ----------------------------
DROP TABLE IF EXISTS `user_setting`;
CREATE TABLE `user_setting`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'For store user setting like allow notification etc.' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_setting
-- ----------------------------

-- ----------------------------
-- Table structure for user_weight
-- ----------------------------
DROP TABLE IF EXISTS `user_weight`;
CREATE TABLE `user_weight`  (
  `ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserID` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date` datetime NULL DEFAULT NULL,
  `Weight` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_weight
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
