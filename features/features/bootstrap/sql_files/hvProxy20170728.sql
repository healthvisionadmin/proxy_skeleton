
/*
 Navicat MySQL Data Transfer

 Source Server         : localhost s239
 Source Server Type    : MySQL
 Source Server Version : 50709
 Source Host           : localhost:3306
 Source Schema         : hvProxy

 Target Server Type    : MySQL
 Target Server Version : 50709
 File Encoding         : 65001

 Date: 28/07/2017 12:35:45
*/
CREATE DATABASE  IF NOT EXISTS `health_test_proxy` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `health_test_proxy`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ID
-- ----------------------------
DROP TABLE IF EXISTS `ID`;
CREATE TABLE `ID` (
  `UID` char(50) COLLATE utf16_bin DEFAULT NULL COMMENT 'must be char, for UID can be text or int',
  `userID` int(11) NOT NULL,
  `UAID` char(50) COLLATE utf16_bin DEFAULT NULL COMMENT 'this is a UUID',
  `customerDepartmentUUID` char(50) COLLATE utf16_bin DEFAULT NULL,
  `customerUUID` char(50) COLLATE utf16_bin DEFAULT NULL,
  `pushDeviceUUID` char(50) COLLATE utf16_bin DEFAULT NULL,
  `publicKey` text COLLATE utf16_bin,
  `soaID` int(11) DEFAULT NULL COMMENT 'soa ID received from SOA',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of ID
-- ----------------------------
BEGIN;
INSERT INTO `ID` VALUES ('12555', 8, '60d26cc9-72ce-6789-2258-4e3866af0689', '123456iolkjtrdsmjku654', '12490', 'XXAADD112233', '4e3866af0689', NULL);
COMMIT;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access` (
  `userType` int(11) NOT NULL,
  `isAllowedUUIDtoUAID` tinyint(1) DEFAULT NULL,
  `isAllowedUAIDtoUID` tinyint(1) DEFAULT NULL,
  `isAllowedSMS` tinyint(1) DEFAULT NULL,
  `isAllowedPush` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`userType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of access
-- ----------------------------
BEGIN;
INSERT INTO `access` VALUES (1, 0, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for actionLog
-- ----------------------------
DROP TABLE IF EXISTS `actionLog`;
CREATE TABLE `actionLog` (
  `timestamp` datetime DEFAULT NULL,
  `actionType` char(255) COLLATE utf16_bin DEFAULT NULL,
  `actionDescription` text COLLATE utf16_bin,
  `IP` char(20) COLLATE utf16_bin DEFAULT NULL COMMENT 'remote IP',
  `GEOLocation` char(40) COLLATE utf16_bin DEFAULT NULL,
  `userID` int(4) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `contractStartDate` date DEFAULT NULL,
  `contractEndDate` date DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of contract
-- ----------------------------
BEGIN;
INSERT INTO `contract` VALUES ('2017-01-01', '2018-01-01', 8, 0);
COMMIT;

-- ----------------------------
-- Table structure for email
-- ----------------------------
DROP TABLE IF EXISTS `email`;
CREATE TABLE `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `address` char(255) COLLATE utf16_bin DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `note` text COLLATE utf16_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of email
-- ----------------------------
BEGIN;
INSERT INTO `email` VALUES (1, 8, 'donotreply.testing.web@gmail.com', 2, '');
INSERT INTO `email` VALUES (2, 8, 'def@gmail.com', 5, '');
INSERT INTO `email` VALUES (3, 8, 'ghi@gmail.com', 10, '');
INSERT INTO `email` VALUES (4, 8, 'jkl@gmail.com', 3, '');
INSERT INTO `email` VALUES (5, 8, 'mno@gmail.com', 6, '');
COMMIT;

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `imageID` int(11) NOT NULL,
  `path` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of images
-- ----------------------------
BEGIN;
INSERT INTO `images` VALUES (1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdS0kEmfTwJI4KBZxkR9ukmDbrq9z_G0P3-CqItqyr3bzV4jYUtA');
COMMIT;

-- ----------------------------
-- Table structure for personalData
-- ----------------------------
DROP TABLE IF EXISTS `personalData`;
CREATE TABLE `personalData` (
  `sex` int(1) DEFAULT NULL COMMENT '0=male, 1=female',
  `yearBirth` int(4) DEFAULT NULL,
  `userID` int(4) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of personalData
-- ----------------------------
BEGIN;
INSERT INTO `personalData` VALUES (0, 1988, 8);
COMMIT;

-- ----------------------------
-- Table structure for phone
-- ----------------------------
DROP TABLE IF EXISTS `phone`;
CREATE TABLE `phone` (
  `phone` char(20) COLLATE utf16_bin DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `note` text COLLATE utf16_bin,
  `number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of phone
-- ----------------------------
BEGIN;
INSERT INTO `phone` VALUES ('987653210', 8, '', 2);
INSERT INTO `phone` VALUES ('987653210', 8, '', 5);
INSERT INTO `phone` VALUES ('987653210', 8, '', 10);
INSERT INTO `phone` VALUES ('987653210', 8, '', 3);
INSERT INTO `phone` VALUES ('987653210', 8, '', 6);
COMMIT;

-- ----------------------------
-- Table structure for pin
-- ----------------------------
DROP TABLE IF EXISTS `pin`;
CREATE TABLE `pin` (
  `userID` int(11) NOT NULL,
  `hashedSaltedPIN` text COLLATE utf16_bin,
  `validUntilDateTime` datetime DEFAULT NULL,
  `sendDateTime` datetime DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of pin
-- ----------------------------
BEGIN;
INSERT INTO `pin` VALUES (8, 'ee7bfb2d9b251cc3b2203976a92dc3202423c895f54d2e31220f78ceb482ba6d', '2017-07-19 17:23:49', '2017-07-19 17:23:49', 1);
COMMIT;

-- ----------------------------
-- Table structure for pki
-- ----------------------------
DROP TABLE IF EXISTS `pki`;
CREATE TABLE `pki` (
  `userID` int(10) NOT NULL,
  `UAID` char(50) COLLATE utf16_bin DEFAULT NULL,
  `UID` char(50) COLLATE utf16_bin DEFAULT NULL,
  `pubKey` text COLLATE utf16_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_bin;

-- ----------------------------
-- Records of pki
-- ----------------------------
BEGIN;
INSERT INTO `pki` VALUES (8, '60d26cc9-72ce-6789-2258-4e3866af0689', '12555', '');
COMMIT;

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server` varchar(255) NOT NULL,
  `pubkey` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of settings
-- ----------------------------
BEGIN;
INSERT INTO `settings` VALUES (1, 'proxy', 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQCS+i7koquuKpwpdqL77uaEHbuAu+z4O8ARAix/4bSjWPGFxT9igXUTGbWdmanzVU9siI0fAkir2ew2BkOG6UE2i1gotSi6ThsflHtKfG2AD7xS8wIxmNr+Y3/imyAGxuCqwn+6LzUJ/2OzZ4Ub+C6W6JP8/jJFfR8hFxgsWM8rQQ== phpseclib-generated-key');
INSERT INTO `settings` VALUES (2, 'kradmin', 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQC1ajDHSekgFnpo1EG/IMDix+5g6+JE9aT8fLMXWYMdhcoh/9OvxFlsW1P3Q0Z1C4fdLXcEw5yX15syxKmAxSO8ZWSRkYrqbLFmKT0m8CYtQ0+vq/ue6HQ/kBYM0vam0pNg/lutScMHRD+HOh/ckjUIAJ1Eg6jn7eGN+LjR/QJ54Q== phpseclib-generated-key');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `nameFirst` char(50) COLLATE utf16_bin DEFAULT NULL,
  `nameLast` char(50) COLLATE utf16_bin DEFAULT NULL,
  `academicTitle` char(50) COLLATE utf16_bin DEFAULT NULL,
  `userType` int(11) DEFAULT NULL,
  `userID` int(11) NOT NULL AUTO_INCREMENT,