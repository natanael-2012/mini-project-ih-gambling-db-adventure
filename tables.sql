CREATE TABLE `account` (
  `AccountNo` varchar(12) NOT NULL,
  `CustID` int NOT NULL,
  `AccountLocation` varchar(5) NOT NULL,
  `CurrencyCOde` varchar(5) NOT NULL,
  `DailyDepositLimit` int NOT NULL,
  `StakeScale` float NOT NULL,
  `SourceProd` varchar(32) NOT NULL,
  PRIMARY KEY (`AccountNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `betting1` (
  `AccountNo` varchar(25) NOT NULL,
  `BetDate` date NOT NULL,
  `ClassId` varchar(25) DEFAULT NULL,
  `CategoryID` int NOT NULL,
  `Source` varchar(25) NOT NULL,
  `BetCount` int NOT NULL,
  `Bet_Amt` float NOT NULL,
  `Win_Amt` float NOT NULL,
  `Product` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `betting2` (
  `AccountNo` varchar(25) NOT NULL,
  `Bet_Amt` float NOT NULL,
  `Product` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `betting_summary` (
  `AccountNo` varchar(25) NOT NULL,
  `Vegas` float NOT NULL,
  `Sportsbook` float NOT NULL,
  `Games` float NOT NULL,
  `Casino` float NOT NULL,
  `Poker` float NOT NULL,
  `Bingo` float NOT NULL,
  `N_A` float NOT NULL,
  `Adjustments` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `CustId` int NOT NULL,
  `AccountLocation` varchar(32) NOT NULL,
  `Title` varchar(32) NOT NULL,
  `FirstName` varchar(32) NOT NULL,
  `LastName` varchar(32) NOT NULL,
  `CreateDate` date NOT NULL,
  `CountryCode` varchar(32) NOT NULL,
  `Language` varchar(32) NOT NULL,
  `Status` varchar(32) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `Contact` varchar(32) NOT NULL,
  `CustomerGroup` varchar(32) NOT NULL,
  PRIMARY KEY (`CustId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product` (
  `CLASSID` varchar(32) DEFAULT NULL,
  `CATEGORYID` int NOT NULL,
  `product` varchar(32) NOT NULL,
  `sub_product` varchar(32) NOT NULL,
  `description` varchar(32) NOT NULL,
  `bet_or_play` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school` (
  `school_id` varchar(15) NOT NULL,
  `school_name` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student` (
  `student_id` varchar(15) NOT NULL,
  `student_name` varchar(32) NOT NULL,
  `city` varchar(32) NOT NULL,
  `school_id` varchar(32) NOT NULL,
  `gpa` varchar(32) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
