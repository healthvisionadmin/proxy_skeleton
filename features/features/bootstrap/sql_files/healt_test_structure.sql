CREATE DATABASE  IF NOT EXISTS `health_test_structure` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `health_test_structure`;
-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: health_test
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `action_of_week`
--

DROP TABLE IF EXISTS `action_of_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_of_week` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `points` smallint(6) NOT NULL,
  `price` smallint(6) NOT NULL,
  `type` smallint(6) NOT NULL DEFAULT '1' COMMENT 'migth be a usecase',
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT 'canceled, pending ??',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action_of_week_locale`
--

DROP TABLE IF EXISTS `action_of_week_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_of_week_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL,
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `title` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `meta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `action_of_week_locale_fk_locale_unique` (`fk`,`locale`),
  CONSTRAINT `action_of_week_locale_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `action_of_week_locale` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `street_nr` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `zip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `province` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `locality` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '(city, village, etc)',
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `adress_extra` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `abrv` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building_address_id_foreign` (`address_id`),
  KEY `building_contact_id_foreign` (`contact_id`),
  KEY `building_location_id_foreign` (`location_id`),
  CONSTRAINT `building_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `building_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `building_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `building_resource`
--

DROP TABLE IF EXISTS `building_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id message)',
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building_resource_fk_foreign` (`fk`),
  CONSTRAINT `building_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `building` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL COMMENT 'for hierarchical data',
  `color` varchar(9) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#000000' COMMENT 'hex color code',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_locale`
--

DROP TABLE IF EXISTS `category_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id category)',
  `title` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `meta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_locale_fk_locale_unique` (`fk`,`locale`),
  CONSTRAINT `category_locale_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_resource`
--

DROP TABLE IF EXISTS `category_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `webpath` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_resource_fk_foreign` (`fk`),
  CONSTRAINT `category_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_1` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_2` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_1` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_2` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `num_of_dates` smallint(6) NOT NULL,
  `num_of_seat` smallint(6) NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '0',
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `book_date` datetime DEFAULT NULL COMMENT 'bookable start time',
  `regular_weekday` smallint(6) NOT NULL DEFAULT '0' COMMENT 'week starts monday = 1',
  `regular_time` time DEFAULT NULL COMMENT 'regular time',
  `regular_duration` smallint(6) NOT NULL COMMENT 'duration in Minutes',
  `min_dates_req` decimal(3,2) NOT NULL DEFAULT '0.70' COMMENT 'In percent format 0.11 = 11%',
  `points` smallint(6) NOT NULL,
  `cost` smallint(6) NOT NULL,
  `is_one_on_one` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Einzelangebote(1),Gruppenangebote(0)',
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT 'canceled, pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_attendee`
--

DROP TABLE IF EXISTS `course_attendee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_attendee` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `is_payed` tinyint(1) NOT NULL DEFAULT '0',
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `is_interested` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'merken liste, not waitinglist',
  `is_waiting` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' waitinglist, switch to 0 if is_booked',
  `is_booked` tinyint(1) NOT NULL DEFAULT '0',
  `is_rated` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_attendee_course_id_user_id_unique` (`course_id`,`user_id`),
  KEY `course_attendee_user_id_foreign` (`user_id`),
  CONSTRAINT `course_attendee_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_attendee_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_category`
--

DROP TABLE IF EXISTS `course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_category` (
  `course_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `course_category_course_id_foreign` (`course_id`),
  KEY `course_category_category_id_foreign` (`category_id`),
  CONSTRAINT `course_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_category_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_contact`
--

