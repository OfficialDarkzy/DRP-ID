-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table drp.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `dob` varchar(50) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `cash` bigint(20) NOT NULL,
  `bank` bigint(20) NOT NULL,
  `dirtyCash` bigint(20) NOT NULL,
  `paycheck` bigint(11) NOT NULL DEFAULT '0',
  `licenses` text NOT NULL,
  `phonenumber` mediumint(11) DEFAULT NULL,
  `job` varchar(50) NOT NULL DEFAULT 'UNEMPLOYED',
  `isDead` int(11) NOT NULL DEFAULT '0',
  `lastLocation` varchar(255) DEFAULT '{433.42, -628.88, 28.72}',
  `playerid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`playerid`) USING BTREE,
  CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`playerid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
