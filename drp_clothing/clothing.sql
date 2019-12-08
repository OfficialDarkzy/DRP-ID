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
CREATE DATABASE IF NOT EXISTS `drp` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `drp`;

-- Dumping structure for table drp.character_clothing
CREATE TABLE IF NOT EXISTS `character_clothing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_textures` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_palette` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `props_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `props_textures` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_opacity` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_colours` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_character_clothing_characters` (`char_id`),
  CONSTRAINT `FK_character_clothing_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.character_clothing: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_clothing` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_clothing` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
