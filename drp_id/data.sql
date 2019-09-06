-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for drp
CREATE DATABASE
IF NOT EXISTS `drp` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `drp`;

-- Dumping structure for table drp.characters
CREATE TABLE
IF NOT EXISTS `characters`
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `cash` bigint(20) NOT NULL DEFAULT '0',
  `bank` bigint(20) NOT NULL DEFAULT '0',
  `dirtyCash` bigint(20) NOT NULL DEFAULT '0',
  `paycheck` bigint(20) NOT NULL DEFAULT '0',
  `licenses` text NOT NULL,
  `phonenumber` mediumint(11) NOT NULL,
  `isDead` int(11) NOT NULL DEFAULT '0',
  `lastLocation` varchar(255) DEFAULT '{433.42, -628.88, 28.72}',
  `playerid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
