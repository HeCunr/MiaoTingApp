/*
 Navicat Premium Data Transfer

 Source Server         : tx-yun
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : 111.229.173.12:3306
 Source Schema         : cloudmusic

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 14/11/2024 12:00:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `user_id` bigint NOT NULL,
                               `music_id` bigint NOT NULL,
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `id`(`id` ASC) USING BTREE,
                               UNIQUE INDEX `idx_unique_collection`(`user_id` ASC, `music_id` ASC) USING BTREE,
                               UNIQUE INDEX `unique_combination`(`user_id` ASC, `music_id` ASC) USING BTREE,
                               INDEX `collection_music_id_fk`(`music_id` ASC) USING BTREE,
                               CONSTRAINT `collection_music_id_fk` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `collection_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1856897959849836546 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection
-- ----------------------------
INSERT INTO `collection` VALUES (1856309157506793473, 1, 1);
INSERT INTO `collection` VALUES (1855887996088172546, 1, 2);
INSERT INTO `collection` VALUES (1855980103196950530, 1, 3);
INSERT INTO `collection` VALUES (1856897917546086402, 2, 1);
INSERT INTO `collection` VALUES (1856897943571742722, 2, 2);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评论内容',
                            `time` datetime NULL DEFAULT NULL COMMENT '评论发布时间',
                            `user_id` bigint NULL DEFAULT NULL COMMENT '发布评论的人',
                            `music_id` bigint NULL DEFAULT NULL COMMENT '评论的音乐',
                            PRIMARY KEY (`id`) USING BTREE,
                            INDEX `comment_music_id_fk`(`music_id` ASC) USING BTREE,
                            INDEX `comment_user_id_fk`(`user_id` ASC) USING BTREE,
                            CONSTRAINT `comment_music_id_fk` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                            CONSTRAINT `comment_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1856663765240463363 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1737812866955751425, '777', '2023-12-21 20:30:49', 1, 1);
INSERT INTO `comment` VALUES (1738211202179280897, '777', '2023-12-22 22:53:40', 1, 1);
INSERT INTO `comment` VALUES (1738254933557350402, '777', '2023-12-23 01:47:26', 1, 1);
INSERT INTO `comment` VALUES (1741340603876216834, '777', '2023-12-31 14:08:47', 1, 1);
INSERT INTO `comment` VALUES (1741347666371100674, '666', '2023-12-31 14:36:51', 1737124833530585090, 1);
INSERT INTO `comment` VALUES (1741348295676084225, '666', '2023-12-31 14:39:21', 1737124833530585090, 1);
INSERT INTO `comment` VALUES (1741441765912678401, '777', '2023-12-31 20:50:46', 1, 1);
INSERT INTO `comment` VALUES (1741456009962000386, '666', '2023-12-31 21:47:22', 1737124833530585090, 2);
INSERT INTO `comment` VALUES (1755167350954422274, '777', '2024-02-07 17:51:21', 1, 1);
INSERT INTO `comment` VALUES (1856235292462104578, '777', '2024-11-12 15:19:15', 1, 1);
INSERT INTO `comment` VALUES (1856658188305121281, '1223', '2024-11-13 19:19:42', 1, NULL);
INSERT INTO `comment` VALUES (1856658188477087745, '1223', '2024-11-13 19:19:42', 1, NULL);
INSERT INTO `comment` VALUES (1856658266784743426, '111', '2024-11-13 19:20:00', 1, NULL);
INSERT INTO `comment` VALUES (1856658266784743427, '111', '2024-11-13 19:20:00', 1, NULL);
INSERT INTO `comment` VALUES (1856658360720375810, '123456', '2024-11-13 19:20:23', 1, NULL);
INSERT INTO `comment` VALUES (1856658360825233409, '123456', '2024-11-13 19:20:23', 1, NULL);
INSERT INTO `comment` VALUES (1856658566006390786, '123', '2024-11-13 19:21:12', 1, NULL);
INSERT INTO `comment` VALUES (1856658566018973698, '123', '2024-11-13 19:21:12', 1, NULL);
INSERT INTO `comment` VALUES (1856658639821946881, '123', '2024-11-13 19:21:29', 1, NULL);
INSERT INTO `comment` VALUES (1856658639868084226, '123', '2024-11-13 19:21:29', 1, NULL);
INSERT INTO `comment` VALUES (1856659267629563906, '757', '2024-11-13 19:23:59', 1, 1);
INSERT INTO `comment` VALUES (1856659365323292674, '123', '2024-11-13 19:24:22', 1, NULL);
INSERT INTO `comment` VALUES (1856659365566562305, '123', '2024-11-13 19:24:22', 1, NULL);
INSERT INTO `comment` VALUES (1856660927579897858, '555', '2024-11-13 19:30:35', 1, NULL);
INSERT INTO `comment` VALUES (1856660927718309889, '555', '2024-11-13 19:30:35', 1, NULL);
INSERT INTO `comment` VALUES (1856661384054390786, '102757', '2024-11-13 19:32:24', 1, 1);
INSERT INTO `comment` VALUES (1856662346559078402, '123', '2024-11-13 19:36:13', 1, NULL);
INSERT INTO `comment` VALUES (1856662346760404994, '123', '2024-11-13 19:36:13', 1, NULL);
INSERT INTO `comment` VALUES (1856663320715542530, '123', '2024-11-13 19:40:05', 1, NULL);
INSERT INTO `comment` VALUES (1856663320862343170, '123', '2024-11-13 19:40:05', 1, NULL);
INSERT INTO `comment` VALUES (1856663765135605762, '123', '2024-11-13 19:41:51', 1, NULL);
INSERT INTO `comment` VALUES (1856663765240463362, '123', '2024-11-13 19:41:51', 1, NULL);

-- ----------------------------
-- Table structure for like_table
-- ----------------------------
DROP TABLE IF EXISTS `like_table`;
CREATE TABLE `like_table`  (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `user_id` bigint NOT NULL,
                               `music_id` bigint NOT NULL,
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `unique_combination`(`user_id` ASC, `music_id` ASC) USING BTREE,
                               INDEX `like_music_id_fk`(`music_id` ASC) USING BTREE,
                               CONSTRAINT `like_music_id_fk` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `like_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1856309138749865986 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of like_table
-- ----------------------------
INSERT INTO `like_table` VALUES (1856309138749865985, 1, 1);
INSERT INTO `like_table` VALUES (1755170223524179969, 1, 2);
INSERT INTO `like_table` VALUES (1737816033437167618, 1, 4);
INSERT INTO `like_table` VALUES (1855914810814709761, 2, 1);
INSERT INTO `like_table` VALUES (1855585915779411970, 2, 2);
INSERT INTO `like_table` VALUES (1855932981026177026, 2, 3);
INSERT INTO `like_table` VALUES (1737820880454561794, 1737124833530585090, 2);
INSERT INTO `like_table` VALUES (1737820244996534273, 1737124833530585090, 3);

-- ----------------------------
-- Table structure for music
-- ----------------------------
DROP TABLE IF EXISTS `music`;
CREATE TABLE `music`  (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '音乐名称',
                          `introduce` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '音乐的介绍',
                          `cover_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲图片',
                          `music_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '音乐的地址',
                          `collect_num` bigint NULL DEFAULT NULL,
                          `like_num` bigint NOT NULL COMMENT '喜欢数量',
                          `upload_user` bigint NOT NULL COMMENT '上传的用户',
                          `singer_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌手名称',
                          PRIMARY KEY (`id`) USING BTREE,
                          INDEX `music_user_id_fk`(`upload_user` ASC) USING BTREE,
                          CONSTRAINT `music_user_id_fk` FOREIGN KEY (`upload_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1855925198188908546 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of music
-- ----------------------------
INSERT INTO `music` VALUES (1, '猪之歌', '猪的歌曲', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/77b7828e-1496-4570-8c77-6e3d61e553cc.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5eb8b7b0-c232-4735-b712-894ab39fb4b8.mp3', 29, 79, 1, 'flyingpig');
INSERT INTO `music` VALUES (2, '666', '猪的歌曲', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/77b7828e-1496-4570-8c77-6e3d61e553cc.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5eb8b7b0-c232-4735-b712-894ab39fb4b8.mp3', 31, 3, 1, 'flyingpig');
INSERT INTO `music` VALUES (3, '999', '猪的歌曲', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/77b7828e-1496-4570-8c77-6e3d61e553cc.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5eb8b7b0-c232-4735-b712-894ab39fb4b8.mp3', 5, 65, 1, 'flyingpig');
INSERT INTO `music` VALUES (4, '猪在叫', '猪的歌曲', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/77b7828e-1496-4570-8c77-6e3d61e553cc.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5eb8b7b0-c232-4735-b712-894ab39fb4b8.mp3', 1, 2, 1, 'flyingpig');
INSERT INTO `music` VALUES (1733757161377914882, '猪', '新年', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a63ef026-76e0-4b1e-98f8-f29ce8d60a43.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5eb8b7b0-c232-4735-b712-894ab39fb4b8.mp3', 0, 0, 1, '猪');
INSERT INTO `music` VALUES (1741064627988566017, '00', '0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a5d7b3ae-9b52-40cd-99e6-29a281fe8fd4.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/b3f48fcb-d3f5-4057-994d-9bcf9eb54d2e.mp3', 0, 0, 1, '11');
INSERT INTO `music` VALUES (1741103247134920705, '00', '0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/77b7828e-1496-4570-8c77-6e3d61e553cc.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/16602473-9356-4fbf-8108-10a9d440b735.mp3', 0, 0, 1, '11');
INSERT INTO `music` VALUES (1741103364453797890, '00', '0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/028a03a9-7a7f-4a0a-9172-6a2adcad4254.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/f64d28fe-00ab-4fc5-815e-4737f667b55b.mp3', 0, 0, 1, '11');
INSERT INTO `music` VALUES (1741103557366616065, '00', '0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/2ded60a1-59c3-4342-98e9-e31cfa096c56.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/efc16a5d-6d4a-4f46-91e0-82b88a1c1ee4.mp3', 0, 0, 1, '11');
INSERT INTO `music` VALUES (1741111005515190273, '1', '1', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/b5cfcd0b-a9d2-49aa-bdf3-55db1b341b3b.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/479903e3-845c-4e7a-ad58-4d5916c21875.mp3', 0, 0, 1, '1');
INSERT INTO `music` VALUES (1741153403502956546, '1', '1', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a21cc77c-2ed9-44f2-b4da-0dcdfd954f3d.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/39889847-670f-4d63-96de-841cd4b51367.mp3', 0, 0, 1, '1');
INSERT INTO `music` VALUES (1741346224163291138, '^(*￣(oo)￣)^', '666', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/db2aa112-8914-4650-91af-eec6d1719fcd.jpeg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/3bb1a30f-4976-43f3-a81a-04218fc4e83a.mp3', 0, 0, 1, '注');
INSERT INTO `music` VALUES (1741356835698446338, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5337d5ca-5ca4-4fdf-9aaf-d51225d1777e.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/2f8ef8ee-3489-45b8-83f6-8c1f6a95c3a1.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1741401161845510146, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/866ec8ee-cfa7-472b-8236-4c2acd2af42c.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/ef95fb9c-ff86-455c-bdc9-70958887d6cd.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1742877781416546305, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/aa7b7483-e80f-436b-a503-8f70b688dddf.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/bc738df0-b29b-41bd-8d4a-4aaae2c07f7f.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1742888974881460225, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5fd3c099-f366-4511-bca5-a9aa81f311b6.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/d50d329c-95b1-4cc2-a49c-7c720023ba5d.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1742889323549757442, '未知歌曲1,未知歌曲1', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/d1de4ecb-38a7-4849-96d0-213935c6ece8.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a48b384a-b518-4a56-89e3-cfda5fd7e798.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1742900149362954241, '未知歌曲1,未知歌曲1', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/d00f902a-215d-425e-8ceb-963f00d14031.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/0a7ad82f-723e-4357-8f6e-f680d7cdef15.mp3', 0, 0, 1737124833530585090, '未知歌手2,未知歌手2');
INSERT INTO `music` VALUES (1749638255209967618, '嘿嘿嘿', '嘿嘿嘿', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/34fa3dcf-c336-4730-b16c-50ec10492f9b.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/fa8c1e47-6137-4633-8a7b-1a978c6c756f.mp3', 0, 0, 1, '嘿嘿嘿');
INSERT INTO `music` VALUES (1749811965212577793, 'heiheihei', 'heiheihei', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/f0ec4750-82af-420d-8fb6-9faa7b57d6b9.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/e5e1d635-9a0a-416e-aa2d-59544aca9802.mp3', 0, 0, 1, 'heiheihei');
INSERT INTO `music` VALUES (1749815199230664705, 'heiheihei', 'heiheihei', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/bd82152a-c2a7-4a6c-afd7-6935099a53ae.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5d9c1123-75af-470b-8bf1-62dfe2195364.mp3', 0, 0, 1, 'heiheihei');
INSERT INTO `music` VALUES (1749816740029194241, 'heiheihei', 'heiheihei', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/3ba10d71-c94b-498e-8590-1cbf9b7dcd9f.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/4f1cf0c5-a774-4232-928f-1e388fcc87cd.mp3', 0, 0, 1, 'heiheihei');
INSERT INTO `music` VALUES (1749816814335483905, 'heihei', 'heiheihei', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/170e9c51-bd73-4140-b9a7-4b8b943fad2b.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/4f1f8522-f144-40db-aef2-ef86dc01a9c7.mp3', 0, 0, 1, 'heihei');
INSERT INTO `music` VALUES (1749816917116903426, 'heihei', 'heiheihei', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/86615688-a070-4c10-abbf-a64b78471a22.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/0ca396b1-4906-413d-a21b-772134bd9df9.mp3', 0, 0, 1, 'heihei');
INSERT INTO `music` VALUES (1749817132389556225, 'heihei', 'heiheihei', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/c235d395-227d-4c33-93a7-21baacca9313.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/ad17637d-dd7f-4af0-a823-f333907201d4.mp3', 0, 0, 1, 'heihei');
INSERT INTO `music` VALUES (1750744366521061378, '未知歌曲\\,未知歌曲\\', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/96e8cf75-cc88-41b4-9ab8-36636a17f2b6.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5773fe00-5604-459e-b1eb-210120fbf12a.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1750744878289063937, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/85e98e39-8f1c-4fb9-94f2-d02ddb86cde6.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/278d4ed2-a1fc-4faa-be64-cf4b58a7ff5b.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1750745325196349441, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/04831809-a12f-4ea2-8dac-9f1eac1e2ba9.png', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a467f204-6ece-4a59-a971-f835bc4dd23d.mp3', 0, 0, 1737124833530585090, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1853332713969205249, '', '', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/ccb0cdb7-672a-4ebd-9367-0b11bb596506_20241104150525884_0a7402.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/b7d255b5-2db0-4e39-8843-c1586e4baf1f_20241104150526639_6610f0.mp3', 0, 0, 1, '');
INSERT INTO `music` VALUES (1853332713969205250, '', '', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/1a0dd106-b5ce-43f3-b7ef-d7a910fbfd2c_20241104150525858_6d9786.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/967981b0-e17a-463b-abfa-71cf9dd7f6ca_20241104150526639_b00f5c.mp3', 0, 0, 1, '');
INSERT INTO `music` VALUES (1853332773490573313, '', '', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/3bf1aadc-6573-41ce-be38-e34bb9e75c1a_20241104150540508_1fc65b.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/e937e347-2be1-4013-b424-39066759290f_20241104150540873_93ba24.mp3', 0, 0, 1, '');
INSERT INTO `music` VALUES (1853332773566070785, '', '', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/81b34a5e-9e43-4c88-bd1b-a83add206881_20241104150540541_191a5c.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/b4d919e3-0b6b-4242-994a-a2061d3dc4e9_20241104150540873_1b4232.mp3', 0, 0, 1, '');
INSERT INTO `music` VALUES (1853333237690974210, '', '', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/01b024df-af7e-4092-b3c3-bade616dc5b1_20241104150731180_e952ce.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/ca0d92a3-2b46-4cdc-8c66-5fbc855f8a0d_20241104150731541_2add31.mp3', 0, 0, 1, '');
INSERT INTO `music` VALUES (1853333237749694466, '', '', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/18cab1e6-2f42-4cd5-87f4-0f7087cb8790_20241104150731213_1e7f02.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/c9a840ca-17b6-43b3-9a74-0744c037fc7d_20241104150731558_76aab7.mp3', 0, 0, 1, '');
INSERT INTO `music` VALUES (1853667532896911362, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/db8bb874-4d8c-47b5-a1b8-0b346c64c958_20241105131553408_632b87.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/d5a6a0b0-ae9e-4f39-a4ef-ef7dab1a6a27_20241105131553730_ad974c.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1853667534281031682, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/67c1f7df-6f87-40e3-917e-86a1bdb0a407_20241105131553678_7211cf.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/d27cfaa8-08c6-4097-9ceb-3ee2e9bb203b_20241105131554059_312668.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1853725039656878081, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/28a20b06-bcd1-4d04-ae16-aa20294a96df_20241105170424040_020afe.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/91b0b8b3-2491-4972-88af-ad4b33b28caa_20241105170424386_239283.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1853725040214720513, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/6e625a1d-60e3-4e7f-a548-55af73d8e1a4_20241105170424207_617552.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/ddd0d32b-0742-4a1d-b082-28d1712e71f4_20241105170424533_4e0f76.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1853727012762337281, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/fde0fccb-f356-4a8e-886d-56f4a28e160c_20241105171214502_4bafca.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/04d943a5-0c78-4593-8ebf-20c8296dc4d4_20241105171214846_74f2c1.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1853727013395677185, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/557ba49d-ec25-4c17-b6ba-2d6b4a841ad6_20241105171214636_b65c9c.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/8fb6329b-6716-46d2-9e9d-9c14170a9bb3_20241105171214976_664557.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855865187152629761, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/75d8b0f6-c637-4770-8de3-9452961bb68c_20241111144834567_498976.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/707fc44a-5a62-4c52-9bc1-deacefc818ae_20241111144835333_fd931f.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855865187152629762, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/f67883f7-8609-4b34-89cf-16f6a2e0e544_20241111144834782_8496b3.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/515e32fa-703e-410d-bbb3-efed6499d766_20241111144835333_1030d0.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855912107447357442, '111,111', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/090581d5-719b-495b-ae49-82b52c425d0f_20241111175501590_bb82c5.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/106bb99a-1c95-4d8d-96e4-d540098153da_20241111175501977_e203b7.mp3', 0, 0, 1, '222,222');
INSERT INTO `music` VALUES (1855912108114251777, '111,111', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/e526282f-b9bd-4a83-9b43-54796e576aac_20241111175501813_1a59bd.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/e64777b3-db02-4a1c-b1ca-262bf293c93e_20241111175502182_a3becf.mp3', 0, 0, 1, '222,222');
INSERT INTO `music` VALUES (1855912222622945282, '未知歌曲12,未知歌曲12', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/edab10e3-9c01-444b-8140-6185cd58a006_20241111175529145_50e2cc.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/618a74c6-0bd4-4875-b949-9ea721a7cadd_20241111175529486_3cfc39.mp3', 0, 0, 1, '未知歌手34,未知歌手34');
INSERT INTO `music` VALUES (1855912223424057345, '未知歌曲12,未知歌曲12', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/d6331d78-114f-448e-872c-863145ecfb7e_20241111175529303_0760b9.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/6cb6370d-56a9-477c-ab4a-77fe2bd2b286_20241111175529657_79db68.mp3', 0, 0, 1, '未知歌手34,未知歌手34');
INSERT INTO `music` VALUES (1855912552446234626, '123,123', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/be7e2ca4-9b28-48a1-ab0b-766b7bdc7539_20241111175647741_ea326e.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/ed26006e-0856-4715-8b20-107bd4a2306c_20241111175648090_9835f0.mp3', 0, 0, 1, '未知歌手999,未知歌手999');
INSERT INTO `music` VALUES (1855912553025048578, '123,123', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/9d1367be-0350-4cd4-a487-803d1d3e252c_20241111175647899_610a53.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/8ec28aa8-10d0-4cdc-9ca6-4200a1e92ce0_20241111175648245_cc9784.mp3', 0, 0, 1, '未知歌手999,未知歌手999');
INSERT INTO `music` VALUES (1855914406630592514, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/0198c8ad-1c52-4658-89b4-e93d1b15ffc4_20241111180409757_3c3019.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/2a6808bf-f4e4-4a68-9695-08b982b14cc3_20241111180410151_27397b.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855914406806753281, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a4170164-a34c-4657-877c-09274d64b8f5_20241111180409884_7a05cd.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/8cf603fc-344f-4907-a4a3-c9810cdba1fe_20241111180410225_3b2d5b.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855915086682460161, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/72275237-5dc6-449a-a0c2-1b21f9f9aff4_20241111180651914_e035b4.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/1acc43bc-e65c-4797-8a95-8a7a9beae9d9_20241111180652331_1eeb9b.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855915086997032962, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a37c7d95-6ea0-4b0d-a0f5-6cac63562139_20241111180652041_26e9d6.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/5a91d699-be74-442c-b65c-ac2ef0e9ab61_20241111180652380_ccdc1b.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855915157201293314, '未知歌曲156,未知歌曲156', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/80cbd102-f9c7-48bd-9936-993d0e3de6b6_20241111180708793_9445a1.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/b514371c-945a-4acb-b3ba-a69cf29ac7a0_20241111180709118_783490.mp3', 0, 0, 1, '未知歌手160,未知歌手160');
INSERT INTO `music` VALUES (1855915157549420546, '未知歌曲156,未知歌曲156', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/959c3044-0358-4858-8737-2c510b936682_20241111180708887_41f964.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/aac6f7ea-bf16-4d32-9555-fae397b549de_20241111180709222_1d81b4.mp3', 0, 0, 1, '未知歌手160,未知歌手160');
INSERT INTO `music` VALUES (1855922224146354177, '未,未', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/f750dd94-64e4-462e-a756-2fe2126eab58_20241111183513650_78aa23.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/21a1ad20-8798-4ac4-86eb-9327f21bb344_20241111183514020_66524e.mp3', 0, 0, 1, '未知歌手222,未知歌手222');
INSERT INTO `music` VALUES (1855922224414789634, '未,未', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/3b21d8de-7d51-4bd0-9380-d0ef205f472f_20241111183513744_22f204.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/a866c711-2fb9-4be5-8d41-a73906bf898c_20241111183514083_dad03b.mp3', 0, 0, 1, '未知歌手222,未知歌手222');
INSERT INTO `music` VALUES (1855925197895307266, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/3288ec49-b164-4b48-8c52-e9555d0a736e_20241111184702638_01e7fd.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/da028986-1024-4750-9691-d31ed4fcba2f_20241111184703007_5f980e.mp3', 0, 0, 1, '未知歌手,未知歌手');
INSERT INTO `music` VALUES (1855925198188908545, '未知歌曲,未知歌曲', '0,0', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/bc91ed0d-10ae-4a77-b4ac-c4ab152519b5_20241111184702733_2cd96c.jpg', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/91913c77-6868-4f37-9b6a-e98c18ea2120_20241111184703090_77812c.mp3', 0, 0, 1, '未知歌手,未知歌手');

-- ----------------------------
-- Table structure for songlist
-- ----------------------------
DROP TABLE IF EXISTS `songlist`;
CREATE TABLE `songlist`  (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌单名单',
                             `user_id` bigint NOT NULL COMMENT '创建歌单的人',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `index_name`(`name` ASC, `user_id` ASC) USING BTREE,
                             INDEX `songlist_user_id_name_index`(`user_id` ASC, `name` ASC) USING BTREE,
                             CONSTRAINT `songlist_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1856909807017979906 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '歌单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songlist
-- ----------------------------
INSERT INTO `songlist` VALUES (1856901992819912705, '111', 1);
INSERT INTO `songlist` VALUES (1856901178076360705, '1111', 2);
INSERT INTO `songlist` VALUES (1856903941619380226, '123456', 1);
INSERT INTO `songlist` VALUES (1856906909311758338, '222', 1);
INSERT INTO `songlist` VALUES (1856907382114676738, '333', 1);
INSERT INTO `songlist` VALUES (1856908539801300994, '444', 1);
INSERT INTO `songlist` VALUES (1856908754637746178, '555', 1);
INSERT INTO `songlist` VALUES (1856909807017979905, '666', 1);
INSERT INTO `songlist` VALUES (1852352206783565825, 'emo歌单', 1);
INSERT INTO `songlist` VALUES (1856904147232550913, 'new0', 1);
INSERT INTO `songlist` VALUES (1856904613429440514, 'new1', 1);
INSERT INTO `songlist` VALUES (1856904942426451970, 'new2', 1);
INSERT INTO `songlist` VALUES (1856906730080759809, 'new3', 1);
INSERT INTO `songlist` VALUES (1856899184678858754, 'test', 1);
INSERT INTO `songlist` VALUES (1856897083844259841, 'test', 2);
INSERT INTO `songlist` VALUES (1856902814001721345, 'testfinal', 1);
INSERT INTO `songlist` VALUES (1731967563450580993, '学习歌单', 1);
INSERT INTO `songlist` VALUES (1731958413551259649, '运动歌单', 1);
INSERT INTO `songlist` VALUES (1852352259526938625, '风花雪月', 1);

-- ----------------------------
-- Table structure for songlist_music
-- ----------------------------
DROP TABLE IF EXISTS `songlist_music`;
CREATE TABLE `songlist_music`  (
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `songlist_id` bigint NOT NULL COMMENT '歌单id',
                                   `music_id` bigint NOT NULL,
                                   PRIMARY KEY (`id`) USING BTREE,
                                   INDEX `songlist_music_music_id_fk`(`music_id` ASC) USING BTREE,
                                   INDEX `songlist_music_songlist_id_fk`(`songlist_id` ASC) USING BTREE,
                                   CONSTRAINT `songlist_music_music_id_fk` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                   CONSTRAINT `songlist_music_songlist_id_fk` FOREIGN KEY (`songlist_id`) REFERENCES `songlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songlist_music
-- ----------------------------
INSERT INTO `songlist_music` VALUES (1, 1731967563450580993, 1);
INSERT INTO `songlist_music` VALUES (2, 1731967563450580993, 2);


-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
                         `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
                         `password` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
                         `avatar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '头像',
                         `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
                         PRIMARY KEY (`id`) USING BTREE,
                         UNIQUE INDEX `user_email_uindex`(`email` ASC) USING BTREE,
                         INDEX `user_email_password_index`(`email` ASC, `password` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1742907284412493882 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '88888', '1839976096@qq.com', '$2a$10$CPA/ExjDZe69kHkWKp7Y7.vnC397mPra5WVz37.feVrYX3nkRN8Q6', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/avatar_20241103170739449_be90b9.jpg', 'user');
INSERT INTO `user` VALUES (2, '111', '1', '$2a$10$ZN5ZVKVDOWyPmH9nV654H.rfcVIrsvCYJc69uTxVogLzeFQGJ5iIS', 'https://flying-pig-z.oss-cn-beijing.aliyuncs.com/avatar_20241112232346202_6e2175.jpg', 'user');

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for train_file
-- ----------------------------
DROP TABLE IF EXISTS `train_file`;
CREATE TABLE `train_file`  (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `file_path` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路径',
                         `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文件内容',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

INSERT INTO `train_file` VALUES (1,'/data/item_list.txt','1');
INSERT INTO `train_file` VALUES (2,'/data/user_list.txt','1');
INSERT INTO `train_file` VALUES (3,'/data/train.txt','1');
INSERT INTO `train_file` VALUES (4,'/data/result.txt','1');
