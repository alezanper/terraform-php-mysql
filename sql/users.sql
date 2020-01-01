SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE if not exists crud_app;

use crud_app;

CREATE TABLE IF NOT EXISTS users (
  id int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  username varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  user_email varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE KEY 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

