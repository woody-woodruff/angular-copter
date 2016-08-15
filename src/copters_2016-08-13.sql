# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 192.168.1.35 (MySQL 5.5.44-0+deb8u1-log)
# Database: copters
# Generation Time: 2016-08-13 22:35:56 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `comment_table` varchar(128) DEFAULT NULL,
  `comment_text` text,
  `comment_last_upd` int(11) DEFAULT NULL,
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`comment_table`, `comment_text`, `comment_last_upd`, `comment_id`)
VALUES
	('flight_report','Test flight. Nothing interesting.',NULL,1),
	('surgery','Change body. Replace lost LED & Cover. Fell from tree.',NULL,2),
	('surgery','Replace cable cover.',NULL,3),
	('surgery','Put your comment about this repair here.',NULL,10),
	('surgery','Put your comment about this repair here.',NULL,11),
	('surgery','Put your comment about this repair here.',NULL,12),
	('surgery','Put your comment about this repair here.',NULL,13),
	('surgery','Put your comment about this repair here.',NULL,14),
	('flight_report','This is a test, let\'s see what happens.',NULL,50),
	('flight_report','Flight Report Details here.',NULL,51),
	('flight_report','Flight Report Details here.',NULL,52),
	('flight_report','Flight Report Details here.',NULL,53),
	('flight_report','Flight Report Details here.',NULL,54),
	('flight_report','Flight Report Details here.',NULL,55),
	('surgery','First try.',NULL,56),
	('surgery','This is a try.',NULL,57),
	('surgery','This is a try.',NULL,58),
	('flight_report','This is a try',NULL,59),
	('flight_report','Flight Report Details here.',NULL,60);

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table copter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `copter`;

