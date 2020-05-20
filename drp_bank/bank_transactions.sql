CREATE TABLE `bank_transactions` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`charactername` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`type` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`types` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`amount` INT(11) NULL DEFAULT NULL,
	`time` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	`char_id` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `char_id` (`char_id`) USING BTREE,
	CONSTRAINT `FK_Bank_Transaction_Log` FOREIGN KEY (`char_id`) REFERENCES `drp`.`characters` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
