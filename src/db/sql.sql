CREATE TABLE `Department` (
  `ID` CHAR(36) PRIMARY KEY,
  `OrganisationID` CHAR(36),
  `ShortName` VARCHAR(50) NOT NULL,
  `LongName` TEXT NOT NULL,
  `IdleDefinition` INT,
  `IdleTime` INT,
  `NoIdleTime` INT,
  `MinimumTime` INT,
  `DefaultDelayInterval` INT,
  `CalorieGoal` INT,
  `CountdownDuration` INT,
  `WalkingExDelay` INT,
  `WalkingExID` CHAR(36),
  `ExitEnabled` BOOLEAN,
  `WalkingExPromptText` VARCHAR(250),
  `NotificationDialogPromptText` VARCHAR(130)
);

CREATE TABLE `Organisation` (
  `ID` CHAR(36) PRIMARY KEY,
  `ShortName` VARCHAR(50) NOT NULL,
  `LongName` TEXT NOT NULL,
  `CountdownDuration` INT,
  `WalkingExDelay` INT
);

CREATE TABLE `User` (
  `ID` CHAR(36) PRIMARY KEY NOT NULL,
  `DepartmentID` CHAR(36),
  `GivenNames` VARCHAR(50) NOT NULL,
  `Surname` VARCHAR(50) NOT NULL,
  `PreferredName` VARCHAR(50),
  `Username` VARCHAR(255) NOT NULL,
  `Domain` VARCHAR(255),
  `JobTitle` VARCHAR(50),
  `Email` VARCHAR(255),
  `Password` VARCHAR(255),
  `Passkey` VARCHAR(255),
  `DOB` DATE,
  `Gender` ENUM ('M', 'F', 'O', 'X'),
  `Height` INT,
  `Status` CHAR(1),
  `AdminFlag` BOOLEAN,
  `ExitEnabled` BOOLEAN,
  `IsNew` BOOLEAN,
  `CalorieGoal` INT,
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE `Credentials` (
  `ID` CHAR(36) PRIMARY KEY NOT NULL,
  `UserId` CHAR(36) NOT NULL,
  `PublicKey` BLOB NOT NULL,
  `WebAuthnUserID` CHAR(36) NOT NULL,
  `Counter` BIGINT NOT NULL,
  `DeviceType` VARCHAR(32),
  `BackedUp` BOOLEAN NOT NULL,
  `Transports` VARCHAR(255)
);

CREATE TABLE `Exercise` (
  `ID` CHAR(36) PRIMARY KEY,
  `Type` VARCHAR(50) NOT NULL,
  `Caption` VARCHAR(50) NOT NULL,
  `Image` BLOB,
  `VideoURL` TEXT,
  `Duration` DATETIME,
  `Status` ENUM ('A', 'I', 'D'),
  `Kilojoules` FLOAT,
  `CalculationType` ENUM ('C', 'M', 'O'),
  `ExerciseDelayID` CHAR(36)
);

CREATE TABLE `ExerciseDelay` (
  `ID` CHAR(36) PRIMARY KEY,
  `UserID` CHAR(36),
  `DateTime` DATETIME,
  `Duration` FLOAT
);

CREATE TABLE `ExerciseDepartment` (
  `ExerciseID` CHAR(36),
  `DepartmentID` CHAR(36),
  PRIMARY KEY (`ExerciseID`, `DepartmentID`)
);

CREATE TABLE `ExerciseLog` (
  `ID` CHAR(36) PRIMARY KEY,
  `ExerciseID` CHAR(36),
  `UserID` CHAR(36),
  `Repetitions` INT,
  `Duration` INT,
  `Source` ENUM ('M', 'A', 'O'),
  `StartDateTime` DATETIME,
  `EndDateTime` DATETIME,
  `StandStartDateTime` DATETIME,
  `StandEndDateTime` DATETIME
);

CREATE TABLE `ExerciseLogQuestion` (
  `ExerciseLogID` CHAR(36),
  `QuestionID` CHAR(36),
  `Response` INT,
  PRIMARY KEY (`ExerciseLogID`, `QuestionID`)
);

CREATE TABLE `FavouriteExercises` (
  `UserID` CHAR(36),
  `ExerciseID` CHAR(36),
  PRIMARY KEY (`UserID`, `ExerciseID`)
);

CREATE TABLE `HelpfulHints` (
  `ID` INT PRIMARY KEY AUTO_INCREMENT,
  `Hint` TEXT NOT NULL,
  `HintOrder` INT,
  `DepartmentID` CHAR(36)
);

CREATE TABLE `Question` (
  `ID` CHAR(36) PRIMARY KEY NOT NULL,
  `Caption` TEXT NOT NULL,
  `Order` INT,
  `MinCaption` VARCHAR(50),
  `MaxCaption` VARCHAR(50),
  `Status` ENUM ('A', 'I', 'D'),
  `StartTime` DATETIME,
  `EndTime` DATETIME,
  `Type` ENUM ('MC', 'TEXT', 'RATING')
);

CREATE TABLE `Registrations` (
  `RegistrationKey` CHAR(36) PRIMARY KEY NOT NULL,
  `DepartmentID` CHAR(36),
  `Seats` INT
);

CREATE TABLE `Settings` (
  `SettingKey` VARCHAR(250) PRIMARY KEY NOT NULL,
  `SettingValue` VARCHAR(250)
);

CREATE TABLE `SurveyResponse` (
  `ID` INT PRIMARY KEY AUTO_INCREMENT,
  `UserID` CHAR(36),
  `Date` DATE,
  `DaysWorked` INT,
  `HoursWorked` INT,
  `PercentSitting` INT,
  `PercentStanding` INT,
  `PercentWalking` INT,
  `PercentHeavy` INT
);

CREATE TABLE `UserEvents` (
  `ID` INT PRIMARY KEY AUTO_INCREMENT,
  `UserID` CHAR(36),
  `Date` DATE,
  `EventType` INT
);

CREATE TABLE `UserPosition` (
  `ID` CHAR(36) PRIMARY KEY NOT NULL,
  `UserID` CHAR(36),
  `Date` DATETIME,
  `Position` VARCHAR(100)
);

CREATE TABLE `UserWeight` (
  `ID` CHAR(36) PRIMARY KEY NOT NULL,
  `UserID` CHAR(36),
  `Date` DATETIME,
  `Weight` INT
);

CREATE INDEX `idx_webauthn_user_id` ON `Credentials` (`WebAuthnUserID`);

CREATE UNIQUE INDEX `Credentials_index_1` ON `Credentials` (`WebAuthnUserID`, `UserId`);

ALTER TABLE `Department` ADD FOREIGN KEY (`OrganisationID`) REFERENCES `Organisation` (`ID`);

ALTER TABLE `User` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`);

ALTER TABLE `Credentials` ADD FOREIGN KEY (`UserId`) REFERENCES `User` (`ID`);

ALTER TABLE `ExerciseDelay` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);

ALTER TABLE `ExerciseDepartment` ADD FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`ID`);

ALTER TABLE `ExerciseDepartment` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`);

ALTER TABLE `ExerciseLog` ADD FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`ID`);

ALTER TABLE `ExerciseLog` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);

ALTER TABLE `ExerciseLogQuestion` ADD FOREIGN KEY (`ExerciseLogID`) REFERENCES `ExerciseLog` (`ID`);

ALTER TABLE `ExerciseLogQuestion` ADD FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`ID`);

ALTER TABLE `FavouriteExercises` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);

ALTER TABLE `FavouriteExercises` ADD FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`ID`);

ALTER TABLE `HelpfulHints` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`);

ALTER TABLE `Registrations` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`ID`);

ALTER TABLE `SurveyResponse` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);

ALTER TABLE `UserEvents` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);

ALTER TABLE `UserPosition` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);

ALTER TABLE `UserWeight` ADD FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`);