DROP TABLE IF EXISTS `course_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_contact` (
  `course_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_date`
--

DROP TABLE IF EXISTS `course_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  `order` smallint(6) NOT NULL COMMENT 'order single dates with integer',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `points` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT 'canceled, pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_date_course_id_foreign` (`course_id`),
  CONSTRAINT `course_date_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=739 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_date_contact`
--

DROP TABLE IF EXISTS `course_date_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date_contact` (
  `course_date_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `course_date_contact_course_date_id_foreign` (`course_date_id`),
  KEY `course_date_contact_contact_id_foreign` (`contact_id`),
  CONSTRAINT `course_date_contact_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_date_contact_course_date_id_foreign` FOREIGN KEY (`course_date_id`) REFERENCES `course_date` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_date_locale`
--

DROP TABLE IF EXISTS `course_date_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id course)',
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `title` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'use this for statements about timetable:every thuesday from 09:00 to 10:00',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `requirements` varchar(1500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'i.e. Yogamate, Towel,...',
  `meta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_date_locale_fk_locale_unique` (`fk`,`locale`),
  CONSTRAINT `course_date_locale_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `course_date` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=999 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_date_resource`
--

DROP TABLE IF EXISTS `course_date_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id course)',
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `webpath` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_date_resource_fk_foreign` (`fk`),
  CONSTRAINT `course_date_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `course_date` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_date_room`
--

DROP TABLE IF EXISTS `course_date_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date_room` (
  `course_date_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `course_date_room_course_date_id_foreign` (`course_date_id`),
  KEY `course_date_room_room_id_foreign` (`room_id`),
  CONSTRAINT `course_date_room_course_date_id_foreign` FOREIGN KEY (`course_date_id`) REFERENCES `course_date` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_date_room_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_date_user`
--

DROP TABLE IF EXISTS `course_date_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date_user` (
  `course_id` int(10) unsigned NOT NULL,
  `course_date_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `course_date_user_course_id_foreign` (`course_id`),
  KEY `course_date_user_course_date_id_foreign` (`course_date_id`),
  KEY `course_date_user_user_id_foreign` (`user_id`),
  CONSTRAINT `course_date_user_course_date_id_foreign` FOREIGN KEY (`course_date_id`) REFERENCES `course_date` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_date_user_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_date_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_locale`
--

DROP TABLE IF EXISTS `course_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id course)',
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `title` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'use this for statements about timetable:every thuesday from 09:00 to 10:00',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `requirements` varchar(1500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'i.e. Yogamate, Towel,...',
  `meta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_locale_fk_locale_unique` (`fk`,`locale`),
  CONSTRAINT `course_locale_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_location`
--

DROP TABLE IF EXISTS `course_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_location` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_location_course_id_foreign` (`course_id`),
  KEY `course_location_location_id_foreign` (`location_id`),
  CONSTRAINT `course_location_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_location_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_profile`
--

DROP TABLE IF EXISTS `course_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_profile` (
  `course_id` int(10) unsigned NOT NULL,
  `profile_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `course_profile_course_id_profile_id_unique` (`course_id`,`profile_id`),
  KEY `course_profile_profile_id_foreign` (`profile_id`),
  CONSTRAINT `course_profile_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_profile_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_questionaire`
--

DROP TABLE IF EXISTS `course_questionaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_questionaire` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `questionaire_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_questionaire_course_id_foreign` (`course_id`),
  KEY `course_questionaire_questionaire_id_foreign` (`questionaire_id`),
  CONSTRAINT `course_questionaire_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_questionaire_questionaire_id_foreign` FOREIGN KEY (`questionaire_id`) REFERENCES `questionaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_resource`
--

DROP TABLE IF EXISTS `course_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id course)',
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `webpath` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_resource_fk_foreign` (`fk`),
  CONSTRAINT `course_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_room`
--

DROP TABLE IF EXISTS `course_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_room` (
  `course_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `course_room_course_id_foreign` (`course_id`),
  KEY `course_room_room_id_foreign` (`room_id`),
  CONSTRAINT `course_room_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_room_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_type`
--

DROP TABLE IF EXISTS `course_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL COMMENT 'foreign key (id course)',
  `is_free` tinyint(1) NOT NULL DEFAULT '0',
  `is_group` tinyint(1) NOT NULL DEFAULT '1',
  `is_special` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT '' COMMENT 'tag like',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_type_course_id_foreign` (`course_id`),
  CONSTRAINT `course_type_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `abrv` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_id` int(10) unsigned DEFAULT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_address_id_foreign` (`address_id`),
  KEY `location_contact_id_foreign` (`contact_id`),
  CONSTRAINT `location_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `location_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `creator_user_id` int(10) unsigned NOT NULL,
  `subject` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'urgent, course , generell, etc',
  `expires` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_creator_user_id_foreign` (`creator_user_id`),
  CONSTRAINT `message_creator_user_id_foreign` FOREIGN KEY (`creator_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_resource`
--

DROP TABLE IF EXISTS `message_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id message)',
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_resource_fk_foreign` (`fk`),
  CONSTRAINT `message_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `message` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_user_user`
--

DROP TABLE IF EXISTS `message_user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_user_user` (
  `message_id` int(10) unsigned NOT NULL,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(10) unsigned NOT NULL,
  `deliverystatus` tinyint(1) NOT NULL DEFAULT '0',
  `readstatus` tinyint(1) NOT NULL DEFAULT '0',
  `sender_delete_status` tinyint(1) NOT NULL DEFAULT '0',
  `recipient_delete_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  KEY `message_user_user_message_id_foreign` (`message_id`),
  KEY `message_user_user_from_user_id_foreign` (`from_user_id`),
  KEY `message_user_user_to_user_id_foreign` (`to_user_id`),
  CONSTRAINT `message_user_user_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `message_user_user_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE,
  CONSTRAINT `message_user_user_to_user_id_foreign` FOREIGN KEY (`to_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes_course`
--

DROP TABLE IF EXISTS `notes_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes_course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT 'loose bindung',
  `course_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes_session`
--

DROP TABLE IF EXISTS `notes_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT 'loose bindung',
  `course_date_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personaldata`
--

DROP TABLE IF EXISTS `personaldata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personaldata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personaldata_user_id_foreign` (`user_id`),
  CONSTRAINT `personaldata_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personaldata_address`
--

DROP TABLE IF EXISTS `personaldata_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personaldata_address` (
  `personaldata_id` int(10) unsigned NOT NULL,
  `address_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `personaldata_address_personaldata_id_address_id_unique` (`personaldata_id`,`address_id`),
  KEY `personaldata_address_address_id_foreign` (`address_id`),
  CONSTRAINT `personaldata_address_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE CASCADE,
  CONSTRAINT `personaldata_address_personaldata_id_foreign` FOREIGN KEY (`personaldata_id`) REFERENCES `personaldata` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personaldata_contact`
--

DROP TABLE IF EXISTS `personaldata_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personaldata_contact` (
  `personaldata_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `personaldata_contact_personaldata_id_contact_id_unique` (`personaldata_id`,`contact_id`),
  KEY `personaldata_contact_contact_id_foreign` (`contact_id`),
  CONSTRAINT `personaldata_contact_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `personaldata_contact_personaldata_id_foreign` FOREIGN KEY (`personaldata_id`) REFERENCES `personaldata` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(13) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `type` smallint(6) NOT NULL COMMENT '2:trainer,3:doc/medical',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_locale`
--

DROP TABLE IF EXISTS `profile_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `fk` int(10) unsigned NOT NULL,
  `title` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `meta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_locale_fk_locale_unique` (`fk`,`locale`),
  CONSTRAINT `profile_locale_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `profile` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_resource`
--

DROP TABLE IF EXISTS `profile_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_resource_fk_foreign` (`fk`),
  CONSTRAINT `profile_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `profile` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionaire_id` int(10) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  `is_rating` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'if 1, answer is used to calculate voting',
  `granularity` smallint(6) NOT NULL COMMENT '2-10, 2 means boolean question yes/no',
  `show_numbers` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'show numbers above range slider',
  `show_text` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'show text below range slider',
  `show_description` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'show additional description',
  `show_commentbox` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'show freetext commentbox',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_course_user`
--

DROP TABLE IF EXISTS `question_course_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_course_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `rating_value` smallint(6) DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_course_user_user_id_foreign` (`user_id`),
  KEY `question_course_user_course_id_foreign` (`course_id`),
  KEY `question_course_user_question_id_foreign` (`question_id`),
  CONSTRAINT `question_course_user_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_course_user_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_course_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_locale`
--

DROP TABLE IF EXISTS `question_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL,
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `title` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subtitle` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionaire`
--

DROP TABLE IF EXISTS `questionaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionaire` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `num_of_points` smallint(6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionaire_locale`
--

DROP TABLE IF EXISTS `questionaire_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionaire_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL,
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `title` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subtitle` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `questionaire_locale_fk_locale_unique` (`fk`,`locale`),
  CONSTRAINT `questionaire_locale_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `questionaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `rating` smallint(6) NOT NULL COMMENT 'aon a scale from 1 to x',
  `text` text COLLATE utf8_unicode_ci COMMENT 'user rating text',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rating_course_id_user_id_unique` (`course_id`,`user_id`),
  KEY `rating_user_id_foreign` (`user_id`),
  CONSTRAINT `rating_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `rating_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1522 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `abrv` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `building_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_building_id_foreign` (`building_id`),
  KEY `room_contact_id_foreign` (`contact_id`),
  CONSTRAINT `room_building_id_foreign` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`),
  CONSTRAINT `room_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_resource`
--

DROP TABLE IF EXISTS `room_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_resource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk` int(10) unsigned NOT NULL COMMENT 'foreign key (id message)',
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'icon,small_icon,media',
  `order` smallint(6) NOT NULL COMMENT 'having multiple media file (gallery) use this to set order',
  `path` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `md5` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_resource_fk_foreign` (`fk`),
  CONSTRAINT `room_resource_fk_foreign` FOREIGN KEY (`fk`) REFERENCES `room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeslot`
--

DROP TABLE IF EXISTS `timeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslot` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `regular` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'regular (1) not available on time on weekday',
  `regular_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'NOT YEY !!!! 0-daily,1-weekly,2-monthly,3-yearly',
  `available_start` datetime NOT NULL,
  `available_end` datetime NOT NULL,
  `helper` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Demodata',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timeslot_profile_id_foreign` (`profile_id`),
  CONSTRAINT `timeslot_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeslot_user`
--

DROP TABLE IF EXISTS `timeslot_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslot_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timeslot_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timeslot_user_timeslot_id_foreign` (`timeslot_id`),
  KEY `timeslot_user_user_id_foreign` (`user_id`),
  CONSTRAINT `timeslot_user_timeslot_id_foreign` FOREIGN KEY (`timeslot_id`) REFERENCES `timeslot` (`id`) ON DELETE CASCADE,
  CONSTRAINT `timeslot_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'internal id',
  `public_key` varchar(2048) COLLATE utf8_unicode_ci NOT NULL COMMENT 'need to define a max. length based on cryp algo and length',
  `group_id` smallint(6) NOT NULL DEFAULT '1' COMMENT 'no foreign key here, only loose binding, not mandatory, 1:User,2:Trainer,3:Medical,4:Admin',
  `department_id` int(11) NOT NULL DEFAULT '1' COMMENT 'no internal table here, for stats, no further usage in internal logic',
  `customer_id` smallint(6) NOT NULL DEFAULT '1' COMMENT 'no foreign key here, only loose binding, not mandatory',
  `locale` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'de',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'using soft delete from proxy',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-27 19:36:57
