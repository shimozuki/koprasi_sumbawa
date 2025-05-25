/*
 Navicat Premium Data Transfer

 Source Server         : my_local
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : point_of_sales

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 25/05/2025 10:24:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------
INSERT INTO `cache` VALUES ('arya@gmail.com|127.0.0.1', 'i:4;', 1748126084);
INSERT INTO `cache` VALUES ('arya@gmail.com|127.0.0.1:timer', 'i:1748126084;', 1748126084);

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cashier_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `qty` int NOT NULL,
  `price` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carts_cashier_id_foreign`(`cashier_id` ASC) USING BTREE,
  INDEX `carts_product_id_foreign`(`product_id` ASC) USING BTREE,
  CONSTRAINT `carts_cashier_id_foreign` FOREIGN KEY (`cashier_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carts
-- ----------------------------

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'sbIEdeN2KzSLDXChWSgCM1vZHPZNtlHpBbWmA2Rg.jpg', 'Coffeee Aku suka kamu', 'Strong Coffee', '2025-01-14 07:51:03', '2025-05-24 22:45:30');
INSERT INTO `categories` VALUES (2, NULL, 'Vape', 'Vape dari mookki', '2025-05-24 22:44:59', '2025-05-24 22:44:59');

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` bigint NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (1, 'Pak Samsul', 878273663, 'Sumbawa', '2025-01-14 07:53:52', '2025-01-14 07:53:52');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2024_06_13_082620_create_permission_tables', 1);
INSERT INTO `migrations` VALUES (5, '2024_06_13_091315_add_avatar_field_to_users_table', 1);
INSERT INTO `migrations` VALUES (6, '2024_06_13_125039_create_customers_table', 1);
INSERT INTO `migrations` VALUES (7, '2024_06_13_130507_create_categories_table', 1);
INSERT INTO `migrations` VALUES (8, '2024_06_13_131744_create_products_table', 1);
INSERT INTO `migrations` VALUES (9, '2024_06_13_132800_create_transactions_table', 1);
INSERT INTO `migrations` VALUES (10, '2024_06_13_133940_create_transaction_details_table', 1);
INSERT INTO `migrations` VALUES (11, '2024_06_13_133948_create_carts_table', 1);
INSERT INTO `migrations` VALUES (12, '2024_06_13_133955_create_profits_table', 1);
INSERT INTO `migrations` VALUES (13, '2025_05_25_012800_add_paid_status_to_transactions_table', 2);

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------
INSERT INTO `model_has_permissions` VALUES (1, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (2, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (3, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (4, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (5, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (6, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (7, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (8, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (9, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (10, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (11, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (12, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (13, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (14, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (15, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (16, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (17, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (18, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (19, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (20, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (21, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (22, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (23, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (24, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (25, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (26, 'App\\Models\\User', 1);
INSERT INTO `model_has_permissions` VALUES (26, 'App\\Models\\User', 2);

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (8, 'App\\Models\\User', 1);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 2);
INSERT INTO `model_has_roles` VALUES (5, 'App\\Models\\User', 2);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 2);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 2);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (3, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (5, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (8, 'App\\Models\\User', 3);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'dashboard-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (2, 'users-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (3, 'users-create', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (4, 'users-update', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (5, 'users-delete', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (6, 'roles-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (7, 'roles-create', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (8, 'roles-update', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (9, 'roles-delete', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (10, 'permissions-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (11, 'permissions-create', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (12, 'permissions-update', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (13, 'permissions-delete', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (14, 'categories-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (15, 'categories-create', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (16, 'categories-edit', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (17, 'categories-delete', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (18, 'products-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (19, 'products-create', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (20, 'products-edit', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (21, 'products-delete', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (22, 'customers-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (23, 'customers-create', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (24, 'customers-edit', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (25, 'customers-delete', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (26, 'transactions-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `permissions` VALUES (27, 'sales-report-access', 'web', '2025-05-25 10:03:45', '2025-05-25 10:03:45');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `buy_price` bigint NOT NULL,
  `sell_price` bigint NOT NULL,
  `stock` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `products_barcode_unique`(`barcode` ASC) USING BTREE,
  INDEX `products_category_id_foreign`(`category_id` ASC) USING BTREE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 1, 'MfX9uLtZGHfORlgYxQLHhIyeZFx1AOId8YtsJWbp.webp', '131098463552', 'Coffeee ku', 'Coffe Botol', 30000, 31000, 28, '2025-01-14 07:53:14', '2025-01-14 07:54:32');
INSERT INTO `products` VALUES (2, 2, 'RfV8AgtibzzFwS24WZopT9RwDBxEzuRqZGcSNekP.png', '21746383296453', 'Marinasi susu', 'Susu murni dari sapi perah', 450199, 460199, 22, '2025-05-24 22:48:14', '2025-05-25 01:52:02');

-- ----------------------------
-- Table structure for profits
-- ----------------------------
DROP TABLE IF EXISTS `profits`;
CREATE TABLE `profits`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint UNSIGNED NOT NULL,
  `total` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `profits_transaction_id_foreign`(`transaction_id` ASC) USING BTREE,
  CONSTRAINT `profits_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of profits
-- ----------------------------
INSERT INTO `profits` VALUES (1, 1, 2000, '2025-01-14 07:54:32', '2025-01-14 07:54:32');
INSERT INTO `profits` VALUES (2, 2, 10000, '2025-05-25 01:52:02', '2025-05-25 01:52:02');

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id` ASC) USING BTREE,
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
INSERT INTO `role_has_permissions` VALUES (2, 1);
INSERT INTO `role_has_permissions` VALUES (3, 1);
INSERT INTO `role_has_permissions` VALUES (4, 1);
INSERT INTO `role_has_permissions` VALUES (5, 1);
INSERT INTO `role_has_permissions` VALUES (6, 2);
INSERT INTO `role_has_permissions` VALUES (7, 2);
INSERT INTO `role_has_permissions` VALUES (8, 2);
INSERT INTO `role_has_permissions` VALUES (9, 2);
INSERT INTO `role_has_permissions` VALUES (10, 3);
INSERT INTO `role_has_permissions` VALUES (11, 3);
INSERT INTO `role_has_permissions` VALUES (12, 3);
INSERT INTO `role_has_permissions` VALUES (13, 3);
INSERT INTO `role_has_permissions` VALUES (14, 4);
INSERT INTO `role_has_permissions` VALUES (15, 4);
INSERT INTO `role_has_permissions` VALUES (16, 4);
INSERT INTO `role_has_permissions` VALUES (17, 4);
INSERT INTO `role_has_permissions` VALUES (18, 5);
INSERT INTO `role_has_permissions` VALUES (19, 5);
INSERT INTO `role_has_permissions` VALUES (20, 5);
INSERT INTO `role_has_permissions` VALUES (21, 5);
INSERT INTO `role_has_permissions` VALUES (22, 6);
INSERT INTO `role_has_permissions` VALUES (23, 6);
INSERT INTO `role_has_permissions` VALUES (24, 6);
INSERT INTO `role_has_permissions` VALUES (25, 6);
INSERT INTO `role_has_permissions` VALUES (26, 7);
INSERT INTO `role_has_permissions` VALUES (27, 7);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'users-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (2, 'roles-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (3, 'permission-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (4, 'categories-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (5, 'products-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (6, 'customers-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (7, 'transactions-access', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');
INSERT INTO `roles` VALUES (8, 'super-admin', 'web', '2025-01-14 06:57:25', '2025-01-14 06:57:25');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('maPYwgmRlN8aAUztOmveaLS9uegaIyTszHFAigz5', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVjRCMTVmbzFPM3A2a1JMaGt4WmxtQUxIQlZIajhxNzlYeDF3N3B3UCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9kYXNoYm9hcmQvcm9sZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTozO30=', 1748139622);
INSERT INTO `sessions` VALUES ('ZGhNG7UKBoe2lInES8EUVYnpcyP8obady8GSGjLN', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiMUlYVlFneEtsY1dCWDc2U1lvZ1l6VlpiUG14Rmx4aGFHelI2S3I0OCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQ0OiJodHRwOi8vbG9jYWxob3N0OjgwMDAvZGFzaGJvYXJkL3RyYW5zYWN0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1748139826);

-- ----------------------------
-- Table structure for transaction_details
-- ----------------------------
DROP TABLE IF EXISTS `transaction_details`;
CREATE TABLE `transaction_details`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `qty` int NOT NULL,
  `price` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transaction_details_transaction_id_foreign`(`transaction_id` ASC) USING BTREE,
  INDEX `transaction_details_product_id_foreign`(`product_id` ASC) USING BTREE,
  CONSTRAINT `transaction_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transaction_details_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction_details
-- ----------------------------
INSERT INTO `transaction_details` VALUES (1, 1, 1, 2, 62000, '2025-01-14 07:54:32', '2025-01-14 07:54:32');
INSERT INTO `transaction_details` VALUES (2, 2, 2, 1, 460199, '2025-05-25 01:52:02', '2025-05-25 01:52:02');

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cashier_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NULL DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash` bigint NOT NULL,
  `change` bigint NOT NULL,
  `discount` bigint NOT NULL,
  `grand_total` bigint NOT NULL,
  `paid_status` enum('lunas','belum lunas') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'lunas',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transactions_cashier_id_foreign`(`cashier_id` ASC) USING BTREE,
  INDEX `transactions_customer_id_foreign`(`customer_id` ASC) USING BTREE,
  CONSTRAINT `transactions_cashier_id_foreign` FOREIGN KEY (`cashier_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transactions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO `transactions` VALUES (1, 1, 1, 'TRX-QQ77337846', 200000, 76000, 0, 124000, 'lunas', '2025-01-14 07:54:32', '2025-01-14 07:54:32');
INSERT INTO `transactions` VALUES (2, 3, 1, 'TRX-3F7BF53117', 400000, -60199, 0, 460199, 'belum lunas', '2025-05-25 01:52:02', '2025-05-25 01:52:02');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin@gmail.com', NULL, '$2y$12$iH7ujFhymRuB5TMEjminmukwI1FmCBq37QlM8M8jxpheVNUc8MVkm', NULL, '2025-01-14 06:57:25', '2025-01-14 06:57:25', NULL);
INSERT INTO `users` VALUES (2, 'Cashier', 'cashier@gmail.com', NULL, '$2y$12$iH7ujFhymRuB5TMEjminmukwI1FmCBq37QlM8M8jxpheVNUc8MVkm', NULL, '2025-01-14 06:57:25', '2025-01-14 06:57:25', NULL);
INSERT INTO `users` VALUES (3, 'admin Dispopar', 'admin@dispopar.com', NULL, '$2y$12$pRZjIIBA2v39uSx.OVdP6.9jKtafdJMj8ht0L8sbucYdd32uDhIX6', NULL, '2025-01-14 07:48:15', '2025-01-14 07:48:15', NULL);

SET FOREIGN_KEY_CHECKS = 1;
