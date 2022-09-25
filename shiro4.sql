-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.22 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 shiro4 的数据库结构
CREATE DATABASE IF NOT EXISTS `shiro4` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shiro4`;

-- 导出  表 shiro4.permissions 结构
CREATE TABLE IF NOT EXISTS `permissions` (
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在导出表  shiro4.permissions 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT IGNORE INTO `permissions` (`name`, `description`) VALUES
	('DELETE', 'delete'),
	('READ', 'read'),
	('WRITE', 'write');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- 导出  表 shiro4.roles 结构
CREATE TABLE IF NOT EXISTS `roles` (
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在导出表  shiro4.roles 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT IGNORE INTO `roles` (`name`, `description`) VALUES
	('ADMIN', 'Administrator role'),
	('USER_P1', 'Perfil 1'),
	('USER_P2', 'Perfil 2');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- 导出  表 shiro4.roles_permissions 结构
CREATE TABLE IF NOT EXISTS `roles_permissions` (
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_name`,`permission`),
  KEY `RP_1` (`role_name`),
  KEY `RP_2` (`permission`),
  CONSTRAINT `RP_1` FOREIGN KEY (`role_name`) REFERENCES `roles` (`name`),
  CONSTRAINT `RP_2` FOREIGN KEY (`permission`) REFERENCES `permissions` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在导出表  shiro4.roles_permissions 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `roles_permissions` DISABLE KEYS */;
INSERT IGNORE INTO `roles_permissions` (`role_name`, `permission`) VALUES
	('ADMIN', 'DELETE'),
	('ADMIN', 'READ'),
	('ADMIN', 'WRITE'),
	('USER_P1', 'READ'),
	('USER_P2', 'DELETE'),
	('USER_P2', 'WRITE');
/*!40000 ALTER TABLE `roles_permissions` ENABLE KEYS */;

-- 导出  表 shiro4.users 结构
CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在导出表  shiro4.users 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT IGNORE INTO `users` (`username`, `email`, `name`, `password`) VALUES
	('admin', 'admin@example.com', 'Administrator', '$shiro1$SHA-256$500000$QmLtx8PaCMe72i+yVuqH+A==$P5ohK5uWi30u38ujuTnmmeUK2gPwqhxTnke2wd9fZXw='),
	('u1', 'u1@example.com', 'User P1', '$shiro1$SHA-256$500000$QmLtx8PaCMe72i+yVuqH+A==$P5ohK5uWi30u38ujuTnmmeUK2gPwqhxTnke2wd9fZXw='),
	('u2', 'u2@example.com', 'User P2', '$shiro1$SHA-256$500000$QmLtx8PaCMe72i+yVuqH+A==$P5ohK5uWi30u38ujuTnmmeUK2gPwqhxTnke2wd9fZXw=');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- 导出  表 shiro4.users_roles 结构
CREATE TABLE IF NOT EXISTS `users_roles` (
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`username`,`role_name`),
  KEY `UR_1` (`username`),
  KEY `UR_2` (`role_name`),
  CONSTRAINT `UR_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `UR_2` FOREIGN KEY (`role_name`) REFERENCES `roles` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在导出表  shiro4.users_roles 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT IGNORE INTO `users_roles` (`username`, `role_name`) VALUES
	('admin', 'ADMIN'),
	('u1', 'USER_P1'),
	('u2', 'ADMIN'),
	('u2', 'USER_P2');
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
