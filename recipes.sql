-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2024 at 03:47 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recipes`
--

-- --------------------------------------------------------

--
-- Table structure for table `dietarypreferences`
--

CREATE TABLE `dietarypreferences` (
  `PreferenceID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `IngredientID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Category` varchar(255) DEFAULT 'Unspecified',
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recipeid`
--

CREATE TABLE `recipeid` (
  `RecipeID` int(11) NOT NULL,
  `IngredientID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT 0,
  `Unit` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `RecipeID` int(11) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Instructions` varchar(255) DEFAULT NULL,
  `Image` varchar(255) NOT NULL,
  `CreatedByUserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `StoreID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `URL` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userdietarypreference`
--

CREATE TABLE `userdietarypreference` (
  `UserID` int(11) NOT NULL,
  `PreferenceID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userfavorites`
--

CREATE TABLE `userfavorites` (
  `UserID` int(11) NOT NULL,
  `RecipeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(128) DEFAULT NULL,
  `Email` varchar(100) DEFAULT 'noemail@example.com',
  `Password` varchar(100) NOT NULL,
  `Profile_Picture` varchar(128) NOT NULL,
  `Registration_Date` date NOT NULL,
  `Level` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dietarypreferences`
--
ALTER TABLE `dietarypreferences`
  ADD PRIMARY KEY (`PreferenceID`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`IngredientID`);

--
-- Indexes for table `recipeid`
--
ALTER TABLE `recipeid`
  ADD PRIMARY KEY (`RecipeID`,`IngredientID`),
  ADD KEY `IngredientID` (`IngredientID`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`RecipeID`),
  ADD KEY `CreatedByUserID` (`CreatedByUserID`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`StoreID`);

--
-- Indexes for table `userdietarypreference`
--
ALTER TABLE `userdietarypreference`
  ADD PRIMARY KEY (`UserID`,`PreferenceID`),
  ADD KEY `PreferenceID` (`PreferenceID`);

--
-- Indexes for table `userfavorites`
--
ALTER TABLE `userfavorites`
  ADD PRIMARY KEY (`UserID`,`RecipeID`),
  ADD KEY `RecipeID` (`RecipeID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipeid`
--
ALTER TABLE `recipeid`
  ADD CONSTRAINT `recipeid_ibfk_1` FOREIGN KEY (`RecipeID`) REFERENCES `recipes` (`RecipeID`),
  ADD CONSTRAINT `recipeid_ibfk_2` FOREIGN KEY (`IngredientID`) REFERENCES `ingredients` (`IngredientID`);

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`CreatedByUserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `userdietarypreference`
--
ALTER TABLE `userdietarypreference`
  ADD CONSTRAINT `userdietarypreference_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `userdietarypreference_ibfk_2` FOREIGN KEY (`PreferenceID`) REFERENCES `dietarypreferences` (`PreferenceID`);

--
-- Constraints for table `userfavorites`
--
ALTER TABLE `userfavorites`
  ADD CONSTRAINT `userfavorites_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `userfavorites_ibfk_2` FOREIGN KEY (`RecipeID`) REFERENCES `recipes` (`RecipeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
