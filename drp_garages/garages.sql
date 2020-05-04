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

-- Dumping structure for table drp.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelLabel` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `garage_slot` tinyint(4) NOT NULL DEFAULT '0',
  `impound_slot` tinyint(4) NOT NULL DEFAULT '0',
  `fuel_level` tinyint(4) NOT NULL DEFAULT '0',
  `vehicleMods` longtext,
  `plate` varchar(50) DEFAULT NULL,
  `charactername` varchar(50) NOT NULL,
  `char_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicles_ibfk_01` (`char_id`),
  CONSTRAINT `vehicles_ibfk_01` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin2;

-- Data exporting was unselected.

-- Dumping structure for table drp.vehicle_auction
CREATE TABLE IF NOT EXISTS `vehicle_auction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellername` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `vehicleMods` longtext COLLATE utf8_bin,
  `price` int(11) DEFAULT '0',
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_vehicle_auction_characters` (`char_id`),
  CONSTRAINT `FK_vehicle_auction_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