CREATE TABLE `copter` (
  `copter_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mfg_id` int(11) unsigned NOT NULL DEFAULT '0',
  `make_id` int(11) unsigned NOT NULL DEFAULT '0',
  `model_id` int(11) unsigned NOT NULL DEFAULT '0',
  `name_id` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_id` int(11) DEFAULT NULL,
  `copter_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`copter_id`),
  KEY `mfg_id` (`mfg_id`),
  KEY `make_id` (`make_id`),
  KEY `model_id` (`model_id`),
  KEY `name_id` (`name_id`),
  CONSTRAINT `copter_ibfk_1` FOREIGN KEY (`mfg_id`) REFERENCES `mfg` (`mfg_id`) ON UPDATE CASCADE,
  CONSTRAINT `copter_ibfk_2` FOREIGN KEY (`make_id`) REFERENCES `make` (`make_id`) ON UPDATE CASCADE,
  CONSTRAINT `copter_ibfk_3` FOREIGN KEY (`model_id`) REFERENCES `model` (`model_id`) ON UPDATE CASCADE,
  CONSTRAINT `copter_ibfk_4` FOREIGN KEY (`name_id`) REFERENCES `name` (`name_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `copter` WRITE;
/*!40000 ALTER TABLE `copter` DISABLE KEYS */;

INSERT INTO `copter` (`copter_id`, `mfg_id`, `make_id`, `model_id`, `name_id`, `comment_id`, `copter_last_upd`)
VALUES
	(1,1,1,1,1,NULL,'0000-00-00 00:00:00'),
	(2,1,1,2,2,NULL,'0000-00-00 00:00:00'),
	(3,1,1,3,3,NULL,'2016-08-02 23:04:42'),
	(4,2,2,4,4,NULL,'2016-08-09 13:50:11'),
	(5,0,4,5,5,NULL,'0000-00-00 00:00:00'),
	(6,1,1,6,6,NULL,'0000-00-00 00:00:00'),
	(7,0,5,7,7,NULL,'2016-08-09 12:53:22'),
	(8,3,3,8,8,NULL,'0000-00-00 00:00:00'),
	(10,0,0,0,0,NULL,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `copter` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flight_report
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flight_report`;

CREATE TABLE `flight_report` (
  `flight_report_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `copter_id` int(11) unsigned NOT NULL,
  `flight_report_date` datetime DEFAULT NULL,
  `rating` tinyint(2) unsigned DEFAULT NULL,
  `wind_dir` smallint(3) unsigned DEFAULT NULL,
  `wind_spd` smallint(3) unsigned DEFAULT NULL,
  `temp_f` smallint(3) DEFAULT NULL,
  `typ_weather_id` tinyint(4) unsigned DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `flight_report_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`flight_report_id`),
  KEY `copter_id` (`copter_id`),
  KEY `typ_weather_id` (`typ_weather_id`),
  KEY `wind_dir` (`wind_dir`),
  KEY `flight_report_date` (`flight_report_date`),
  KEY `rating` (`rating`),
  KEY `wind_spd` (`wind_spd`),
  KEY `temp_f` (`temp_f`),
  CONSTRAINT `flight_report_ibfk_1` FOREIGN KEY (`copter_id`) REFERENCES `copter` (`copter_id`) ON UPDATE CASCADE,
  CONSTRAINT `flight_report_ibfk_2` FOREIGN KEY (`typ_weather_id`) REFERENCES `typ_weather` (`typ_weather_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `flight_report` WRITE;
/*!40000 ALTER TABLE `flight_report` DISABLE KEYS */;

INSERT INTO `flight_report` (`flight_report_id`, `copter_id`, `flight_report_date`, `rating`, `wind_dir`, `wind_spd`, `temp_f`, `typ_weather_id`, `comment_id`, `flight_report_last_upd`)
VALUES
	(1,1,'2016-07-28 17:00:00',1,129,5,82,6,1,'2016-08-12 19:55:49'),
	(26,1,'2016-08-13 04:00:00',5,222,45,72,1,50,'0000-00-00 00:00:00'),
	(27,1,'2014-12-31 05:00:00',5,134,22,93,1,51,'0000-00-00 00:00:00'),
	(28,1,'2014-12-31 05:00:00',5,10,5,72,9,52,'0000-00-00 00:00:00'),
	(29,1,'2014-12-31 05:00:00',5,10,5,72,2,53,'0000-00-00 00:00:00'),
	(30,1,'2014-12-31 05:00:00',5,10,5,72,2,54,'0000-00-00 00:00:00'),
	(31,1,'2014-12-31 05:00:00',5,10,5,72,4,55,'0000-00-00 00:00:00'),
	(32,10,'2016-08-14 04:00:00',NULL,340,22,72,1,59,'0000-00-00 00:00:00'),
	(33,10,'2014-12-31 05:00:00',5,300,18,72,2,60,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `flight_report` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`woody_remote`@`%` */ /*!50003 TRIGGER `fr_comment` AFTER DELETE ON `flight_report` FOR EACH ROW begin
	delete from comment where comment.comment_id = OLD.comment_id;
end */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table make
# ------------------------------------------------------------

DROP TABLE IF EXISTS `make`;

CREATE TABLE `make` (
  `make_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `make_name` varchar(255) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `make_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`make_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `make` WRITE;
/*!40000 ALTER TABLE `make` DISABLE KEYS */;

INSERT INTO `make` (`make_id`, `make_name`, `comment_id`, `make_last_upd`)
VALUES
	(0,'unspecified',NULL,'0000-00-00 00:00:00'),
	(1,'Blade',NULL,'0000-00-00 00:00:00'),
	(2,'Dromida',NULL,'0000-00-00 00:00:00'),
	(3,'Generic 4 axle Kit Arf + Kk + A2212 Motor + Esc + Tarot Sk450 Frame+cf Pros+6ch Tx Rx',NULL,'0000-00-00 00:00:00'),
	(4,'GoolRC',NULL,'0000-00-00 00:00:00'),
	(5,'KiiToys',NULL,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `make` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mfg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mfg`;

CREATE TABLE `mfg` (
  `mfg_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mfg_name` varchar(255) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `mfg_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mfg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `mfg` WRITE;
/*!40000 ALTER TABLE `mfg` DISABLE KEYS */;

INSERT INTO `mfg` (`mfg_id`, `mfg_name`, `comment_id`, `mfg_last_upd`)
VALUES
	(0,'unspecified',NULL,'0000-00-00 00:00:00'),
	(1,'Horizon Hobby',NULL,'0000-00-00 00:00:00'),
	(2,'Hobbico, Inc.',NULL,'0000-00-00 00:00:00'),
	(3,'Kit',NULL,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `mfg` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table model
# ------------------------------------------------------------

DROP TABLE IF EXISTS `model`;

CREATE TABLE `model` (
  `model_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `model_name` varchar(255) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `model_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `model` WRITE;
/*!40000 ALTER TABLE `model` DISABLE KEYS */;

INSERT INTO `model` (`model_id`, `model_name`, `comment_id`, `model_last_upd`)
VALUES
	(0,'unspecified',NULL,'0000-00-00 00:00:00'),
	(1,'Chroma',NULL,'0000-00-00 00:00:00'),
	(2,'350QX',NULL,'0000-00-00 00:00:00'),
	(3,'200QX',NULL,'0000-00-00 00:00:00'),
	(4,'Ominus FPV',NULL,'0000-00-00 00:00:00'),
	(5,'HT F803C',NULL,'0000-00-00 00:00:00'),
	(6,'Inductrix',NULL,'0000-00-00 00:00:00'),
	(7,'X-10 Mini',NULL,'0000-00-00 00:00:00'),
	(8,'ZJchao Tarot Iron Man 650 Carbon Fiber 4 Axis Aircraft Fully Folding Quadcopter Frame Kit Tl65b01',NULL,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `model` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table name
# ------------------------------------------------------------

DROP TABLE IF EXISTS `name`;

CREATE TABLE `name` (
  `name_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name_name` varchar(255) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `name_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`name_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `name` WRITE;
/*!40000 ALTER TABLE `name` DISABLE KEYS */;

INSERT INTO `name` (`name_id`, `name_name`, `comment_id`, `name_last_upd`)
VALUES
	(0,'unspecified',NULL,'0000-00-00 00:00:00'),
	(1,'Kestral',NULL,'0000-00-00 00:00:00'),
	(2,'Leif O/yenstikker',NULL,'2016-07-31 20:54:06'),
	(3,'Aerial',NULL,'0000-00-00 00:00:00'),
	(4,'Flying Frog',NULL,'0000-00-00 00:00:00'),
	(5,'Green Midge',NULL,'0000-00-00 00:00:00'),
	(6,'Inductrix',NULL,'0000-00-00 00:00:00'),
	(7,'First Green',NULL,'0000-00-00 00:00:00'),
	(8,'Kit',NULL,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `name` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table surgery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `surgery`;

CREATE TABLE `surgery` (
  `surgery_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `copter_id` int(11) unsigned NOT NULL DEFAULT '0',
  `surgery_date` datetime DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `surgery_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`surgery_id`),
  KEY `copter_id` (`copter_id`),
  KEY `surgery_date` (`surgery_date`),
  CONSTRAINT `surgery_ibfk_1` FOREIGN KEY (`copter_id`) REFERENCES `copter` (`copter_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `surgery` WRITE;
/*!40000 ALTER TABLE `surgery` DISABLE KEYS */;

INSERT INTO `surgery` (`surgery_id`, `copter_id`, `surgery_date`, `comment_id`, `surgery_last_upd`)
VALUES
	(1,2,'2016-07-29 00:00:00',2,'2016-07-31 21:36:38'),
	(2,1,'2016-07-28 19:19:00',3,'2016-07-31 21:36:40'),
	(28,8,'2014-12-31 05:00:00',10,'0000-00-00 00:00:00'),
	(29,8,'2014-12-31 05:00:00',11,'0000-00-00 00:00:00'),
	(30,8,'2014-12-31 05:00:00',12,'0000-00-00 00:00:00'),
	(31,8,'2014-12-31 05:00:00',13,'0000-00-00 00:00:00'),
	(32,8,'2014-12-31 05:00:00',14,'0000-00-00 00:00:00'),
	(33,10,'2014-12-31 05:00:00',56,'0000-00-00 00:00:00'),
	(34,10,'2016-08-14 04:00:00',57,'0000-00-00 00:00:00'),
	(35,10,'2016-08-14 04:00:00',58,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `surgery` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`woody_remote`@`%` */ /*!50003 TRIGGER `Clear_surgory_comments` AFTER DELETE ON `surgery` FOR EACH ROW begin
	delete from comment where comment.comment_id = OLD.comment_id;
end */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table typ_surgery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `typ_surgery`;

CREATE TABLE `typ_surgery` (
  `typ_surgery_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typ_surgery_desc` varchar(255) NOT NULL DEFAULT '',
  `typ_surgery_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`typ_surgery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `typ_surgery` WRITE;
/*!40000 ALTER TABLE `typ_surgery` DISABLE KEYS */;

INSERT INTO `typ_surgery` (`typ_surgery_id`, `typ_surgery_desc`, `typ_surgery_last_upd`)
VALUES
	(1,'Replace Body','0000-00-00 00:00:00'),
	(2,'surgery Body','0000-00-00 00:00:00'),
	(3,'Repalce Motor','0000-00-00 00:00:00'),
	(4,'Replace ESC','0000-00-00 00:00:00'),
	(5,'Replace LED','0000-00-00 00:00:00'),
	(6,'Replace GPS','0000-00-00 00:00:00'),
	(7,'surgery GPS','0000-00-00 00:00:00'),
	(8,'Replace Control Board','0000-00-00 00:00:00'),
	(9,'Replace Radio','0000-00-00 00:00:00'),
	(10,'surgery Landing Gear','0000-00-00 00:00:00'),
	(11,'Replace Landing Gear','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `typ_surgery` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table typ_weather
# ------------------------------------------------------------

DROP TABLE IF EXISTS `typ_weather`;

CREATE TABLE `typ_weather` (
  `typ_weather_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `typ_weather_desc` varchar(255) NOT NULL DEFAULT '',
  `typ_weather_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`typ_weather_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `typ_weather` WRITE;
/*!40000 ALTER TABLE `typ_weather` DISABLE KEYS */;

INSERT INTO `typ_weather` (`typ_weather_id`, `typ_weather_desc`, `typ_weather_last_upd`)
VALUES
	(1,'Clear','0000-00-00 00:00:00'),
	(2,'Partly Cloudy','0000-00-00 00:00:00'),
	(3,'Mostly Cloudy','0000-00-00 00:00:00'),
	(4,'Broken Clouds','0000-00-00 00:00:00'),
	(5,'Overcast','0000-00-00 00:00:00'),
	(6,'Rain','0000-00-00 00:00:00'),
	(7,'Snow','0000-00-00 00:00:00'),
	(8,'Thunder storm','0000-00-00 00:00:00'),
	(9,'Blizzard','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `typ_weather` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table view_copter
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_copter`;

CREATE TABLE `view_copter` (
   `c_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `c_name` VARCHAR(255) NULL DEFAULT NULL,
   `c_make` VARCHAR(255) NULL DEFAULT NULL,
   `c_model` VARCHAR(255) NULL DEFAULT NULL,
   `c_mfg` VARCHAR(255) NULL DEFAULT NULL,
   `surgery_count` BIGINT(21) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table view_copter_master
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_copter_master`;

CREATE TABLE `view_copter_master` (
   `ml_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `ml_name` VARCHAR(255) NULL DEFAULT NULL,
   `ml_make` VARCHAR(255) NULL DEFAULT NULL,
   `ml_model` VARCHAR(255) NULL DEFAULT NULL,
   `ml_mfg` VARCHAR(255) NULL DEFAULT NULL,
   `ml_name_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `ml_make_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `ml_model_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `ml_mfg_id` INT(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_flight_report
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_flight_report`;

CREATE TABLE `view_flight_report` (
   `flight_report_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `copter_id` INT(11) UNSIGNED NOT NULL,
   `flight_report_date` DATETIME NULL DEFAULT NULL,
   `rating` TINYINT(2) UNSIGNED NULL DEFAULT NULL,
   `wind_dir` SMALLINT(3) UNSIGNED NULL DEFAULT NULL,
   `wind_spd` SMALLINT(3) UNSIGNED NULL DEFAULT NULL,
   `temp_f` SMALLINT(3) NULL DEFAULT NULL,
   `typ_weather_id` TINYINT(4) UNSIGNED NULL DEFAULT NULL,
   `comment_id` INT(11) NULL DEFAULT NULL,
   `comment_text` TEXT NULL DEFAULT NULL,
   `typ_weather_desc` VARCHAR(255) NOT NULL DEFAULT '',
   `wind_dir_list` TEXT NULL DEFAULT NULL,
   `wind_dir_prime` VARCHAR(255) NULL DEFAULT NULL,
   `wind_spd_name` VARCHAR(255) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table view_surgery
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_surgery`;

CREATE TABLE `view_surgery` (
   `comment_id` INT(10) UNSIGNED NULL DEFAULT '0',
   `comment_text` TEXT NULL DEFAULT NULL,
   `surgery_date` DATETIME NULL DEFAULT NULL,
   `name_name` VARCHAR(255) NULL DEFAULT NULL,
   `surgerys` TEXT NULL DEFAULT NULL,
   `surgery_typ_list` VARCHAR(341) NULL DEFAULT NULL,
   `copter_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `surgery_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `name_id` INT(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table wind_dir
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wind_dir`;

CREATE TABLE `wind_dir` (
  `wind_dir_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wind_dir` smallint(4) unsigned NOT NULL,
  `wind_dir_name` varchar(255) NOT NULL DEFAULT '',
  `wind_dir_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`wind_dir_id`),
  KEY `wind_dir` (`wind_dir`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `wind_dir` WRITE;
/*!40000 ALTER TABLE `wind_dir` DISABLE KEYS */;

INSERT INTO `wind_dir` (`wind_dir_id`, `wind_dir`, `wind_dir_name`, `wind_dir_last_upd`)
VALUES
	(1,0,'North','0000-00-00 00:00:00'),
	(2,90,'East','0000-00-00 00:00:00'),
	(3,180,'South','0000-00-00 00:00:00'),
	(4,270,'West','2016-07-28 15:38:00'),
	(5,45,'NE','0000-00-00 00:00:00'),
	(6,135,'SE','0000-00-00 00:00:00'),
	(7,225,'SW','2016-07-28 15:30:11'),
	(8,315,'NW','2016-07-28 15:38:38'),
	(9,0,'Tramontane','0000-00-00 00:00:00'),
	(10,45,'Gregale','0000-00-00 00:00:00'),
	(11,90,'Levante','0000-00-00 00:00:00'),
	(12,135,'Sirocco','0000-00-00 00:00:00'),
	(13,180,'Ostro','0000-00-00 00:00:00'),
	(14,225,'Libeccio','2016-07-28 15:30:14'),
	(15,270,'Ponente','2016-07-28 15:38:32'),
	(16,315,'Mistral','2016-07-28 15:38:48'),
	(17,360,'NORTH','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `wind_dir` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table wind_spd
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wind_spd`;

CREATE TABLE `wind_spd` (
  `wind_spd_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `wind_spd` smallint(3) unsigned NOT NULL,
  `wind_spd_name` varchar(255) NOT NULL DEFAULT '',
  `wind_spd_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`wind_spd_id`),
  KEY `wind_spd` (`wind_spd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `wind_spd` WRITE;
/*!40000 ALTER TABLE `wind_spd` DISABLE KEYS */;

INSERT INTO `wind_spd` (`wind_spd_id`, `wind_spd`, `wind_spd_name`, `wind_spd_last_upd`)
VALUES
	(1,0,'calm','0000-00-00 00:00:00'),
	(2,1,'light air','2016-07-28 15:43:41'),
	(3,4,'light breeze','0000-00-00 00:00:00'),
	(4,8,'gentle breeze','0000-00-00 00:00:00'),
	(5,13,'moderate breeze','0000-00-00 00:00:00'),
	(6,19,'fresh breeze','0000-00-00 00:00:00'),
	(7,25,'strong breeze','0000-00-00 00:00:00'),
	(8,32,'high wind','2016-07-28 15:46:29'),
	(9,32,'moderate gale','0000-00-00 00:00:00'),
	(10,32,'near gale','0000-00-00 00:00:00'),
	(11,39,'gale','0000-00-00 00:00:00'),
	(12,39,'fresh gale','0000-00-00 00:00:00'),
	(13,47,'strong gale','0000-00-00 00:00:00'),
	(14,55,'storm','0000-00-00 00:00:00'),
	(15,55,'whole gale','0000-00-00 00:00:00'),
	(16,64,'violent storm','0000-00-00 00:00:00'),
	(17,73,'Hurricane','0000-00-00 00:00:00'),
	(18,64,'Cat 1 Hurricane','0000-00-00 00:00:00'),
	(19,84,'Cat 2 Hurricane','0000-00-00 00:00:00'),
	(20,97,'Cat 3 Hurricane','0000-00-00 00:00:00'),
	(21,114,'Cat 4 Hurricane','0000-00-00 00:00:00'),
	(22,140,'Cat 5 Hurricane','0000-00-00 00:00:00'),
	(23,65,'F0 Tornado','0000-00-00 00:00:00'),
	(24,86,'F1 Tornado','0000-00-00 00:00:00'),
	(25,111,'F2 Tornado','0000-00-00 00:00:00'),
	(26,136,'F3 Tornado','0000-00-00 00:00:00'),
	(27,166,'F4 Tornado','0000-00-00 00:00:00'),
	(28,200,'F5 Tornado','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `wind_spd` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table x_typ_surgery_x_surgery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `x_typ_surgery_x_surgery`;

CREATE TABLE `x_typ_surgery_x_surgery` (
  `typ_surgery_id` int(11) unsigned NOT NULL,
  `surgery_id` int(11) unsigned NOT NULL,
  `x_surgery_tpye_surgery_last_upd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `typ_surgery_id` (`typ_surgery_id`),
  KEY `surgery_id` (`surgery_id`),
  CONSTRAINT `x_typ_surgery_x_surgery_ibfk_1` FOREIGN KEY (`typ_surgery_id`) REFERENCES `typ_surgery` (`typ_surgery_id`) ON UPDATE CASCADE,
  CONSTRAINT `x_typ_surgery_x_surgery_ibfk_2` FOREIGN KEY (`surgery_id`) REFERENCES `surgery` (`surgery_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `x_typ_surgery_x_surgery` WRITE;
/*!40000 ALTER TABLE `x_typ_surgery_x_surgery` DISABLE KEYS */;

INSERT INTO `x_typ_surgery_x_surgery` (`typ_surgery_id`, `surgery_id`, `x_surgery_tpye_surgery_last_upd`)
VALUES
	(1,1,'0000-00-00 00:00:00'),
	(5,1,'0000-00-00 00:00:00'),
	(11,1,'0000-00-00 00:00:00');

/*!40000 ALTER TABLE `x_typ_surgery_x_surgery` ENABLE KEYS */;
UNLOCK TABLES;




# Replace placeholder table for view_copter_master with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_copter_master`;

CREATE ALGORITHM=UNDEFINED DEFINER=`woody_remote`@`%` SQL SECURITY DEFINER VIEW `view_copter_master`
AS SELECT
   `copter`.`copter_id` AS `ml_id`,
   `name`.`name_name` AS `ml_name`,
   `make`.`make_name` AS `ml_make`,
   `model`.`model_name` AS `ml_model`,
   `mfg`.`mfg_name` AS `ml_mfg`,
   `name`.`name_id` AS `ml_name_id`,
   `make`.`make_id` AS `ml_make_id`,
   `model`.`model_id` AS `ml_model_id`,
   `mfg`.`mfg_id` AS `ml_mfg_id`
FROM ((((`copter` join `name` on((`copter`.`name_id` = `name`.`name_id`))) join `make` on((`copter`.`make_id` = `make`.`make_id`))) join `mfg` on((`copter`.`mfg_id` = `mfg`.`mfg_id`))) join `model` on((`copter`.`model_id` = `model`.`model_id`))) order by `copter`.`copter_id`;


# Replace placeholder table for view_copter with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_copter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`woody_remote`@`%` SQL SECURITY DEFINER VIEW `view_copter`
AS SELECT
   `copter`.`copter_id` AS `c_id`,
   `name`.`name_name` AS `c_name`,
   `make`.`make_name` AS `c_make`,
   `model`.`model_name` AS `c_model`,
   `mfg`.`mfg_name` AS `c_mfg`,(select count(1)
FROM `surgery` `srg` where (`srg`.`copter_id` = `copter`.`copter_id`)) AS `surgery_count` from ((((`copter` join `name` on((`copter`.`name_id` = `name`.`name_id`))) join `make` on((`copter`.`make_id` = `make`.`make_id`))) join `mfg` on((`copter`.`mfg_id` = `mfg`.`mfg_id`))) join `model` on((`copter`.`model_id` = `model`.`model_id`))) order by `copter`.`copter_id`;


# Replace placeholder table for view_flight_report with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_flight_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`woody_remote`@`%` SQL SECURITY DEFINER VIEW `view_flight_report`
AS SELECT
   `fr`.`flight_report_id` AS `flight_report_id`,
   `fr`.`copter_id` AS `copter_id`,
   `fr`.`flight_report_date` AS `flight_report_date`,
   `fr`.`rating` AS `rating`,
   `fr`.`wind_dir` AS `wind_dir`,
   `fr`.`wind_spd` AS `wind_spd`,
   `fr`.`temp_f` AS `temp_f`,
   `fr`.`typ_weather_id` AS `typ_weather_id`,
   `fr`.`comment_id` AS `comment_id`,
   `cmt`.`comment_text` AS `comment_text`,
   `tw`.`typ_weather_desc` AS `typ_weather_desc`,(select group_concat(distinct `wd`.`wind_dir_name` separator ', ')
FROM `wind_dir` `wd` where (`wd`.`wind_dir` = `fr`.`wind_dir`) limit 1) AS `wind_dir_list`,(select `wd`.`wind_dir_name` from `wind_dir` `wd` where (`wd`.`wind_dir` >= `fr`.`wind_dir`) order by `wd`.`wind_dir`,`wd`.`wind_dir_id` limit 1) AS `wind_dir_prime`,(select `wind_spd`.`wind_spd_name` from `wind_spd` where (`wind_spd`.`wind_spd` = (select max(`ws2`.`wind_spd`) from `wind_spd` `ws2` where (`ws2`.`wind_spd` <= `fr`.`wind_spd`) limit 1)) limit 1) AS `wind_spd_name` from ((`flight_report` `fr` join `typ_weather` `tw` on((`tw`.`typ_weather_id` = `fr`.`typ_weather_id`))) join `comment` `cmt` on((`fr`.`comment_id` = `cmt`.`comment_id`)));


# Replace placeholder table for view_surgery with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_surgery`;

CREATE ALGORITHM=UNDEFINED DEFINER=`woody_remote`@`%` SQL SECURITY DEFINER VIEW `view_surgery`
AS SELECT
   `com`.`comment_id` AS `comment_id`,
   `com`.`comment_text` AS `comment_text`,
   `r`.`surgery_date` AS `surgery_date`,
   `name`.`name_name` AS `name_name`,(select group_concat(distinct `rt`.`typ_surgery_desc` separator ', ')
FROM (`x_typ_surgery_x_surgery` `x` join `typ_surgery` `rt` on((`rt`.`typ_surgery_id` = `x`.`typ_surgery_id`))) where (`x`.`surgery_id` = `r`.`surgery_id`)) AS `surgerys`,(select group_concat(distinct `x`.`typ_surgery_id` separator ', ') from `x_typ_surgery_x_surgery` `x` where (`x`.`surgery_id` = `r`.`surgery_id`)) AS `surgery_typ_list`,`c`.`copter_id` AS `copter_id`,`r`.`surgery_id` AS `surgery_id`,`name`.`name_id` AS `name_id` from (((`surgery` `r` join `copter` `c` on((`r`.`copter_id` = `c`.`copter_id`))) join `name` on((`c`.`name_id` = `name`.`name_id`))) left join `comment` `com` on((`r`.`comment_id` = `com`.`comment_id`)));

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
