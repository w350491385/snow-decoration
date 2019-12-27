/*
SQLyog Ultimate
MySQL - 5.7.14 : Database - ttn-decoration
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ttn-decoration` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ttn-decoration`;

/*Table structure for table `ct_article` */

CREATE TABLE `ct_article` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                              `create_man` bigint(20) DEFAULT NULL COMMENT '创建人',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_man` bigint(20) DEFAULT NULL COMMENT '更新人',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `title` varchar(128) DEFAULT NULL COMMENT '标题',
                              `read_count` int(11) NOT NULL DEFAULT '0' COMMENT '阅读数',
                              `like_count` int(11) NOT NULL DEFAULT '0' COMMENT '点赞数',
                              `conten` text COMMENT '文章内容',
                              `reward_tile` varchar(128) DEFAULT NULL COMMENT '打赏标题',
                              `reward_pic_url` varchar(128) DEFAULT NULL COMMENT '打赏图片URL',
                              `if_publish` int(11) NOT NULL DEFAULT '0' COMMENT '是否发布',
                              `type` varchar(32) DEFAULT NULL COMMENT '文章类型 字典',
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='社区文章 ';

/*Data for the table `ct_article` */

/*Table structure for table `ct_config` */

CREATE TABLE `ct_config` (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                             `config_key` varchar(32) DEFAULT NULL COMMENT '标识',
                             `config_value` varchar(128) DEFAULT NULL COMMENT '值',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='社区配置 ';

/*Data for the table `ct_config` */

/*Table structure for table `ct_discuss` */

CREATE TABLE `ct_discuss` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                              `create_man` bigint(20) DEFAULT NULL COMMENT '创建人',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_man` bigint(20) DEFAULT NULL COMMENT '更新人',
                              `update_tie` datetime DEFAULT NULL COMMENT '更新时间',
                              `article_id` bigint(20) DEFAULT NULL COMMENT '所属文章',
                              `content` varchar(1024) DEFAULT NULL COMMENT '内容',
                              `replay_id` bigint(20) DEFAULT NULL COMMENT '@ 回复谁',
                              `like_count` int(11) DEFAULT NULL COMMENT '点赞数',
                              `type` int(11) DEFAULT NULL COMMENT '评论类型 1回复文章2回复评论',
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='社区文章评论 ';

/*Data for the table `ct_discuss` */

/*Table structure for table `ct_menu` */

CREATE TABLE `ct_menu` (
                           `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `name` varchar(32) DEFAULT NULL COMMENT '菜单名称',
                           `parent_id` bigint(20) DEFAULT NULL COMMENT '上级菜单',
                           `type` varchar(32) DEFAULT NULL COMMENT '菜单类型',
                           `if_show` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='社区菜单 ';

/*Data for the table `ct_menu` */

insert  into `ct_menu`(`id`,`update_time`,`name`,`parent_id`,`type`,`if_show`) values
(1,'2019-05-20 09:39:11','首页',NULL,'1',1),
(2,'2019-05-20 09:39:21','社区',NULL,'1',1),
(7,'2019-05-20 09:42:52','最新',2,'1',1),
(8,'2019-05-20 09:43:00','最热',2,'1',1),
(9,'2019-05-20 09:43:09','关于',NULL,'1',1),
(10,'2019-05-20 09:43:17','服务',NULL,'1',1),
(11,'2019-05-20 09:43:26','平台入口',NULL,'1',1);

/*Table structure for table `ct_tag` */

CREATE TABLE `ct_tag` (
                          `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                          `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                          `name` varchar(32) DEFAULT NULL COMMENT '名称',
                          `menu_id` bigint(20) DEFAULT NULL COMMENT '所属菜单',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='社区标签 ';

/*Data for the table `ct_tag` */

/*Table structure for table `ct_tag_article` */

CREATE TABLE `ct_tag_article` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                  `ta_id` bigint(20) DEFAULT NULL COMMENT 'ta_id',
                                  `article_id` bigint(20) DEFAULT NULL COMMENT 'article_id',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签文章关系 ';

/*Data for the table `ct_tag_article` */

/*Table structure for table `ct_user` */

CREATE TABLE `ct_user` (
                           `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `sys_user_id` bigint(20) NOT NULL COMMENT '登录账号id',
                           `followed` int(11) NOT NULL DEFAULT '1' COMMENT '被关注邮件提醒',
                           `follow_new` int(11) NOT NULL DEFAULT '1' COMMENT '关注人发布新文章提醒',
                           `nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
                           `head_url` varchar(128) DEFAULT NULL COMMENT '头像',
                           `introduce` varchar(512) DEFAULT NULL COMMENT '个人介绍',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='社区用户 ';

/*Data for the table `ct_user` */

/*Table structure for table `pdman_db_version` */

CREATE TABLE `pdman_db_version` (
                                    `DB_VERSION` varchar(256) DEFAULT NULL,
                                    `VERSION_DESC` varchar(1024) DEFAULT NULL,
                                    `CREATED_TIME` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pdman_db_version` */

insert  into `pdman_db_version`(`DB_VERSION`,`VERSION_DESC`,`CREATED_TIME`) values
('v0.0.0','默认版本，新增的版本不能低于此版本','2019-05-20 09:50:14');

/*Table structure for table `qrtz_blob_triggers` */

CREATE TABLE `qrtz_blob_triggers` (
                                      `SCHED_NAME` varchar(120) NOT NULL,
                                      `TRIGGER_NAME` varchar(200) NOT NULL,
                                      `TRIGGER_GROUP` varchar(200) NOT NULL,
                                      `BLOB_DATA` blob,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                      KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                      CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_blob_triggers` */

/*Table structure for table `qrtz_calendars` */

CREATE TABLE `qrtz_calendars` (
                                  `SCHED_NAME` varchar(120) NOT NULL,
                                  `CALENDAR_NAME` varchar(200) NOT NULL,
                                  `CALENDAR` blob NOT NULL,
                                  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_calendars` */

/*Table structure for table `qrtz_cron_triggers` */

CREATE TABLE `qrtz_cron_triggers` (
                                      `SCHED_NAME` varchar(120) NOT NULL,
                                      `TRIGGER_NAME` varchar(200) NOT NULL,
                                      `TRIGGER_GROUP` varchar(200) NOT NULL,
                                      `CRON_EXPRESSION` varchar(120) NOT NULL,
                                      `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                      CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_cron_triggers` */

insert  into `qrtz_cron_triggers`(`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`CRON_EXPRESSION`,`TIME_ZONE_ID`) values
('RenrenScheduler','TASK_1','DEFAULT','0 0/30 * * * ?','Asia/Shanghai'),
('RenrenScheduler','TASK_2','DEFAULT','0 0/30 * * * ?','Asia/Shanghai');

/*Table structure for table `qrtz_fired_triggers` */

CREATE TABLE `qrtz_fired_triggers` (
                                       `SCHED_NAME` varchar(120) NOT NULL,
                                       `ENTRY_ID` varchar(95) NOT NULL,
                                       `TRIGGER_NAME` varchar(200) NOT NULL,
                                       `TRIGGER_GROUP` varchar(200) NOT NULL,
                                       `INSTANCE_NAME` varchar(200) NOT NULL,
                                       `FIRED_TIME` bigint(13) NOT NULL,
                                       `SCHED_TIME` bigint(13) NOT NULL,
                                       `PRIORITY` int(11) NOT NULL,
                                       `STATE` varchar(16) NOT NULL,
                                       `JOB_NAME` varchar(200) DEFAULT NULL,
                                       `JOB_GROUP` varchar(200) DEFAULT NULL,
                                       `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
                                       `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
                                       PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
                                       KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
                                       KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
                                       KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
                                       KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
                                       KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                       KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_fired_triggers` */

/*Table structure for table `qrtz_job_details` */

CREATE TABLE `qrtz_job_details` (
                                    `SCHED_NAME` varchar(120) NOT NULL,
                                    `JOB_NAME` varchar(200) NOT NULL,
                                    `JOB_GROUP` varchar(200) NOT NULL,
                                    `DESCRIPTION` varchar(250) DEFAULT NULL,
                                    `JOB_CLASS_NAME` varchar(250) NOT NULL,
                                    `IS_DURABLE` varchar(1) NOT NULL,
                                    `IS_NONCONCURRENT` varchar(1) NOT NULL,
                                    `IS_UPDATE_DATA` varchar(1) NOT NULL,
                                    `REQUESTS_RECOVERY` varchar(1) NOT NULL,
                                    `JOB_DATA` blob,
                                    PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
                                    KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
                                    KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_job_details` */

insert  into `qrtz_job_details`(`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`,`DESCRIPTION`,`JOB_CLASS_NAME`,`IS_DURABLE`,`IS_NONCONCURRENT`,`IS_UPDATE_DATA`,`REQUESTS_RECOVERY`,`JOB_DATA`) values
('RenrenScheduler','TASK_1','DEFAULT',NULL,'io.ttn.modules.job.utils.ScheduleJob','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0+io.ttn.modules.job.entity.ScheduleJobEntity\0\0\0\0\0\0\0\0L\0beanNamet\0Ljava/lang/String;L\0\ncreateTimet\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0\nmethodNameq\0~\0	L\0paramsq\0~\0	L\0remarkq\0~\0	L\0statust\0Ljava/lang/Integer;xpt\0testTasksr\0java.util.Datehj�KYt\0\0xpw\0\0X���0xt\00 0/30 * * * ?sr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number�����\0\0xp\0\0\0\0\0\0\0t\0testt\0ttnt\0有参数测试sr\0java.lang.Integer⠤���8\0I\0valuexq\0~\0\0\0\0\0x\0'),
('RenrenScheduler','TASK_2','DEFAULT',NULL,'io.ttn.modules.job.utils.ScheduleJob','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0+io.ttn.modules.job.entity.ScheduleJobEntity\0\0\0\0\0\0\0\0L\0beanNamet\0Ljava/lang/String;L\0\ncreateTimet\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0\nmethodNameq\0~\0	L\0paramsq\0~\0	L\0remarkq\0~\0	L\0statust\0Ljava/lang/Integer;xpt\0testTasksr\0java.util.Datehj�KYt\0\0xpw\0\0X�w�`xt\00 0/30 * * * ?sr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number�����\0\0xp\0\0\0\0\0\0\0t\0test2pt\0无参数测试sr\0java.lang.Integer⠤���8\0I\0valuexq\0~\0\0\0\0x\0');

/*Table structure for table `qrtz_locks` */

CREATE TABLE `qrtz_locks` (
                              `SCHED_NAME` varchar(120) NOT NULL,
                              `LOCK_NAME` varchar(40) NOT NULL,
                              PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_locks` */

insert  into `qrtz_locks`(`SCHED_NAME`,`LOCK_NAME`) values
('RenrenScheduler','STATE_ACCESS'),
('RenrenScheduler','TRIGGER_ACCESS');

/*Table structure for table `qrtz_paused_trigger_grps` */

CREATE TABLE `qrtz_paused_trigger_grps` (
                                            `SCHED_NAME` varchar(120) NOT NULL,
                                            `TRIGGER_GROUP` varchar(200) NOT NULL,
                                            PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_paused_trigger_grps` */

/*Table structure for table `qrtz_scheduler_state` */

CREATE TABLE `qrtz_scheduler_state` (
                                        `SCHED_NAME` varchar(120) NOT NULL,
                                        `INSTANCE_NAME` varchar(200) NOT NULL,
                                        `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
                                        `CHECKIN_INTERVAL` bigint(13) NOT NULL,
                                        PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_scheduler_state` */

insert  into `qrtz_scheduler_state`(`SCHED_NAME`,`INSTANCE_NAME`,`LAST_CHECKIN_TIME`,`CHECKIN_INTERVAL`) values
('RenrenScheduler','7YQKBM14KZ1C7K01539709422143',1539711136637,15000);

/*Table structure for table `qrtz_simple_triggers` */

CREATE TABLE `qrtz_simple_triggers` (
                                        `SCHED_NAME` varchar(120) NOT NULL,
                                        `TRIGGER_NAME` varchar(200) NOT NULL,
                                        `TRIGGER_GROUP` varchar(200) NOT NULL,
                                        `REPEAT_COUNT` bigint(7) NOT NULL,
                                        `REPEAT_INTERVAL` bigint(12) NOT NULL,
                                        `TIMES_TRIGGERED` bigint(10) NOT NULL,
                                        PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                        CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_simple_triggers` */

/*Table structure for table `qrtz_simprop_triggers` */

CREATE TABLE `qrtz_simprop_triggers` (
                                         `SCHED_NAME` varchar(120) NOT NULL,
                                         `TRIGGER_NAME` varchar(200) NOT NULL,
                                         `TRIGGER_GROUP` varchar(200) NOT NULL,
                                         `STR_PROP_1` varchar(512) DEFAULT NULL,
                                         `STR_PROP_2` varchar(512) DEFAULT NULL,
                                         `STR_PROP_3` varchar(512) DEFAULT NULL,
                                         `INT_PROP_1` int(11) DEFAULT NULL,
                                         `INT_PROP_2` int(11) DEFAULT NULL,
                                         `LONG_PROP_1` bigint(20) DEFAULT NULL,
                                         `LONG_PROP_2` bigint(20) DEFAULT NULL,
                                         `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
                                         `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
                                         `BOOL_PROP_1` varchar(1) DEFAULT NULL,
                                         `BOOL_PROP_2` varchar(1) DEFAULT NULL,
                                         PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                         CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_simprop_triggers` */

/*Table structure for table `qrtz_triggers` */

CREATE TABLE `qrtz_triggers` (
                                 `SCHED_NAME` varchar(120) NOT NULL,
                                 `TRIGGER_NAME` varchar(200) NOT NULL,
                                 `TRIGGER_GROUP` varchar(200) NOT NULL,
                                 `JOB_NAME` varchar(200) NOT NULL,
                                 `JOB_GROUP` varchar(200) NOT NULL,
                                 `DESCRIPTION` varchar(250) DEFAULT NULL,
                                 `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
                                 `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
                                 `PRIORITY` int(11) DEFAULT NULL,
                                 `TRIGGER_STATE` varchar(16) NOT NULL,
                                 `TRIGGER_TYPE` varchar(8) NOT NULL,
                                 `START_TIME` bigint(13) NOT NULL,
                                 `END_TIME` bigint(13) DEFAULT NULL,
                                 `CALENDAR_NAME` varchar(200) DEFAULT NULL,
                                 `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
                                 `JOB_DATA` blob,
                                 PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                 KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
                                 KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
                                 KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
                                 KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
                                 KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
                                 KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
                                 KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
                                 KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
                                 KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
                                 KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
                                 KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
                                 KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
                                 CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_triggers` */

insert  into `qrtz_triggers`(`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`JOB_NAME`,`JOB_GROUP`,`DESCRIPTION`,`NEXT_FIRE_TIME`,`PREV_FIRE_TIME`,`PRIORITY`,`TRIGGER_STATE`,`TRIGGER_TYPE`,`START_TIME`,`END_TIME`,`CALENDAR_NAME`,`MISFIRE_INSTR`,`JOB_DATA`) values
('RenrenScheduler','TASK_1','DEFAULT','TASK_1','DEFAULT',NULL,1539354600000,-1,5,'PAUSED','CRON',1539354400000,0,NULL,2,'��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0+io.ttn.modules.job.entity.ScheduleJobEntity\0\0\0\0\0\0\0\0L\0beanNamet\0Ljava/lang/String;L\0\ncreateTimet\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0\nmethodNameq\0~\0	L\0paramsq\0~\0	L\0remarkq\0~\0	L\0statust\0Ljava/lang/Integer;xpt\0testTasksr\0java.util.Datehj�KYt\0\0xpw\0\0X���0xt\00 0/30 * * * ?sr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number�����\0\0xp\0\0\0\0\0\0\0t\0testt\0ttnt\0有参数测试sr\0java.lang.Integer⠤���8\0I\0valuexq\0~\0\0\0\0x\0'),
('RenrenScheduler','TASK_2','DEFAULT','TASK_2','DEFAULT',NULL,1539354600000,-1,5,'PAUSED','CRON',1539354400000,0,NULL,2,'��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0+io.ttn.modules.job.entity.ScheduleJobEntity\0\0\0\0\0\0\0\0L\0beanNamet\0Ljava/lang/String;L\0\ncreateTimet\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0\nmethodNameq\0~\0	L\0paramsq\0~\0	L\0remarkq\0~\0	L\0statust\0Ljava/lang/Integer;xpt\0testTasksr\0java.util.Datehj�KYt\0\0xpw\0\0X�w�`xt\00 0/30 * * * ?sr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number�����\0\0xp\0\0\0\0\0\0\0t\0test2pt\0无参数测试sr\0java.lang.Integer⠤���8\0I\0valuexq\0~\0\0\0\0x\0');

/*Table structure for table `schedule_job` */

CREATE TABLE `schedule_job` (
                                `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
                                `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
                                `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
                                `params` varchar(2000) DEFAULT NULL COMMENT '参数',
                                `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
                                `status` tinyint(4) DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
                                `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='定时任务';

/*Data for the table `schedule_job` */

insert  into `schedule_job`(`job_id`,`bean_name`,`method_name`,`params`,`cron_expression`,`status`,`remark`,`create_time`) values
(1,'testTask','test','ttn','0 0/30 * * * ?',1,'有参数测试','2016-12-01 23:16:46'),
(2,'testTask','test2',NULL,'0 0/30 * * * ?',1,'无参数测试','2016-12-03 14:55:56');

/*Table structure for table `schedule_job_log` */

CREATE TABLE `schedule_job_log` (
                                    `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
                                    `job_id` bigint(20) NOT NULL COMMENT '任务id',
                                    `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
                                    `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
                                    `params` varchar(2000) DEFAULT NULL COMMENT '参数',
                                    `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
                                    `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
                                    `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    PRIMARY KEY (`log_id`),
                                    KEY `job_id` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='定时任务日志';

/*Data for the table `schedule_job_log` */

insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`method_name`,`params`,`status`,`error`,`times`,`create_time`) values
(1,1,'testTask','test','ttn',0,NULL,1032,'2018-10-12 22:30:00'),
(2,1,'testTask','test','ttn',0,NULL,1044,'2018-10-12 23:00:00'),
(3,1,'testTask','test','ttn',0,NULL,1012,'2018-10-12 23:30:00'),
(4,1,'testTask','test','ttn',0,NULL,1045,'2018-10-13 00:00:00'),
(5,1,'testTask','test','ttn',0,NULL,1013,'2018-10-13 00:30:00'),
(6,1,'testTask','test','ttn',0,NULL,1010,'2018-10-13 01:00:00'),
(7,1,'testTask','test','ttn',0,NULL,1027,'2018-10-13 01:30:00'),
(8,1,'testTask','test','ttn',0,NULL,1024,'2018-10-13 02:00:00'),
(9,1,'testTask','test','ttn',0,NULL,1043,'2018-10-13 02:30:00'),
(10,1,'testTask','test','ttn',0,NULL,1063,'2018-10-16 23:00:00');

/*Table structure for table `sys_captcha` */

CREATE TABLE `sys_captcha` (
                               `uuid` char(36) NOT NULL COMMENT 'uuid',
                               `code` varchar(6) NOT NULL COMMENT '验证码',
                               `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
                               PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统验证码';

/*Data for the table `sys_captcha` */

insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values
('005e7a83-7ed7-4919-82ca-ac16e1c49e0e','m2c68','2019-05-06 15:02:25'),
('00abf218-aca7-4d7d-87f2-735a5dab6d47','yp8wg','2019-05-06 14:40:49'),
('01370b9a-e09a-45b5-8507-3c531da6443c','3xnx8','2019-07-09 17:04:21'),
('01e4c6d7-fe61-4f1f-8cae-654e1beceb9d','324mp','2019-04-28 15:54:38'),
('02474f8e-514d-4a4f-8c6f-8dd623bf14be','pd8c3','2019-03-22 00:37:30'),
('040b8c1f-e0e5-42ad-8004-24eedde1df5e','8wp76','2019-02-28 10:56:16'),
('070e8d3e-a1b9-4ce9-852e-9db913245647','e82gd','2019-07-09 11:33:15'),
('0745f275-c992-458a-8c16-a1e1ce55418c','83emf','2019-04-28 15:56:46'),
('07b5acf0-ad0d-4c35-8ffd-752a8a435f58','7dn82','2019-07-08 13:52:49'),
('07b73240-c1da-486b-8fa1-3d61c7b9a9f2','nb5dn','2018-10-24 00:58:12'),
('0889c831-7a0f-4307-8359-7ddd47f34104','d67dn','2019-12-27 15:53:53'),
('08b3e7e8-5134-4cec-84c5-b6e455f6490a','af2nx','2018-11-10 00:31:35'),
('097cb41f-8d7f-49fe-84f6-4599b5f1484e','7yb76','2019-02-26 23:48:34'),
('0a6622e5-5072-46ed-8784-c1200e28a9b5','7fd4m','2019-05-06 13:55:43'),
('0a90fc6f-d8b0-4d62-86df-3e6d643c4502','nm4wn','2019-07-08 13:55:45'),
('0ae10850-a821-4f2b-85fa-adaeab5ca927','5fe23','2019-05-06 13:59:40'),
('0c75aa3a-0069-4623-8a44-1bfcd17e4dd8','g4838','2019-04-28 16:00:40'),
('0d7277e2-5d97-4ca8-8afd-17dd45ce0cc5','dn5am','2019-01-30 09:38:00'),
('0dd32682-c985-4770-8c2d-6ce0160526a5','xem33','2019-07-05 16:06:20'),
('0e0baf75-a435-4ad8-8c84-d2e393581d6e','8daye','2019-01-21 09:39:07'),
('0ebdefd1-fa22-4d4f-8e73-da221009127b','cedyb','2019-03-07 10:35:39'),
('0f180b4b-c6b1-4e86-801b-8693671a5a76','c2xb3','2019-05-08 14:57:37'),
('12774b3c-680e-4070-80bc-d949051ba645','b736w','2019-05-06 14:47:53'),
('12ae44ec-646d-477e-89cb-72f7629b3512','yn34p','2019-05-05 13:46:32'),
('13162cb2-a0f9-4c4e-86a1-d7ffceaeb9b4','p8mfa','2019-05-06 14:45:32'),
('13bb27af-31d7-433f-8322-3da4a0a1a446','85n24','2019-03-07 14:45:23'),
('13f197fe-0c07-46b3-8fa1-b4eac52f4741','ndx3n','2019-03-05 10:30:28'),
('13fc4f4a-6842-43a5-8f2b-9af9725786e1','bb3bd','2019-05-06 16:54:52'),
('14592a10-b581-401e-8d2b-260f3731c075','bwyed','2019-03-21 15:08:40'),
('14ff96e3-a18d-42d8-8856-a3cdd0d7f63e','pan2b','2019-07-08 13:54:22'),
('157151f2-d3ef-4e28-8f94-a02861339b77','pgw8p','2019-05-05 13:46:13'),
('15c3420d-245e-43d3-85e5-12d9f2ecaa8d','amyp6','2019-03-06 13:14:42'),
('16af6c53-a676-4907-84f6-06ec28ead8d8','mbmx3','2019-03-27 00:22:53'),
('16edf692-e34f-49fd-819b-9bd6d1057033','a3dpp','2019-03-19 16:40:34'),
('16ffb0dd-0b85-4a72-8c14-ce1ab9ee1a2e','5xf48','2019-03-05 13:46:46'),
('171a4742-2714-4149-88fa-d8b494647f82','ng4ng','2019-03-19 16:43:09'),
('17b6be28-4859-41d6-8b8f-de78204e972b','2f4eg','2019-05-06 14:47:25'),
('18d73f8f-16a7-46c1-8045-bd7e38b8ee62','fydb4','2019-07-08 13:54:04'),
('192ca1bd-fed1-4ff2-874c-d6f90fcb8ab6','4wxab','2019-05-06 14:59:21'),
('1bfa65af-cb45-4776-86da-1fe1aabb413a','6c8dm','2019-05-05 18:28:45'),
('1cdc24d3-1ace-4cc0-8737-8d87761547cf','4dxe8','2019-03-28 17:31:13'),
('1ce1781e-c245-4ff6-882f-aeab8ee32245','3yf6e','2019-04-28 14:08:56'),
('1e683f0b-f8db-4e64-8a93-47b61f77e391','8a377','2019-07-09 11:43:02'),
('214423fd-883f-4cc0-8372-d87014cba87a','exndg','2019-04-08 16:43:18'),
('216bf09a-f4c0-4e5e-833b-86281b2ea131','abcpm','2019-05-06 15:06:39'),
('23675aa8-f26a-4274-8a8f-91522f367107','xwgy3','2018-11-10 00:35:07'),
('26c05ffc-0e5d-4551-85ac-543abd5bf240','eycn6','2019-05-06 15:06:08'),
('278762d2-a984-4a85-8c99-fce4275353ff','n4ne7','2019-07-08 11:41:22'),
('29f6841a-68f2-49db-8a1f-70f8e69c2e8b','pgyng','2019-05-06 15:11:32'),
('2b61af17-6658-4284-8b18-2017703a32d1','w66pp','2019-02-28 09:18:55'),
('2bbbcd8f-8823-4e91-8404-ca632ddd596c','w44dc','2019-05-06 14:59:07'),
('2bdd0d32-4ce5-4e71-84ad-daef1fe03e95','m5bma','2019-03-25 23:34:24'),
('2e3dd830-1149-47ee-8369-83c2c53671de','a3wny','2019-07-05 15:13:50'),
('2ed8e70f-5af7-4d77-84be-c56a0a7e5e67','pfxw5','2019-05-05 14:17:12'),
('2f21f64c-2dfd-4ae3-8154-70c8b31432b3','d2fx5','2019-05-05 13:48:04'),
('2fe265e4-8ee0-48be-8ada-ad2f1297e08f','4dw4c','2019-03-19 16:43:00'),
('32b4afa4-2c0a-4ef3-8817-e94f0af863e5','ceagn','2019-07-08 13:56:49'),
('32e5cb79-be27-48e6-8057-4c3300bdb028','yxd5m','2019-05-05 16:25:06'),
('32ed295d-6e71-471f-88cc-2c2f9a71e4fd','wc673','2019-05-05 13:46:21'),
('332f53d0-3cda-4dd7-8c46-c369af53bece','a5673','2019-05-06 11:45:09'),
('335d4462-c74c-428a-85ca-73297e07a624','p3ae7','2019-07-09 11:42:48'),
('339ff00c-9f42-4bd2-872f-71e483ddc5b3','ace62','2019-07-08 15:26:28'),
('33da4b82-bd84-4c50-811a-e7a419281b66','36b6b','2019-05-06 01:13:05'),
('342b6088-8c00-478e-8fd4-6091ffff7afb','4enb2','2019-07-09 14:32:29'),
('34b17db4-f97a-43cd-859c-212908eba104','42xpp','2019-05-06 15:27:27'),
('35037c7c-d5b6-434f-8b3f-759d3b7783ef','aceem','2018-10-22 23:38:41'),
('35a8e0b0-9c23-4cf5-879b-4c8b879e9092','7n3nf','2019-07-09 09:47:55'),
('35ff6fb5-00ae-44eb-8a68-b09dd70fd563','ng8bn','2019-03-21 23:02:51'),
('36d09c7d-22d6-4e40-8252-d3e9b05a9714','52bbc','2019-05-05 18:25:03'),
('39a51268-002e-4e15-8bbe-88d4d97c07c2','nmncn','2019-07-09 10:36:02'),
('3ac4d398-ddcc-4ec7-8a21-01172b61a279','73xf7','2019-05-06 15:00:09'),
('3b72d7b1-799b-44e4-8307-b1e7f75776e8','dgmm3','2019-04-28 14:09:18'),
('3da738b1-7d41-41ea-8369-1f3a54579cd8','g632b','2019-05-06 15:10:37'),
('3df3bebe-561a-49c6-8bb1-49a811503eb1','7a36w','2019-03-21 23:02:44'),
('40271413-24fc-4eaf-86e7-16b93abdd708','dg4m7','2019-05-05 13:38:25'),
('409ad18f-c388-4289-8963-7c8013f26e98','cn2n7','2019-03-07 14:16:53'),
('40ad2062-e1c0-40d3-87eb-8da535b098c3','6awye','2019-03-07 16:04:16'),
('4106f9cb-1462-4833-84bd-63e90c6ca46d','mwg5e','2019-05-21 00:16:06'),
('425b248f-6e39-43e3-8ba5-ac9b8ee04c80','d38nc','2019-02-26 23:20:05'),
('428bd832-51ac-49dd-8ced-e8f6395c4e55','pmncb','2019-07-08 11:33:31'),
('429b8bb9-9aba-47c5-8116-c2f4ca56c294','2dfbn','2019-04-08 10:55:47'),
('43f1a034-f568-402d-8c1e-74171e0340f5','pdbf2','2019-05-06 15:03:52'),
('443973c4-05e9-4c39-81c4-610c7c9f127e','3db8g','2019-07-09 10:40:17'),
('4599f23b-ef32-4b89-8025-a0a590b5d23d','xebfc','2019-03-21 00:11:35'),
('46ce825d-691a-4b2f-8a20-f355c0cd841e','xx5ap','2019-03-18 15:25:02'),
('46edc847-ee42-4b6b-813b-970ac482457c','8d2bx','2019-07-08 13:57:33'),
('477af6b2-eca0-4613-8454-3512de3b333c','x2xan','2019-05-06 13:59:23'),
('47acdadc-393e-4bfd-82c2-9d87266780b4','dfdp8','2019-03-05 13:45:19'),
('48b4903e-d45e-458d-84b7-2df5175d6863','mbwp7','2019-05-05 16:21:10'),
('48f3f85a-553c-4581-8ca6-f869cd60a596','npweb','2019-05-06 14:46:50'),
('4a8f760b-1aa4-416f-846e-039a77d27873','2fy5x','2019-07-09 11:35:36'),
('4b77a6f7-c914-4827-85b3-7eade51aa760','a5g7p','2019-03-21 22:58:39'),
('4c6da312-20ee-4ab9-8419-5dccc6bd8069','wnwbw','2019-03-19 09:16:27'),
('4d475583-66f1-4e76-80c8-886fc14b5b84','wen3n','2019-03-19 15:50:32'),
('4d80e565-03c6-44de-86b0-6d301a8b864e','4md2w','2019-03-27 00:22:44'),
('4dad7600-c7b4-4735-898f-01ac153ae16c','3f3c4','2019-05-06 15:10:08'),
('5031a55a-cead-4803-8eca-9bf38d271291','424cb','2019-03-21 15:10:44'),
('5034cfc5-941d-4eb3-8416-ef986250efcf','2pmae','2019-05-06 14:47:28'),
('51145abe-e787-4389-8748-bad4308abd67','ea64a','2019-07-08 14:59:17'),
('51c8248e-dcf7-4230-8858-dd125a27b7ef','n4nnc','2019-05-06 01:10:14'),
('51e108ec-84d9-4e10-8a53-0254b559fe17','fpyx7','2019-05-06 14:45:47'),
('5275c405-57e7-48e3-8d15-633fe0c1c844','py3pn','2019-05-06 14:44:26'),
('533a2191-d06e-4271-8a74-da4df70411bb','25p3x','2019-03-19 15:50:35'),
('54b49560-02cb-44d3-865b-07037a105b93','n55wg','2019-05-06 14:43:54'),
('55a6a198-58a3-427a-8666-52febfd91787','687ge','2019-07-09 11:44:13'),
('560c19b5-fcf0-4544-8429-c7e03a967886','m56af','2019-03-28 17:31:56'),
('5710d4ca-305a-463a-8e00-b23a9f1b9b27','g7nny','2018-10-23 00:19:21'),
('571e3a53-0daf-41e8-84b1-bf612c3a5fe0','fyg26','2019-07-09 10:40:56'),
('590a45ac-ce49-482f-847c-715776fc9b95','7ba3e','2019-05-06 15:04:55'),
('598ffb47-443b-4ec0-8339-d8d2deef3ab9','m3y53','2018-12-13 11:59:47'),
('5a4324c2-0f1a-4015-89c0-012a9a6457af','3g822','2019-03-20 23:58:09'),
('5ad81837-52d9-4539-837d-52f1da05eb52','w27a5','2019-05-11 10:24:04'),
('5bdeb144-4e5b-4c23-836a-8b0067e8d526','b5pp6','2019-05-05 13:48:46'),
('5c11e4b7-58f4-41a4-8979-4f42fea90f54','mf328','2019-05-05 18:28:02'),
('5d9109fd-73d9-4e48-8d51-ded5ba9e0637','n3n38','2019-07-09 11:42:56'),
('60b0e79f-24e1-4a56-8656-6c1173a314ab','bfmm2','2019-05-05 22:45:17'),
('60be2793-07c8-47e3-86ed-1793fde036c2','44dx7','2019-03-01 00:14:04'),
('6173be9f-6151-4073-8eb9-d0c0240beb23','72f5m','2019-07-08 14:09:24'),
('61ba1d13-c335-44d5-861f-e4c3d97651aa','ecdb6','2019-05-05 17:38:26'),
('61ca1802-5498-4823-8e88-1bdd6e6f65a6','wcg3g','2019-05-05 15:26:03'),
('62667863-bfd8-4d0d-8c13-007283757a8b','n68m5','2019-05-05 14:24:37'),
('6322ca51-213d-4f53-8a7f-183da670ff8e','85w7b','2019-07-09 09:41:43'),
('634ec232-6711-4deb-828e-772f2019e684','5yn7n','2019-02-26 23:48:43'),
('64988e4e-7c2c-4279-893f-ac0b24f63dee','2eby7','2019-03-06 10:22:18'),
('66389de2-6eb4-4c04-877f-c446dc55f425','fe565','2019-05-06 14:43:23'),
('665deccf-d878-4421-8a55-7f3e3dde12b2','64y4n','2019-03-19 15:28:39'),
('6831dd30-26c5-45a0-822e-4614f6566b4d','pfy5g','2019-05-05 13:38:13'),
('685b56b9-9b83-4df8-8771-ec02b4502791','g4e72','2019-03-07 11:57:30'),
('6aa3fec6-8be2-43a8-882d-49ca5606dc6a','f8848','2019-05-11 12:24:58'),
('6b00be43-288e-421e-8e13-8a859a81fbbb','pmyyc','2018-10-22 23:38:10'),
('6b04daac-4f54-4572-8ebb-7c8c044f3e1b','3a86b','2019-05-06 13:59:08'),
('6b4066c4-9e37-40c5-8b94-f403394840bd','fmc4e','2019-05-06 14:42:28'),
('6c38f46e-ed32-4ce2-8c38-2fe7a79ca74b','ng5ye','2019-03-06 10:52:48'),
('6c973085-df9e-4990-89b9-22876c3357cf','f44n8','2019-07-09 10:40:23'),
('6d75a732-5c1c-4317-845f-dca0dcac4972','2wy7d','2019-05-06 13:56:40'),
('6ddc3a2a-9b67-4488-8dec-2763f9517435','34by2','2019-04-08 16:09:19'),
('6f18acce-2852-4a05-8bcb-3d16fb56f40b','g66nx','2019-07-09 11:43:45'),
('6f2281cd-d058-4d0f-8865-57e11cee2a09','2en7n','2019-02-28 23:26:49'),
('6ffd0e3d-6de8-4dca-8c7a-be939c5847be','f64f2','2019-03-02 22:14:01'),
('7009dcf9-1eb8-4940-8ea6-6e4d0cd7168d','72bgg','2019-03-07 14:45:19'),
('70ea33d3-bba9-44de-835f-673728308378','y68ny','2019-03-07 16:04:16'),
('70f99630-6e3b-4e78-8db4-d5ac29fbb787','2xwcf','2019-05-05 16:29:18'),
('7229f59a-272c-441b-8f1a-7cdb719a924b','d6gcm','2019-01-29 22:54:46'),
('72b5af9e-1943-4d38-80a7-b31ccc4f23bf','7bbxc','2019-07-09 10:42:28'),
('74837999-8c32-4b0b-8561-10a02910cc52','ynmg8','2019-05-05 13:38:49'),
('752812fe-c924-4c96-89ef-afdd8ea22687','3nmpw','2019-07-08 13:57:22'),
('7746aaf5-e646-455b-8927-6b2080134d3c','yaf8g','2018-10-22 23:38:41'),
('77cefaf1-bdee-48ef-8464-dd8a9a9c03f8','n7nbm','2019-05-06 14:47:59'),
('77d7082c-9262-485d-8a82-570a581f582c','g625n','2019-02-28 00:21:24'),
('77ebf6e1-2b28-4172-8832-67bb505949b6','eaeef','2019-03-28 17:32:19'),
('78d99512-69a2-4ca9-8721-ea975cf6bfcb','bxfg4','2019-02-26 23:48:32'),
('7adfe228-b454-4b4c-82da-f292a11b2e8e','bwne2','2019-05-06 16:58:03'),
('7ae4655f-0796-43a0-8698-22261019b5eb','fcygb','2019-05-15 01:20:07'),
('7cc3e656-9642-412f-8a1b-f6b321f95a94','anfcn','2019-07-09 14:33:07'),
('7cdb6d51-2bff-4d02-8986-3fca920c9d55','wa3pg','2019-07-08 15:02:46'),
('7e577c3b-76ee-4fbf-8824-ac9e48c2cbd2','d8ec5','2019-03-19 15:29:16'),
('7f500d31-b10b-4298-8c7c-f334a1a3c516','wp5a4','2019-05-06 15:04:39'),
('804af159-5724-412d-85a7-1c5b2ab2982f','4y3dd','2019-02-18 16:25:17'),
('80516db8-aa22-40c4-8a29-0b96fb338030','ndpe5','2019-03-18 15:26:19'),
('81407b93-5bf9-4481-88e6-f88ecaacfa3c','m6fxe','2019-02-26 23:48:28'),
('815497a1-c009-4e26-8d28-12db76e4edf6','wna7m','2019-07-09 11:43:31'),
('81a95bbe-0151-494a-86a1-128ca5da310d','e4xx7','2019-03-18 15:29:46'),
('81e3ec53-b40d-46a3-8d73-1e01e97a808c','mndnf','2019-07-09 16:58:15'),
('82393aef-cef9-431a-83db-1a58cf618a25','eaanf','2019-03-19 17:03:15'),
('82f2aa51-8253-446d-83ca-6c5ccbfa8b7b','aeda5','2019-03-28 17:32:28'),
('83b7ec85-b5ee-4b90-8f62-ceaf1f87d0c5','wmne6','2019-05-05 13:40:38'),
('8536f516-1f35-41dd-8c85-bd64297d189f','nf88d','2019-07-08 15:07:41'),
('8785588c-fe30-43fe-844a-ec217fd318c4','73y42','2019-02-28 00:21:19'),
('8797eed8-abcf-4d07-8698-20e207527ae7','8wb26','2019-02-28 00:15:12'),
('87d3f96c-b9ad-409a-865e-3c2461b70c79','5xca4','2019-07-08 13:58:07'),
('88d788a6-b6b1-4f9f-8c70-f455a06dfef9','mn7cm','2019-05-05 17:23:18'),
('8a3cd562-e063-4aa1-8b2c-3e7165982cf0','nw58w','2019-05-05 15:25:22'),
('8a42fc8b-9ffe-4467-80ae-023c175d0cea','2aaf3','2019-07-05 15:20:15'),
('8b2a38a8-15d4-4b6e-8c92-43f76a802a1c','3e3wm','2019-07-08 11:06:00'),
('8b8d6b76-b715-4eac-8a55-4a23430f2f6e','p2xg4','2019-03-18 15:20:05'),
('8d3c1c64-69df-455c-82d2-1b2e28f40939','n2c6w','2019-04-08 11:37:27'),
('8d616383-bdf9-40d0-82b2-256cd284bc87','ab6xe','2019-05-06 15:03:54'),
('8da6164a-38d1-41ab-898e-73ddf6ebd213','4e3gp','2019-03-19 17:02:17'),
('8e0a0b7b-c3aa-46f6-860a-f2cd8ec50642','n87gm','2019-05-06 15:06:48'),
('9027eeb9-56da-495d-823e-ccc3e0b32851','nxf35','2019-03-21 15:09:12'),
('9058d772-270f-4c4d-86be-1cb9cb2d1264','2p58x','2019-05-05 14:28:07'),
('9128f627-edd5-4be1-8815-02110e45d368','ce8xw','2019-05-05 13:38:42'),
('9183fa98-f7ac-4d27-87f5-73ffd833e6e5','g42e4','2019-05-05 17:41:19'),
('9379fcc9-ed78-4701-8cb4-3047a9b4531a','82gym','2019-05-06 01:27:06'),
('93923659-4b42-4990-8d61-3fc370fab8b7','7g5bw','2019-07-08 13:51:11'),
('93d358a8-9025-4810-8b94-359e861be1aa','4cggb','2019-01-31 09:40:48'),
('95861619-024a-4364-82cb-7e3a3e707ab9','n5pbn','2019-12-27 17:49:23'),
('959b5c9e-f4bb-4102-8ec5-b22a042c436a','nw8my','2019-05-05 13:38:22'),
('96cdce60-f508-48f9-8192-3aaf2540d213','w7nee','2019-07-08 15:04:56'),
('97e02252-065e-4380-87dc-a5ead2833518','4cgf3','2019-03-07 14:58:54'),
('987baae9-82c6-4d3e-8ca9-66d8b2834845','52n85','2019-04-28 14:09:07'),
('994d4f65-6eb4-42d8-82da-d0e6d30307b0','cxafm','2019-02-28 00:16:50'),
('9950568f-1209-44be-83a9-8ee5802744ce','cfded','2019-03-19 16:00:33'),
('9996c513-4c0a-4cbb-8df7-08282beb4909','x8dcn','2019-05-05 18:25:09'),
('9aaa3a1c-2994-438f-8514-60f79153e27c','xpwgn','2019-03-28 17:31:48'),
('9ae09a35-98e9-4ac4-87f9-5452e66df277','3f7nn','2019-04-08 10:51:04'),
('9b345917-e8ab-4567-824b-b3c341f821f2','8pa8x','2019-05-05 14:29:20'),
('9c3ed8cb-0449-4699-86d4-75cd73ecce71','bafpn','2019-05-11 22:26:11'),
('9dadfae3-bcdc-4e6d-8d4d-073359457c18','axyne','2019-05-06 15:05:10'),
('a0152c53-159d-487a-8aef-3dddf59b99fd','yb5bc','2019-05-05 17:40:19'),
('a049f647-7973-43a6-8c4a-7a40b58c1f02','nebdy','2019-02-28 00:21:51'),
('a08977f4-841d-46b0-8f11-a25f3e7aaa21','3m543','2019-07-09 09:47:17'),
('a11a71cf-dbcc-474e-89b2-1c8ca822da41','n38ex','2019-03-19 16:42:44'),
('a1368613-e7c0-4977-8bed-dece3d5eafcb','w2pb5','2019-05-06 14:52:35'),
('a2c78dc4-9f0a-4e5e-8f04-0f423f22ae66','526b2','2019-02-18 16:23:14'),
('a34e0ec5-ea46-4515-8efc-69003347daa7','b6385','2019-05-06 01:17:36'),
('a50c65e1-606c-4e99-8c36-ab46dc21d98b','wpcyb','2019-05-05 13:47:56'),
('a6bb3e89-22b5-4b8b-81ed-318c9fd56d4c','y3dx4','2019-07-08 13:54:48'),
('a6c91b44-7f32-4a8c-8516-72008e38e8fd','ea7md','2019-05-05 18:27:42'),
('a82dc4f5-5cf0-4133-8ff5-0c8c8c898635','ny3e7','2019-07-08 16:38:27'),
('a84e1b1e-a49b-4851-80c3-708c4e216a35','8xnmw','2019-02-28 23:28:29'),
('a865b7ba-60b7-4141-8b3a-f9d2b950470a','cgfne','2019-05-06 14:04:49'),
('a91cb664-4ce8-4fc9-80dc-961a2d68dc50','bg4yg','2019-05-05 13:46:58'),
('a9838ac2-607f-4fa4-8cba-7fb4733ea745','24xmw','2019-07-09 11:43:43'),
('a9f1629a-79b1-4a25-8f5f-0452cce26fc8','wna48','2019-07-09 11:43:07'),
('aa6e3677-78d0-4be3-8e6f-86e0af05037c','nnw78','2019-05-05 16:24:20'),
('aa930190-b1ce-4cf2-840a-e4614f68a190','n6nmn','2019-07-08 15:18:25'),
('aabcabae-c29f-47e7-8aa7-7e8f8335f996','e3d5w','2019-05-06 15:00:03'),
('aad4a018-bc74-4766-8149-079d99c05a4c','p2834','2019-05-06 01:19:36'),
('ab8f195b-3888-4972-8dc9-f845796bfb92','n87a3','2019-03-07 14:08:09'),
('abed7b38-5371-4971-8fad-09bc067dfbbd','2ex6x','2019-07-08 13:51:56'),
('ac6c3e63-08bf-4511-898f-68fa1aed1ec7','ba3fb','2019-04-08 10:57:25'),
('adf778f7-e85d-4894-8c0d-f8bbeaa7786e','nwfad','2019-07-09 14:33:55'),
('ae32c730-dbb2-4b41-8bb3-abb9e1e1c944','3eex5','2019-03-19 16:48:15'),
('ae9d06b6-61d1-4067-8f18-1e94d8f0a54e','bmyyp','2019-07-09 15:57:03'),
('aecb1b1c-e9c3-4f56-8888-3e7a57772dbb','2g8a3','2019-05-05 13:45:58'),
('af5cd806-7b39-4bb4-8294-8829cdd084f6','c732a','2019-12-27 17:46:07'),
('af6346b0-7a5f-4fed-8583-76368d2b7616','ge3y5','2019-03-07 10:36:07'),
('b1396f5f-6714-47fe-8e2f-e0a64944d43c','nnfpa','2019-05-05 13:52:53'),
('b19841e7-cf88-45ad-8bd9-c587eb348d69','ep2e5','2019-05-05 18:23:10'),
('b25bd8fa-7073-4af3-80db-bf4819b7c737','e538y','2019-05-05 17:41:53'),
('b463756b-d312-4f05-818e-b8bc9617c936','wxmnf','2018-10-25 21:04:20'),
('b54c7851-9028-4b0f-8bc3-19728b07713c','66cpy','2019-04-08 10:51:04'),
('b581f466-9b62-424b-82d2-a6530ed95576','54dfw','2018-11-07 09:31:49'),
('b58f24e2-e483-4406-8c80-6ea894f9bc5b','4wf56','2019-03-19 10:28:35'),
('b5c73315-f525-4445-87a0-012c75642e42','fn22c','2019-07-08 13:54:41'),
('b61a1463-dba8-4044-8620-f5f7564143e4','aance','2019-04-28 14:18:52'),
('b634fd7c-5bdc-4d0b-863d-2c5c68aa9a8a','xy245','2019-07-08 15:19:14'),
('b7369dd7-664e-4a8f-8c76-62e8d5b428ae','mxa44','2019-05-27 22:52:55'),
('b7b848b9-4179-4718-87ef-0c205f20eefe','bf7bp','2019-03-05 13:54:48'),
('b80eabb2-878b-47ee-87ec-8a7d627f98fa','b7bdn','2018-10-22 23:52:59'),
('b857a1e9-aaf0-439c-8fa4-c389283f058a','6mpcb','2019-04-28 15:59:56'),
('b8600d78-682b-498b-863d-90ce8fbbc479','fec2a','2019-05-06 15:10:14'),
('b88ce716-a6b7-404e-8ebc-f09f4b4cf635','pyc2p','2019-03-05 22:50:39'),
('b8bd230e-2976-4848-8646-5c285926fc1f','3y4c6','2019-05-05 13:47:04'),
('bdfe26fe-1df8-4569-812f-0172336ef21b','nge46','2019-02-24 22:58:50'),
('bee02d0e-7bdf-4d47-81bc-a3c96aaa9ae5','25ag7','2019-03-28 17:31:43'),
('bff5b6be-7e03-4117-851b-c2e08b8c1e5d','8wcd3','2019-05-06 01:14:04'),
('c043a7a5-8053-45fa-827b-91a065cdd90e','8p65x','2019-05-06 14:58:03'),
('c048e2ef-e93c-434c-89f8-8b8c517c5ae2','8ppep','2018-12-13 09:18:14'),
('c17a3cd0-fd21-4196-81f9-f0452941681f','pb7b6','2019-05-05 13:38:38'),
('c20e02e9-498a-47b5-84b2-975e83902ab5','f7n48','2019-07-09 11:43:34'),
('c257f6ea-d501-4014-8916-42b5ac63e7bb','e64pb','2019-07-09 10:11:25'),
('c2e93bcc-e4c4-41cc-809e-bce29c47fd76','2452g','2018-12-13 18:12:06'),
('c3062251-9364-4d53-80e3-f2c74fd2ab79','24ep5','2019-02-28 23:27:01'),
('c336f8b7-31dd-4684-835f-db4d68c4f58d','p6epg','2019-12-27 15:41:56'),
('c4eac1f4-a9ba-45cc-8a6e-62f7a972abd8','y5bbe','2019-07-09 11:42:46'),
('c575cf18-b871-41ff-8114-cbb15b923a31','36cnb','2019-05-06 14:53:31'),
('c5ff0452-156c-48af-8023-b219a52f59b3','2ygw7','2019-03-19 16:49:00'),
('c6282b11-9c07-4e76-8b1d-a0e281f0cc82','nwx24','2019-03-20 23:57:29'),
('c72f0847-d3e2-47db-8388-a4260367132a','b6e65','2019-03-05 23:04:42'),
('c75c625d-7c63-4aef-89ef-7e6fd8112c68','ag6e7','2019-07-05 15:35:02'),
('c7b7e392-8ad4-4bb7-84c7-26ad584087c2','xyd4d','2019-07-09 10:12:26'),
('c7b9dc05-dde1-4720-8356-4bcfb166d859','62gf4','2019-07-09 09:48:49'),
('ca47110c-51c2-42aa-89fa-ab1108cd0970','nmcpc','2019-05-05 18:23:41'),
('cae51928-9dd9-4776-8d17-24d4f5626770','86dyc','2018-12-13 17:39:33'),
('cd388067-f253-4494-8588-192a34ef6ef5','4mnn3','2019-03-21 22:28:45'),
('cd815227-f062-4c1d-86d0-3e7149dfdaf6','e7bpn','2019-03-19 15:40:29'),
('cd9dcc4f-7d65-4a73-8b87-e1284c803ce4','76pya','2019-07-05 15:22:35'),
('d0d79184-bf83-4616-87b0-85a560c6cef2','xp7xf','2019-05-06 14:49:22'),
('d125eeef-dca1-4ad4-8326-e6fa9483bb39','85npw','2019-07-08 14:23:43'),
('d16f4449-0c6b-4e6b-8bfa-be9f4ac2e71c','d78m8','2018-10-23 09:18:30'),
('d20b7800-a76d-437d-836d-801c044d1941','cbaan','2019-07-08 15:02:19'),
('d279a1b0-b66b-44e1-84cd-6dd6b38ff781','66eaa','2019-02-28 23:27:41'),
('d2e527a3-1505-4184-8ad6-98d0127c7e37','xmwd7','2019-02-27 22:32:19'),
('d32c6a69-1b50-4eac-8570-0c98e4824de7','y7egy','2019-03-18 15:20:09'),
('d3e17050-9078-4681-88de-5f08a7dbb305','7nce6','2019-05-11 12:25:00'),
('d4b70495-124f-4f52-8989-be43ede6d0f5','ancgn','2019-05-06 15:03:13'),
('d54a1462-7352-4217-895c-bc03591c53d7','bn6en','2019-01-29 22:55:04'),
('d6c29cfa-6691-4049-86ee-869c4461e620','b6yp7','2019-02-28 00:15:20'),
('d6dc1c62-137f-4b87-8fb4-5d57729b8394','n7pgn','2019-07-08 13:55:21'),
('d7bad21f-d7a3-4f13-8fb4-e9eacdb9820d','363cg','2019-03-18 15:26:19'),
('d920bfce-86b0-4f45-8093-539aec874629','7nded','2019-02-28 00:16:42'),
('d94731db-f4f0-4f86-8b30-53622f475733','3dy24','2019-05-05 22:13:16'),
('da8db90a-557d-47f2-89fc-9d78228832ef','ggdp2','2019-02-18 16:23:27'),
('dab43a0b-2d73-442a-8f24-7ea5396391a8','m6wf3','2019-03-07 14:08:04'),
('dba9028f-5de5-4524-8f25-ae92be45856f','bnx5x','2019-03-19 16:42:28'),
('dbc0d8ff-0f87-40f1-82fe-983ad91fe81a','477ca','2018-10-23 20:57:09'),
('dc23bcba-dacd-4898-8aac-9a780072e8a1','bn85p','2019-07-09 14:33:54'),
('dc7657bf-3372-45e8-8167-241d164b721c','x3dn5','2019-05-05 13:47:53'),
('dc7c56a8-9612-4bb2-872c-6344cd4b0033','pw86b','2019-04-28 15:59:53'),
('dd158fe5-b13a-49c4-8168-9494d6c7cd82','bep5n','2019-05-06 14:57:47'),
('dd89bf99-a9d3-4f2d-84fb-a6f4ed7a5cf3','n6bn7','2019-02-26 23:48:22'),
('dea9d5dc-95de-48f9-8565-a9072d338a9f','nm37f','2019-07-08 14:24:09'),
('df186e1a-c575-4250-869f-6f30ffc7373e','8ax3p','2019-01-31 01:03:14'),
('df5d9e71-faa0-48eb-8f06-781edf57e077','mw2b3','2019-07-09 10:40:53'),
('e02ab9a9-9037-4527-8fe3-5d3960d4bd0a','8d887','2019-01-24 09:17:14'),
('e14b202c-9b91-4487-8777-c71e3fa3a908','x722c','2019-03-27 00:22:40'),
('e17c2ab0-add4-4f2e-8902-d3e4c22f392f','585df','2019-05-06 14:58:34'),
('e279dd86-9bf0-412c-8e67-e0c4b5f1f755','8nemd','2019-03-27 00:22:30'),
('e29b87f7-c1a3-41ab-8a09-db5f78a2a380','x2ay2','2019-05-05 13:41:02'),
('e2b1348b-49c5-4f82-80ca-95e4146ec1bf','b58x2','2019-05-05 22:44:58'),
('e349faa1-69c2-44fb-8a1e-2f6e6b10fd06','4gp2f','2019-04-08 17:16:07'),
('e3a63d65-8f31-4d38-8404-6dd3a25b72b1','27x82','2019-04-28 14:09:10'),
('e3c254e9-27c4-4810-82d6-34915e020949','efe37','2019-05-05 16:25:57'),
('e50bab0a-bacd-4029-8b0b-d3b5aec96320','ycg6d','2019-03-27 00:23:35'),
('e541f655-317e-4b1e-8822-d28bb046120c','wndg8','2019-05-05 18:24:33'),
('e56499d8-b764-400f-8831-6241a720708a','n4x7m','2019-05-06 01:01:47'),
('e8d0dcf5-10b6-42d2-84fb-f4e603203801','7nn6a','2019-03-02 21:53:37'),
('e9c9c93e-e30a-4631-8d09-eccbb1c8690f','g56ne','2019-03-28 17:31:35'),
('eb052e9e-44cb-43c7-8124-ffb871240f97','gme7f','2019-01-22 09:31:25'),
('eb9e4838-e577-4eb3-88cc-c77355684c82','w76nc','2019-03-20 23:56:43'),
('ec6f6883-bd64-40f3-8731-048846bfb0a3','7cg5b','2019-05-06 16:57:56'),
('ecec404e-5c67-46dd-8b8c-5700d246bfa9','6pwfe','2019-05-06 01:22:24'),
('ee790c09-3f3d-45c6-8c67-2db913091366','84afc','2019-05-05 16:22:21'),
('eed199b3-2f01-4162-8c98-e10cf28c335e','327mb','2019-05-06 15:02:22'),
('ef2d97cc-a82a-445b-8ee8-5258fb00d7a7','aan3d','2019-05-06 01:13:34'),
('f2f376af-bf5f-43af-88d3-ff5962e60a32','2dp2n','2019-03-19 10:28:43'),
('f8df0604-33c3-4f40-8f45-7d434b9a5afc','x7ba2','2019-05-06 15:06:05'),
('f8f2f42f-7d13-4ccf-8078-9209704d1865','ac8fn','2019-04-28 16:01:26'),
('f9250e3f-41dd-47bf-8fee-659c43949b81','fyanf','2018-10-22 23:53:41'),
('facd949a-bf82-4622-8309-921e8589ebd3','emfen','2019-05-06 14:52:44'),
('fc8ee156-1d9e-4046-8ffa-81b78e81f244','65ng4','2019-05-09 20:50:25'),
('fca2c9bc-af44-4773-8bef-e14cacacf961','5gfx8','2019-05-05 16:27:09'),
('fd81f44c-2031-472c-80e4-84fbd9c6eb8a','f58nm','2019-03-05 23:05:21'),
('fdc6e00a-5dca-4a50-822b-53fc7a89e8a0','5pyyd','2019-03-28 17:32:09'),
('fe18f743-edb0-47bc-8724-f8fa53b30154','ccpg6','2019-03-07 09:16:58'),
('fe3b5182-5301-465c-8a7b-3c0d3c65d951','5gp8y','2019-07-08 15:23:11');

/*Table structure for table `sys_company` */

CREATE TABLE `sys_company` (
                               `cp_id` bigint(20) NOT NULL AUTO_INCREMENT,
                               `cp_name` varchar(255) DEFAULT NULL COMMENT '企业名称',
                               `ceo` varchar(255) DEFAULT NULL COMMENT 'CEO',
                               `license_url` varchar(255) DEFAULT NULL COMMENT '营业执照',
                               `phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
                               `allow_account` int(11) DEFAULT NULL COMMENT '许可子账号数量',
                               `address` varchar(128) DEFAULT NULL COMMENT '公司地址',
                               KEY `cp_id` (`cp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `sys_company` */

insert  into `sys_company`(`cp_id`,`cp_name`,`ceo`,`license_url`,`phone`,`allow_account`,`address`) values
(1,'品匠装饰','王五',NULL,'11111',1,NULL);

/*Table structure for table `sys_company_menu` */

CREATE TABLE `sys_company_menu` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                    `cp_id` bigint(20) DEFAULT NULL COMMENT '企业id',
                                    `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单id',
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1655 DEFAULT CHARSET=utf8 COMMENT='企业菜单权限';

/*Data for the table `sys_company_menu` */

insert  into `sys_company_menu`(`id`,`cp_id`,`menu_id`) values
(1547,1,31),
(1548,1,247),
(1549,1,248),
(1550,1,32),
(1551,1,33),
(1552,1,34),
(1553,1,35),
(1554,1,228),
(1555,1,246),
(1556,1,229),
(1557,1,230),
(1558,1,231),
(1559,1,232),
(1560,1,151),
(1561,1,152),
(1562,1,153),
(1563,1,154),
(1564,1,155),
(1565,1,181),
(1566,1,182),
(1567,1,183),
(1568,1,184),
(1569,1,185),
(1570,1,186),
(1571,1,56),
(1572,1,234),
(1573,1,236),
(1574,1,57),
(1575,1,58),
(1576,1,59),
(1577,1,60),
(1578,1,61),
(1579,1,235),
(1580,1,62),
(1581,1,63),
(1582,1,64),
(1583,1,65),
(1584,1,106),
(1585,1,233),
(1586,1,107),
(1587,1,108),
(1588,1,109),
(1589,1,110),
(1590,1,141),
(1591,1,142),
(1592,1,143),
(1593,1,144),
(1594,1,145),
(1595,1,161),
(1596,1,162),
(1597,1,163),
(1598,1,164),
(1599,1,165),
(1600,1,189),
(1601,1,200),
(1602,1,201),
(1603,1,202),
(1604,1,203),
(1605,1,204),
(1606,1,86),
(1607,1,87),
(1608,1,88),
(1609,1,89),
(1610,1,90),
(1611,1,101),
(1612,1,102),
(1613,1,103),
(1614,1,104),
(1615,1,105),
(1616,1,195),
(1617,1,196),
(1618,1,197),
(1619,1,198),
(1620,1,199),
(1621,1,126),
(1622,1,245),
(1623,1,127),
(1624,1,128),
(1625,1,129),
(1626,1,130),
(1627,1,207),
(1628,1,208),
(1629,1,209),
(1630,1,210),
(1631,1,211),
(1632,1,3),
(1633,1,19),
(1634,1,20),
(1635,1,21),
(1636,1,22),
(1637,1,46),
(1638,1,244),
(1639,1,47),
(1640,1,48),
(1641,1,49),
(1642,1,212),
(1643,1,36),
(1644,1,37),
(1645,1,38),
(1646,1,39),
(1647,1,40),
(1648,1,156),
(1649,1,157),
(1650,1,158),
(1651,1,159),
(1652,1,160),
(1653,1,-666666),
(1654,1,187);

/*Table structure for table `sys_company_regist` */

CREATE TABLE `sys_company_regist` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                      `cp_name` varchar(256) DEFAULT NULL,
                                      `phone` varchar(256) DEFAULT NULL,
                                      `username` varchar(256) DEFAULT NULL,
                                      `password` varchar(256) DEFAULT NULL,
                                      `email` varchar(256) DEFAULT NULL,
                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_company_regist` */

/*Table structure for table `sys_config` */

CREATE TABLE `sys_config` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT,
                              `param_key` varchar(50) DEFAULT NULL COMMENT 'key',
                              `param_value` varchar(2000) DEFAULT NULL COMMENT 'value',
                              `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
                              `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `param_key` (`param_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';

/*Data for the table `sys_config` */

insert  into `sys_config`(`id`,`param_key`,`param_value`,`status`,`remark`) values
(1,'CLOUD_STORAGE_CONFIG_KEY','{\"type\":2,\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"qiniuBucketName\":\"ios-app\",\"aliyunDomain\":\"https://ttn-decoration.oss-cn-beijing.aliyuncs.com\",\"aliyunPrefix\":\"\",\"aliyunEndPoint\":\"oss-cn-beijing.aliyuncs.com\",\"aliyunAccessKeyId\":\"LTAIcs0qw35pIOGE\",\"aliyunAccessKeySecret\":\"b4vvZHs415JWGUDI0gbyDl92gaeGr6\",\"aliyunBucketName\":\"ttn-decoration\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qcloudBucketName\":\"\"}',0,'云存储配置信息');

/*Table structure for table `sys_dept` */

CREATE TABLE `sys_dept` (
                            `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                            `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门',
                            `name` varchar(50) NOT NULL COMMENT '名称',
                            `order_num` int(11) DEFAULT NULL COMMENT '排序',
                            `cp_id` bigint(20) DEFAULT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='部门';

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`id`,`parent_id`,`name`,`order_num`,`cp_id`) values
(2,9,'综合管理部',1,1),
(3,9,'销售管理部',2,1),
(4,9,'施工部',3,1),
(5,3,'销售一部',1,1),
(6,3,'销售二部',2,1),
(8,4,'施工二部',2,1),
(9,NULL,'天堂鸟信息科技有限公司',1,1),
(10,NULL,'颐舍空间',1,2),
(12,NULL,'流雪科技',1,4),
(13,NULL,'流雪科技',1,5),
(14,NULL,'流雪科技',1,6),
(18,14,'销售部',1,6),
(19,14,'设计部',2,6),
(20,14,'施工部',3,6),
(21,14,'财务部',4,6),
(22,NULL,'bcd7d',1,7),
(23,NULL,'c5fa7',1,8);

/*Table structure for table `sys_dept_view` */

CREATE TABLE `sys_dept_view` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `user_id` bigint(20) NOT NULL,
                                 `view_id` bigint(20) NOT NULL,
                                 `cp_id` bigint(20) DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='部门视野';

/*Data for the table `sys_dept_view` */

insert  into `sys_dept_view`(`id`,`user_id`,`view_id`,`cp_id`) values
(4,10,6,1),
(5,10,4,1),
(6,10,7,1),
(7,10,8,1),
(11,29,14,NULL);

/*Table structure for table `sys_dict` */

CREATE TABLE `sys_dict` (
                            `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                            `type_id` bigint(20) NOT NULL COMMENT '字典类型',
                            `name` varchar(100) NOT NULL COMMENT '名称',
                            `code` varchar(20) DEFAULT NULL COMMENT '编码',
                            `cp_id` bigint(20) DEFAULT NULL,
                            PRIMARY KEY (`id`),
                            KEY `sys_dict_forkey` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8 COMMENT='字典';

/*Data for the table `sys_dict` */

insert  into `sys_dict`(`id`,`type_id`,`name`,`code`,`cp_id`) values
(3,1001,'请假申请','sp01',1),
(8,1001,'用章申请','sp02',1),
(9,1001,'调薪申请','sp03',1),
(10,1001,'转正申请','sp04',1),
(11,1001,'离职申请','sp05',1),
(12,1001,'招聘申请','sp06',1),
(13,1001,'出差申请','sp07',1),
(18,1002,'餐厅','qy01',1),
(19,1002,'卧室','qy02',1),
(20,1002,'厨房','qy03',1),
(21,1002,'卫生间','qy04',1),
(22,1002,'客厅','qy05',1),
(23,1002,'玄关','qy06',1),
(24,1002,'露台','qy07',1),
(25,1002,'阳台','qy08',1),
(26,1002,'书房','qy09',1),
(30,1003,'沟通','yw01',1),
(31,1003,'跟进','yw02',1),
(32,1003,'交定','yw03',1),
(33,1003,'意向','yw04',1),
(34,1003,'设计','yw05',1),
(35,1003,'施工','yw06',1),
(36,1003,'完工','yw07',1),
(37,1003,'自选','ywlx01',1),
(42,1004,'自选','ywlx01',1),
(43,1004,'全包','ywlx02',1),
(44,1004,'半包','ywlx03',1),
(45,1004,'整装','ywlx04',1),
(46,1004,'套装','ywlx05',1),
(47,1004,'公装','ywlx06',1),
(48,1005,'电话销售','cs01',1),
(49,1005,'网销','cs02',1),
(50,1005,'老客户介绍','cs03',1),
(51,1005,'活动','cs04',1),
(52,1005,'上门','cs05',1),
(53,1005,'小区开发','cs06',1),
(54,1005,'回头客','cs07',1),
(55,1005,'其他','cs08',1),
(56,1005,'百度','cs09',1),
(57,1006,'新房装修','ct01',1),
(58,1006,'90平米以下','ct02',1),
(59,1006,'二手房翻新','ct03',1),
(60,1006,'160平以上','ct04',1),
(61,1006,'90-160平','ct05',1),
(62,1006,'局部装修','ct06',1),
(63,1006,'跃层','ct07',1),
(64,1006,'软装客户','ct08',1),
(65,1006,'别墅','ct09',1),
(66,1006,'设计客户','ct10',1),
(67,1006,'纯施工客户','ct11',1),
(68,1006,'公装客户','ct12',1),
(69,1007,'阳台质量','ts01',1),
(70,1007,'厨房质量','ts02',1),
(71,1007,'卫生间质量','ts03',1),
(72,1008,'价格原因','td01',1),
(73,1008,'服务不到位','td02',1),
(74,1008,'装修时间问题','td03',1),
(75,1008,'客户选择其他','td04',1),
(76,1008,'其他原因','td05',1),
(77,1008,'设计不满意','td06',1),
(78,1008,'合同不满意','td07',1),
(79,1008,'材料不满意','td08',1),
(80,1008,'施工不满意','td09',1),
(81,1008,'客户自己装修','td10',1),
(82,1009,'户型图','ft01',1),
(83,1009,'平面图','ft02',1),
(84,1009,'效果图','ft03',1),
(85,1010,'材料','gt01',1),
(86,1010,'半成品','gt02',1),
(87,1010,'商品','gt03',1),
(88,1010,'辅材','gt04',1),
(89,1011,'平层结构','ht01',1),
(90,1011,'跃层结构','ht02',1),
(91,1011,'复式结构','ht03',1),
(92,1011,'别墅型','ht04',1),
(93,1012,'设计文件','pf01',1),
(94,1012,'施工文件','pf02',1),
(95,1012,'竣工文件','pf03',1),
(96,1012,'其他文件','pf04',1),
(97,1013,'原墙、地、顶面砂浆粉刷层是否有空鼓，厨、卫抹灰层是否采用水泥砂浆','lf01',1),
(98,1013,'墙、顶、地面平整度','lf02',1),
(99,1013,'卫生间漏水试验，天顶是否漏水','lf03',1),
(100,1013,'墙与墙、墙与顶的角尺度','lf04',1),
(101,1013,'原始墙面批灰硬度','lf05',1),
(102,1013,'顶、地面水平差','lf06',1),
(103,1013,'门框、窗框垂直度及尺寸','lf07',1),
(104,1013,'厨卫墙面空鼓率','lf08',1),
(105,1013,'上水系统有无渗漏，出水系统是否畅通，是否固定牢靠','lf09',1),
(106,1013,'下水系统落水试验是否畅通','lf10',1),
(107,1013,'烟道是否有裂缝、残损','lf11',1),
(108,1013,'阳台、墙体、地面是否有裂缝、渗水','lf12',1),
(109,1014,'好评','pj01',1),
(110,1014,'一般','pj02',1),
(111,1014,'差评','pj03',1),
(112,1015,'定额项目','bg01',1),
(113,1015,'材料项目','bg02',1),
(114,1015,'费用项目','bg03',1),
(116,1016,'营销公海池','gh01',1),
(117,1016,'网络营销公海池','gh02',1),
(118,1016,'小区营销公海池','gh03',1),
(119,1016,'电话营销公海池','gh04',1),
(120,1017,'定金','sz01',1),
(121,1017,'预付款','sz02',1),
(122,1017,'尾款','sz03',1),
(123,1017,'材料款','sz04',1),
(124,1017,'承包款','sz05',1),
(125,1017,'工程款','sz06',1),
(126,1018,'微信','zf01',1),
(127,1018,'支付宝','zf02',1),
(128,1018,'现金','zf03',1),
(129,1018,'转账','zf04',1),
(130,1019,'卧室方案','fa01',1),
(131,1019,'卫生间方案','fa02',1),
(132,1019,'厨房方案','fa03',1),
(133,1019,'阳台方案','fa04',1),
(134,1019,'衣帽间方案','fa05',1),
(135,1019,'储物间方案','fa06',1),
(136,1020,'北欧','fg01',1),
(137,1020,'日式','fg02',1),
(138,1020,'美式','fg03',1),
(139,1020,'中式','fg04',1),
(140,1020,'法式','fg05',1),
(141,1020,'工业风','fg06',1),
(142,1020,'宜家','fg07',1),
(143,1020,'简约','fg08',1),
(144,1020,'田园','fg09',1),
(145,1020,'乡村','fg10',1),
(146,1020,'复古','fg11',1),
(147,1020,'新中式','fg12',1),
(148,1021,'定金款','kx01',1),
(149,1021,'首期款','kx02',1),
(150,1021,'中期款','kx03',1),
(151,1021,'合同尾款','kx04',1),
(152,1022,'餐桌','bx01',1),
(153,1022,'地板','bx02',1),
(154,1022,'墙面','bx03',1),
(155,1022,'马桶','bx04',1),
(156,1023,'设计师巡检','xj01',1),
(157,1023,'日常巡检','xj02',1),
(158,1023,'监理巡检','xj03',1),
(159,1024,'一室一厅','rt01',1),
(160,1024,'两室两厅','rt02',1),
(161,1024,'两室一厅','rt03',1),
(162,1024,'三室两厅','rt04',1),
(163,1024,'三室三厅','rt05',1),
(164,1024,'五室两厅','rt06',1),
(165,1024,'五室三厅','rt07',1),
(166,1025,'重要紧急','jj01',1),
(167,1025,'紧急不重要','jj02',1),
(168,1025,'重要不紧急','jj03',1),
(169,1025,'不紧急不重要','jj04',1),
(170,1026,'水电工','wt01',1),
(171,1026,'瓦工','wt02',1),
(172,1026,'木工','wt03',1),
(173,1026,'油漆工','wt04',1),
(174,1026,'杂工','wt05',1),
(175,1026,'保洁','wt06',1),
(176,1026,'搬运','wt07',1),
(177,1026,'家具安装工','wt08',1),
(178,1026,'泥工','wt09',1),
(179,1026,'敲墙','wt10',1),
(180,1027,'清单报价模板','ys01',1),
(181,1027,'套餐报价模板','ys02',1),
(183,1026,'电工',NULL,6),
(184,1027,'全包',NULL,6),
(185,1026,'瓦工','1',6),
(186,1026,'油漆工',NULL,6),
(187,1002,'厨房',NULL,6),
(188,1002,'卧室',NULL,6),
(189,1002,'客厅',NULL,6),
(190,1027,'半包','1',6),
(191,1027,'模板','01',8),
(192,1027,'单一客户','02',8);

/*Table structure for table `sys_dict_type` */

CREATE TABLE `sys_dict_type` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                 `name` varchar(50) NOT NULL COMMENT 'name',
                                 `order_num` int(11) NOT NULL DEFAULT '0' COMMENT 'order_num',
                                 `remark` varchar(300) DEFAULT NULL COMMENT 'remark',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1028 DEFAULT CHARSET=utf8 COMMENT='字典类型';

/*Data for the table `sys_dict_type` */

insert  into `sys_dict_type`(`id`,`name`,`order_num`,`remark`) values
(1002,'房间区域',2,'房间的区域如：餐厅，卧室，厨房等'),
(1003,'业务阶段',3,'整个项目的全阶段如：意向-》设计-》施工。。'),
(1004,'业务类型',0,'客户选择的装修方式，如：全包，半包等'),
(1005,'客户来源',0,'客户来源渠道，如：电话销售，网销，老客户介绍等'),
(1006,'客户类型',0,'客户的需求类型，如：新房装修，二手房翻新等'),
(1008,'逃单类型',0,'潜在客户逃单原因类型'),
(1010,'商品类型',0,'材料，辅材等'),
(1011,'房型',0,'房型'),
(1024,'户型',0,'户型'),
(1026,'工种',0,'工种'),
(1027,'报价表类型',1,'报价表类型');

/*Table structure for table `sys_log` */

CREATE TABLE `sys_log` (
                           `id` bigint(20) NOT NULL AUTO_INCREMENT,
                           `username` varchar(50) DEFAULT NULL COMMENT '用户名',
                           `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
                           `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
                           `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
                           `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
                           `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
                           `create_date` datetime DEFAULT NULL COMMENT '创建时间',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=564 DEFAULT CHARSET=utf8 COMMENT='系统日志';

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values
(1,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":1,\"roleName\":\"企业主\",\"remark\":\"企业拥有的所有权限\",\"createUserId\":1,\"menuIdList\":[2,15,16,17,18,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,-666666,1],\"createTime\":\"Oct 13, 2018 1:26:09 AM\"}]',102,'0:0:0:0:0:0:0:1','2018-10-13 01:26:09'),
(2,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":2,\"roleName\":\"销售\",\"remark\":\"\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"Oct 13, 2018 1:26:57 AM\"}]',6,'0:0:0:0:0:0:0:1','2018-10-13 01:26:58'),
(3,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":3,\"roleName\":\"设计师\",\"remark\":\"\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"Oct 13, 2018 1:27:03 AM\"}]',15,'0:0:0:0:0:0:0:1','2018-10-13 01:27:03'),
(4,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":4,\"roleName\":\"项目经理\",\"remark\":\"\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"Oct 13, 2018 1:27:34 AM\"}]',31,'0:0:0:0:0:0:0:1','2018-10-13 01:27:34'),
(5,'admin','暂停定时任务','io.ttn.modules.job.controller.ScheduleJobController.pause()','[[1]]',11,'0:0:0:0:0:0:0:1','2018-10-16 23:05:01'),
(6,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"admin\",\"orderNum\":1}]',12,'0:0:0:0:0:0:0:1','2018-10-17 00:43:29'),
(7,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":106,\"parentId\":186,\"name\":\"客户公海池\",\"url\":\"sys/seaclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',15,'0:0:0:0:0:0:0:1','2018-10-17 00:43:56'),
(8,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":56,\"parentId\":186,\"name\":\"我的客户\",\"url\":\"sys/formalclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'0:0:0:0:0:0:0:1','2018-10-17 00:44:07'),
(9,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":141,\"parentId\":186,\"name\":\"预约客户\",\"url\":\"sys/preclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'0:0:0:0:0:0:0:1','2018-10-17 00:44:23'),
(10,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":161,\"parentId\":186,\"name\":\"客户记录\",\"url\":\"sys/clientinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',18,'0:0:0:0:0:0:0:1','2018-10-17 00:44:42'),
(11,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":61,\"parentId\":186,\"name\":\"逃单客户\",\"url\":\"sys/escapeclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',9,'0:0:0:0:0:0:0:1','2018-10-17 00:45:14'),
(12,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":187,\"parentId\":0,\"name\":\"业务配置\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":0}]',10,'0:0:0:0:0:0:0:1','2018-10-17 00:46:07'),
(13,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":136,\"parentId\":187,\"name\":\"售前阶段\",\"url\":\"sys/presale\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'0:0:0:0:0:0:0:1','2018-10-17 00:46:28'),
(14,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":187,\"parentId\":0,\"name\":\"业务配置\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":2}]',5,'0:0:0:0:0:0:0:1','2018-10-17 00:46:33'),
(15,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":156,\"parentId\":187,\"name\":\"小区维护\",\"url\":\"sys/community\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',11,'0:0:0:0:0:0:0:1','2018-10-17 00:46:49'),
(16,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":86,\"parentId\":187,\"name\":\"业绩目标\",\"url\":\"sys/target\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'0:0:0:0:0:0:0:1','2018-10-17 00:47:03'),
(17,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":171,\"parentId\":187,\"name\":\"考勤管理\",\"url\":\"sys/attendance\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'0:0:0:0:0:0:0:1','2018-10-17 00:47:23'),
(18,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":188,\"parentId\":0,\"name\":\"模板配置\",\"type\":0,\"icon\":\"log\",\"orderNum\":3}]',13,'0:0:0:0:0:0:0:1','2018-10-17 00:48:09'),
(19,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":176,\"parentId\":188,\"name\":\"验收类别\",\"url\":\"sys/accepttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'0:0:0:0:0:0:0:1','2018-10-17 00:48:28'),
(20,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":181,\"parentId\":188,\"name\":\"验收模板\",\"url\":\"sys/accepttemplet\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'0:0:0:0:0:0:0:1','2018-10-17 00:48:38'),
(21,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":146,\"parentId\":188,\"name\":\"施工计划类别\",\"url\":\"sys/plantype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 00:48:52'),
(22,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":188,\"name\":\"施工计划模板\",\"url\":\"sys/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'0:0:0:0:0:0:0:1','2018-10-17 00:49:02'),
(23,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业体系架构\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":4}]',9,'0:0:0:0:0:0:0:1','2018-10-17 00:50:03'),
(24,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":101,\"parentId\":189,\"name\":\"客户服务术语\",\"url\":\"sys/servingtech\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'0:0:0:0:0:0:0:1','2018-10-17 00:50:22'),
(25,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":190,\"parentId\":189,\"name\":\"员工列表\",\"url\":\"tx/sysemployee\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'0:0:0:0:0:0:0:1','2018-10-17 00:54:36'),
(26,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":195,\"parentId\":189,\"name\":\"离职员工\",\"url\":\"tx/sysretired\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'0:0:0:0:0:0:0:1','2018-10-17 00:54:46'),
(27,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"公司职位\",\"url\":\"tx/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',9,'0:0:0:0:0:0:0:1','2018-10-17 00:54:58'),
(28,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":205,\"parentId\":0,\"name\":\"进销存管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"sql\",\"orderNum\":5}]',9,'0:0:0:0:0:0:0:1','2018-10-17 00:55:45'),
(29,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":205,\"name\":\"工程分类\",\"url\":\"sys/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'0:0:0:0:0:0:0:1','2018-10-17 00:55:59'),
(30,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":131,\"parentId\":205,\"name\":\"工程列表\",\"url\":\"sys/project\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',5,'0:0:0:0:0:0:0:1','2018-10-17 00:56:11'),
(31,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":46,\"parentId\":205,\"name\":\"材料分类\",\"url\":\"sys/materialtype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 00:56:22'),
(32,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":51,\"parentId\":205,\"name\":\"材料列表\",\"url\":\"sys/material\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',9,'0:0:0:0:0:0:0:1','2018-10-17 00:56:34'),
(33,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":121,\"parentId\":205,\"name\":\"单据类型维护\",\"url\":\"sys/receipt\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 00:56:48'),
(34,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":96,\"parentId\":205,\"name\":\"仓库管理\",\"url\":\"sys/store\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',11,'0:0:0:0:0:0:0:1','2018-10-17 00:57:00'),
(35,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":166,\"parentId\":205,\"name\":\"品牌维护\",\"url\":\"sys/brand\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'0:0:0:0:0:0:0:1','2018-10-17 00:57:15'),
(36,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":91,\"parentId\":205,\"name\":\"供应商管理\",\"url\":\"sys/supplier\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 00:57:29'),
(37,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":206,\"parentId\":0,\"name\":\"日常管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"bianji\",\"orderNum\":0}]',9,'0:0:0:0:0:0:0:1','2018-10-17 01:01:59'),
(38,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":66,\"parentId\":206,\"name\":\"施工日志\",\"url\":\"sys/constructionlog\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 01:02:23'),
(39,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":71,\"parentId\":206,\"name\":\"投诉消息记录\",\"url\":\"sys/complaintinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',9,'0:0:0:0:0:0:0:1','2018-10-17 01:02:33'),
(40,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":76,\"parentId\":206,\"name\":\"投诉管理\",\"url\":\"sys/complaint\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 01:02:43'),
(41,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":116,\"parentId\":206,\"name\":\"报修管理\",\"url\":\"sys/repair\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 01:02:53'),
(42,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":111,\"parentId\":206,\"name\":\"报修管理消息记录\",\"url\":\"sys/repairinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-17 01:03:06'),
(43,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":81,\"parentId\":206,\"name\":\"任务\",\"url\":\"tx/task\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',18,'0:0:0:0:0:0:0:1','2018-10-17 01:23:38'),
(44,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"组织机构管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":4}]',12,'0:0:0:0:0:0:0:1','2018-10-19 00:26:40'),
(45,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"组织机构管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":0}]',14,'0:0:0:0:0:0:0:1','2018-10-19 00:26:50'),
(46,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":189,\"name\":\"部门管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',16,'0:0:0:0:0:0:0:1','2018-10-19 00:27:37'),
(47,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":2,\"parentId\":189,\"name\":\"管理员列表\",\"url\":\"sys/user\",\"type\":1,\"icon\":\"admin\",\"orderNum\":1}]',13,'0:0:0:0:0:0:0:1','2018-10-19 00:27:55'),
(48,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":189,\"name\":\"角色管理\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2}]',16,'0:0:0:0:0:0:0:1','2018-10-19 00:28:10'),
(49,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":36,\"parentId\":189,\"name\":\"字典管理\",\"url\":\"sys/dict\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'0:0:0:0:0:0:0:1','2018-10-19 00:29:08'),
(50,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":189,\"name\":\"系统角色管理\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2}]',16,'0:0:0:0:0:0:0:1','2018-10-19 00:32:23'),
(51,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":42,\"parentId\":41,\"name\":\"查看\",\"perms\":\"sys:dicttype:list,sys:dicttype:info\",\"type\":2,\"orderNum\":6}]',16,'0:0:0:0:0:0:0:1','2018-10-19 00:43:10'),
(52,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[1]]',1,'0:0:0:0:0:0:0:1','2018-10-20 01:37:39'),
(53,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":2,\"username\":\"11\",\"password\":\"d95b1bae45e5029f5e4fa587c6cc50a180cb117d2a0dcba3887d8a6bdc2f9c29\",\"salt\":\"nQgWrAID1xmrFHnSfo5A\",\"email\":\"493804781@qq.com\",\"mobile\":\"18262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:44:39 AM\"}]',96,'0:0:0:0:0:0:0:1','2018-10-20 01:44:39'),
(54,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":3,\"username\":\"22\",\"password\":\"17871882869e6b6fbf1d9f43760595068c3ebd2914642cd487ff9eea63d43654\",\"salt\":\"ruESwE8fmwd65fzZjGtg\",\"email\":\"493804781@qq.com\",\"mobile\":\"18262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:45:12 AM\"}]',12,'0:0:0:0:0:0:0:1','2018-10-20 01:45:12'),
(55,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":4,\"username\":\"33\",\"password\":\"3aece7ca06bd134e003ff1d1d6d692340a8f23166a9a46c3aa40a0baa8f52bb0\",\"salt\":\"TNPYLcIQOi4RtCyKdWSr\",\"email\":\"493804781@qq.com\",\"mobile\":\"17262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:45:33 AM\"}]',17,'0:0:0:0:0:0:0:1','2018-10-20 01:45:34'),
(56,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":5,\"username\":\"44\",\"password\":\"03fabdeef6de6f9fad85036ee3b6618be8071892052fd7bcf54968b8cfb04b68\",\"salt\":\"WdNjDuuihn68AAHzg1Ey\",\"email\":\"493804781@qq.com\",\"mobile\":\"17652250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:45:48 AM\"}]',14,'0:0:0:0:0:0:0:1','2018-10-20 01:45:49'),
(57,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":6,\"username\":\"66\",\"password\":\"db89c99d753f46eab82f40278aa0a75daa99a26308ef9d3abc3cc54ef5261896\",\"salt\":\"tK5i3lqSuHPTgjaINKdR\",\"email\":\"493804781@qq.com\",\"mobile\":\"17262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:46:04 AM\"}]',15,'0:0:0:0:0:0:0:1','2018-10-20 01:46:04'),
(58,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":7,\"username\":\"77\",\"password\":\"1ae6657c814b92b60f565eacb54476d3add33e8be72cc26f95fa3c9699c41f0b\",\"salt\":\"66V8WCcmlBtmNG3JZEuW\",\"email\":\"493804781@qq.com\",\"mobile\":\"18262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:46:17 AM\"}]',13,'0:0:0:0:0:0:0:1','2018-10-20 01:46:17'),
(59,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":8,\"username\":\"222\",\"password\":\"18c1e5937ee26c62691d07f0e780ce8c270b78eb0750cf941ae787f4eb5c34ce\",\"salt\":\"vgRn5Jusrbhkjkfs1AQd\",\"email\":\"493804781@qq.com\",\"mobile\":\"17262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1,\"createTime\":\"Oct 20, 2018 1:46:34 AM\"}]',14,'0:0:0:0:0:0:0:1','2018-10-20 01:46:34'),
(60,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":1,\"username\":\"admin\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"email\":\"root@ttn.io\",\"mobile\":\"17625820115\",\"status\":1,\"roleIdList\":[],\"createUserId\":1}]',158,'0:0:0:0:0:0:0:1','2018-10-22 22:50:15'),
(61,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":2,\"username\":\"赵楠\",\"salt\":\"nQgWrAID1xmrFHnSfo5A\",\"email\":\"493804781@qq.com\",\"mobile\":\"18262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1}]',31,'0:0:0:0:0:0:0:1','2018-10-22 23:01:05'),
(62,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":3,\"username\":\"王虎\",\"salt\":\"ruESwE8fmwd65fzZjGtg\",\"email\":\"493804781@qq.com\",\"mobile\":\"18262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1}]',15,'0:0:0:0:0:0:0:1','2018-10-22 23:01:12'),
(63,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":4,\"username\":\"李崇\",\"salt\":\"TNPYLcIQOi4RtCyKdWSr\",\"email\":\"493804781@qq.com\",\"mobile\":\"17262250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1}]',30,'0:0:0:0:0:0:0:1','2018-10-22 23:01:25'),
(64,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":5,\"username\":\"将明伟\",\"salt\":\"WdNjDuuihn68AAHzg1Ey\",\"email\":\"493804781@qq.com\",\"mobile\":\"17652250807\",\"status\":1,\"roleIdList\":[1],\"createUserId\":1}]',21,'0:0:0:0:0:0:0:1','2018-10-22 23:01:33'),
(65,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位\",\"url\":\"tx/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'0:0:0:0:0:0:0:1','2018-10-22 23:12:34'),
(66,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":1,\"deptId\":9,\"username\":\"admin\",\"mobile\":\"17625820115\",\"job\":\"老板\",\"entry\":\"Oct 23, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[]}]',142,'0:0:0:0:0:0:0:1','2018-10-23 00:42:15'),
(67,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":2,\"deptId\":5,\"username\":\"赵楠\",\"mobile\":\"18262250807\",\"job\":\"销售\",\"entry\":\"Oct 22, 2018 12:00:00 AM\",\"ifOn\":false,\"roleIdList\":[2]}]',42,'0:0:0:0:0:0:0:1','2018-10-23 00:43:09'),
(68,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":2,\"deptId\":2,\"username\":\"赵楠\",\"mobile\":\"18262250807\",\"job\":\"销售\",\"entry\":\"Oct 22, 2018 12:00:00 AM\",\"ifOn\":false,\"roleIdList\":[2]}]',23,'0:0:0:0:0:0:0:1','2018-10-23 00:45:57'),
(69,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":2,\"deptId\":7,\"username\":\"赵楠\",\"mobile\":\"18262250807\",\"job\":\"销售\",\"entry\":\"Oct 22, 2018 12:00:00 AM\",\"ifOn\":false,\"roleIdList\":[2]}]',23,'0:0:0:0:0:0:0:1','2018-10-23 00:46:33'),
(70,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":2,\"deptId\":7,\"username\":\"赵楠\",\"mobile\":\"18262250807\",\"job\":\"销售\",\"entry\":\"Oct 22, 2018 12:00:00 AM\",\"ifOn\":false,\"roleIdList\":[2]}]',190,'0:0:0:0:0:0:0:1','2018-10-23 01:09:53'),
(71,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":9,\"deptId\":2,\"username\":\"ces\",\"password\":\"d2c4880b809f35bb8a36f349dff7ee6b41937adea0a5a31b8300a1f2b951f26a\",\"salt\":\"Ge3GYqwG7eYRQ0vVtlBL\",\"mobile\":\"17625820115\",\"job\":\"ces\",\"entry\":\"Oct 1, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[],\"positionList\":[]}]',33,'0:0:0:0:0:0:0:1','2018-10-23 01:10:18'),
(72,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":5,\"roleName\":\"工人\",\"remark\":\"工人\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"Oct 23, 2018 11:39:36 PM\"}]',210,'0:0:0:0:0:0:0:1','2018-10-23 23:39:37'),
(73,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":6,\"roleName\":\"客服\",\"remark\":\"客服\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"Oct 23, 2018 11:40:03 PM\"}]',22,'0:0:0:0:0:0:0:1','2018-10-23 23:40:03'),
(74,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":7,\"roleName\":\"供应商\",\"remark\":\"供应商\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"Oct 23, 2018 11:40:27 PM\"}]',44,'0:0:0:0:0:0:0:1','2018-10-23 23:40:27'),
(75,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"测试\",\"mobile\":\"13291386202\",\"job\":\"测试\",\"entry\":\"Oct 3, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1],\"positionList\":[1]}]',238,'127.0.0.1','2018-10-25 21:03:10'),
(76,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":10,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"测试2\",\"password\":\"9d712d39e446b9e14f04d2623f9568a9579a8a8abb374d168396bad0c334db58\",\"salt\":\"ofnR1yPGJX86MkriiGfy\",\"mobile\":\"13291386202\",\"job\":\"厕所2\",\"entry\":\"Oct 9, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1,2],\"positionList\":[1,3]}]',1088851,'127.0.0.1','2018-10-25 21:22:39'),
(77,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":13,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"试试\",\"password\":\"c42f33864332c0e7dfef060262faf54c9be05e40a30b07cd77e1bd6d0d03ad57\",\"salt\":\"Gl0ta1rkm94UqoPPIwhi\",\"mobile\":\"17825410012\",\"job\":\"试试\",\"entry\":\"Oct 3, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1,2],\"positionList\":[1,3]}]',9289,'127.0.0.1','2018-10-25 21:26:34'),
(78,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[3]]',13,'127.0.0.1','2018-10-26 00:23:10'),
(79,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[4]]',16,'127.0.0.1','2018-10-26 00:23:14'),
(80,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[5]]',4,'127.0.0.1','2018-10-26 00:23:16'),
(81,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[6]]',13,'127.0.0.1','2018-10-26 00:23:19'),
(82,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[7]]',13,'127.0.0.1','2018-10-26 00:23:21'),
(83,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[8]]',12,'127.0.0.1','2018-10-26 00:23:24'),
(84,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":2,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"赵楠\",\"password\":\"d95b1bae45e5029f5e4fa587c6cc50a180cb117d2a0dcba3887d8a6bdc2f9c29\",\"salt\":\"nQgWrAID1xmrFHnSfo5A\",\"mobile\":\"18262250807\",\"job\":\"销售\",\"entry\":\"Oct 22, 2018 12:00:00 AM\",\"ifOn\":false,\"roleIdList\":[1,5],\"positionIdList\":[3,4]}]',135,'127.0.0.1','2018-10-26 01:19:50'),
(85,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":16,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"赵楠\",\"password\":\"b950c8038f8d34d5378dfa0dfa673c82586c13d30bff487af3a9662bce7f5fbe\",\"salt\":\"3GyrQGc25TwrEZi0MDw6\",\"mobile\":\"13201020305\",\"job\":\"销售\",\"entry\":\"Oct 22, 2018 12:00:00 AM\",\"ifOn\":false,\"roleIdList\":[1,5],\"positionIdList\":[3,4]}]',42,'127.0.0.1','2018-10-26 01:21:49'),
(86,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":10,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"测试2\",\"password\":\"9d712d39e446b9e14f04d2623f9568a9579a8a8abb374d168396bad0c334db58\",\"salt\":\"ofnR1yPGJX86MkriiGfy\",\"mobile\":\"13291386202\",\"job\":\"厕所2\",\"entry\":\"Oct 9, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1,2],\"positionIdList\":[3,4]}]',7615,'127.0.0.1','2018-10-26 01:23:06'),
(87,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":10,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"测试2\",\"password\":\"9d712d39e446b9e14f04d2623f9568a9579a8a8abb374d168396bad0c334db58\",\"salt\":\"ofnR1yPGJX86MkriiGfy\",\"mobile\":\"13291386202\",\"job\":\"厕所2\",\"entry\":\"Oct 9, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1,2],\"positionIdList\":[3,4]}]',2,'127.0.0.1','2018-10-26 01:24:59'),
(88,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[[2]]',16,'127.0.0.1','2018-10-26 01:25:34'),
(89,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":10,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"测试2\",\"password\":\"9d712d39e446b9e14f04d2623f9568a9579a8a8abb374d168396bad0c334db58\",\"salt\":\"ofnR1yPGJX86MkriiGfy\",\"mobile\":\"13291386202\",\"job\":\"厕所2\",\"entry\":\"Oct 9, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1,2],\"positionIdList\":[4,3]}]',31,'127.0.0.1','2018-10-26 01:25:39'),
(90,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":9,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"ces\",\"password\":\"d2c4880b809f35bb8a36f349dff7ee6b41937adea0a5a31b8300a1f2b951f26a\",\"salt\":\"Ge3GYqwG7eYRQ0vVtlBL\",\"mobile\":\"17262250808\",\"job\":\"ces\",\"entry\":\"Oct 1, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[4,5,6],\"positionIdList\":[4,3]}]',24,'127.0.0.1','2018-10-26 01:25:49'),
(91,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":1,\"deptId\":9,\"deptName\":\"天堂鸟信息科技有限公司\",\"username\":\"admin\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"mobile\":\"17625820115\",\"job\":\"老板\",\"entry\":\"Oct 23, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1],\"positionIdList\":[]}]',20,'127.0.0.1','2018-10-26 01:26:02'),
(92,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":32,\"parentId\":31,\"name\":\"查看\",\"perms\":\"sys:dept:list,sys:dept:info,sys:user:list,sys:user:info\",\"type\":2,\"orderNum\":6}]',21,'127.0.0.1','2018-10-26 14:46:37'),
(93,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":33,\"parentId\":31,\"name\":\"新增\",\"perms\":\"sys:dept:save,sys:user:save,sys:role:select\",\"type\":2,\"orderNum\":6}]',14,'127.0.0.1','2018-10-26 14:47:10'),
(94,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":34,\"parentId\":31,\"name\":\"修改\",\"perms\":\"sys:dept:update,sys:user:update,sys:role:select\",\"type\":2,\"orderNum\":6}]',12,'127.0.0.1','2018-10-26 14:47:23'),
(95,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":35,\"parentId\":31,\"name\":\"删除\",\"perms\":\"sys:dept:delete,sys:user:delete\",\"type\":2,\"orderNum\":6}]',12,'127.0.0.1','2018-10-26 14:47:39'),
(96,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[18]',0,'127.0.0.1','2018-10-26 14:47:52'),
(97,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[18]',33,'127.0.0.1','2018-10-26 14:48:25'),
(98,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[17]',10,'127.0.0.1','2018-10-26 14:49:27'),
(99,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[16]',26,'127.0.0.1','2018-10-26 14:49:30'),
(100,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[15]',10,'127.0.0.1','2018-10-26 14:49:32'),
(101,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[2]',15,'127.0.0.1','2018-10-26 14:49:39'),
(102,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[191]',17,'127.0.0.1','2018-10-26 14:56:36'),
(103,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[192]',12,'127.0.0.1','2018-10-26 14:56:38'),
(104,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[193]',13,'127.0.0.1','2018-10-26 14:56:40'),
(105,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[194]',6,'127.0.0.1','2018-10-26 14:56:42'),
(106,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[190]',6,'127.0.0.1','2018-10-26 14:56:44'),
(107,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":189,\"name\":\"角色管理\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2}]',12,'127.0.0.1','2018-10-26 14:57:25'),
(108,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位\",\"url\":\"tx/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3}]',4,'127.0.0.1','2018-10-26 14:57:45'),
(109,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{}]',18,'127.0.0.1','2018-10-26 23:02:14'),
(110,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{}]',6,'127.0.0.1','2018-10-26 23:03:05'),
(111,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"positionIdList\":[3,1],\"userIdList\":[10,13]}]',24653,'127.0.0.1','2018-10-26 23:16:09'),
(112,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"positionIdList\":[4,1],\"userIdList\":[10,13]}]',34,'127.0.0.1','2018-10-26 23:17:47'),
(113,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"positionIdList\":[4,3],\"userIdList\":[10,13]}]',39,'127.0.0.1','2018-10-26 23:18:26'),
(114,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"roleIdList\":[5,6],\"userIdList\":[10,13]}]',40,'127.0.0.1','2018-10-26 23:19:47'),
(115,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":13,\"roleIdList\":[2,3]}]',51,'127.0.0.1','2018-10-26 23:44:39'),
(116,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":10,\"roleIdList\":[5,6,7]}]',28,'127.0.0.1','2018-10-26 23:49:50'),
(117,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":10,\"roleIdList\":[5,6,7,4,2,3]}]',32,'127.0.0.1','2018-10-26 23:49:57'),
(118,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":10,\"roleIdList\":[6,7]}]',17,'127.0.0.1','2018-10-26 23:50:03'),
(119,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"userId\":10,\"positionIdList\":[4,3,1]}]',28,'127.0.0.1','2018-10-26 23:52:10'),
(120,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"userId\":10,\"positionIdList\":[3,1]}]',18,'127.0.0.1','2018-10-26 23:52:14'),
(121,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[10,13]}]',19,'127.0.0.1','2018-10-26 23:54:57'),
(122,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[1,2,10]}]',31,'127.0.0.1','2018-10-26 23:58:45'),
(123,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[3,4,5,13,16]}]',19,'127.0.0.1','2018-10-26 23:59:02'),
(124,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[6,7,8,9,10,16]}]',21893,'127.0.0.1','2018-10-27 00:02:11'),
(125,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[10]}]',7407,'127.0.0.1','2018-10-27 00:13:13'),
(126,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[10,13,16]}]',14,'127.0.0.1','2018-10-27 00:13:26'),
(127,'admin','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":10,\"personViewIdList\":[10]}]',18,'127.0.0.1','2018-10-27 00:13:32'),
(128,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10}]',4,'127.0.0.1','2018-10-27 00:13:47'),
(129,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10}]',4302,'127.0.0.1','2018-10-27 00:19:36'),
(130,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10,\"deptViewIdList\":[]}]',6334,'127.0.0.1','2018-10-27 00:20:36'),
(131,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10,\"deptViewIdList\":[]}]',3897,'127.0.0.1','2018-10-27 00:25:01'),
(132,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10,\"deptViewIdList\":[]}]',22419,'127.0.0.1','2018-10-27 00:29:13'),
(133,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10,\"deptViewIdList\":[4,7,8]}]',8508,'127.0.0.1','2018-10-27 00:32:49'),
(134,'admin','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":10,\"deptViewIdList\":[6,4,7,8]}]',17,'127.0.0.1','2018-10-27 00:36:05'),
(135,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[9]',32,'127.0.0.1','2018-10-27 00:55:12'),
(136,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":10,\"roleIdList\":[6,7,5]}]',38,'127.0.0.1','2018-10-27 00:55:27'),
(137,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"userId\":10,\"positionIdList\":[3,1]}]',19,'127.0.0.1','2018-10-27 00:55:32'),
(138,'admin','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"userId\":16,\"positionIdList\":[4]}]',16,'127.0.0.1','2018-10-27 00:56:26'),
(139,'admin','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":16,\"roleIdList\":[1,5,6]}]',40,'127.0.0.1','2018-10-27 00:56:30'),
(140,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":46,\"parentId\":187,\"name\":\"材料分类\",\"url\":\"tx/materialtype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'127.0.0.1','2018-10-29 13:50:00'),
(141,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":51,\"parentId\":187,\"name\":\"材料列表\",\"url\":\"tx/material\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',8,'127.0.0.1','2018-10-29 13:50:09'),
(142,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":166,\"parentId\":187,\"name\":\"品牌维护\",\"url\":\"tx/brand\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-10-29 13:50:23'),
(143,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":207,\"parentId\":187,\"name\":\"品牌分类\",\"url\":\"tx/brandclass\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-10-29 14:27:29'),
(144,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":208,\"parentId\":207,\"name\":\"查看\",\"perms\":\"tx:brandclass:list,tx:brandclass:info,tx:brand:list,tx:brand:info\",\"type\":2,\"orderNum\":6}]',19,'127.0.0.1','2018-10-29 18:32:25'),
(145,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":209,\"parentId\":207,\"name\":\"新增\",\"perms\":\"tx:brandclass:save,tx:brand:save\",\"type\":2,\"orderNum\":6}]',14,'127.0.0.1','2018-10-29 18:32:37'),
(146,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":210,\"parentId\":207,\"name\":\"修改\",\"perms\":\"tx:brand:update\",\"type\":2,\"orderNum\":6}]',13,'127.0.0.1','2018-10-29 18:32:49'),
(147,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":210,\"parentId\":207,\"name\":\"修改\",\"perms\":\"tx:brand:update,tx:brandclass:update\",\"type\":2,\"orderNum\":6}]',12,'127.0.0.1','2018-10-29 18:33:07'),
(148,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":211,\"parentId\":207,\"name\":\"删除\",\"perms\":\"tx:brandclass:delete,tx:brand:delete\",\"type\":2,\"orderNum\":6}]',13,'127.0.0.1','2018-10-29 18:33:13'),
(149,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[167]',25,'127.0.0.1','2018-10-29 18:33:27'),
(150,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[168]',14,'127.0.0.1','2018-10-29 18:33:30'),
(151,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[169]',13,'127.0.0.1','2018-10-29 18:33:33'),
(152,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[170]',14,'127.0.0.1','2018-10-29 18:33:36'),
(153,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[166]',14,'127.0.0.1','2018-10-29 18:33:40'),
(154,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":207,\"parentId\":187,\"name\":\"品牌维护\",\"url\":\"tx/brandclass\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'127.0.0.1','2018-10-29 18:33:51'),
(155,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":47,\"parentId\":46,\"name\":\"查看\",\"perms\":\"tx:materialtype:list,tx:materialtype:info,tx:material:list,tx:material:info\",\"type\":2,\"orderNum\":6}]',22,'127.0.0.1','2018-10-30 19:01:55'),
(156,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":48,\"parentId\":46,\"name\":\"新增\",\"perms\":\"tx:materialtype:save,tx:material:save\",\"type\":2,\"orderNum\":6}]',6,'127.0.0.1','2018-10-30 19:02:07'),
(157,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":49,\"parentId\":46,\"name\":\"修改\",\"perms\":\"tx:materialtype:update,tx:material:update\",\"type\":2,\"orderNum\":6}]',5,'127.0.0.1','2018-10-30 19:02:13'),
(158,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":50,\"parentId\":46,\"name\":\"删除\",\"perms\":\"tx:materialtype:delete,tx:material:delete\",\"type\":2,\"orderNum\":6}]',7,'127.0.0.1','2018-10-30 19:02:19'),
(159,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[50]',20,'127.0.0.1','2018-10-30 19:02:24'),
(160,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":212,\"parentId\":46,\"name\":\"删除\",\"perms\":\"tx:materialtype:delete\",\"type\":2,\"orderNum\":6}]',8,'127.0.0.1','2018-10-30 19:02:58'),
(161,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":212,\"parentId\":46,\"name\":\"删除\",\"perms\":\"tx:materialtype:delete,tx:material:delete\",\"type\":2,\"orderNum\":6}]',6,'127.0.0.1','2018-10-30 19:03:28'),
(162,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":46,\"parentId\":187,\"name\":\"材料管理\",\"url\":\"tx/materialtype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',8,'127.0.0.1','2018-10-30 19:03:51'),
(163,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[55]',6,'127.0.0.1','2018-10-30 19:03:56'),
(164,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[54]',8,'127.0.0.1','2018-10-30 19:03:58'),
(165,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[53]',6,'127.0.0.1','2018-10-30 19:04:00'),
(166,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[52]',9,'127.0.0.1','2018-10-30 19:04:02'),
(167,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[52]',3,'127.0.0.1','2018-10-30 19:04:06'),
(168,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[51]',8,'127.0.0.1','2018-10-30 19:04:09'),
(169,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":41,\"parentId\":1,\"name\":\"字典类型\",\"url\":\"sys/dict\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',75,'127.0.0.1','2018-11-03 16:04:45'),
(170,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":41,\"parentId\":1,\"name\":\"字典类型\",\"url\":\"sys/dicttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',38,'127.0.0.1','2018-11-05 23:23:19'),
(171,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":207,\"parentId\":187,\"name\":\"品牌维护\",\"url\":\"tx/brandclass\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]',12,'127.0.0.1','2018-11-06 00:24:02'),
(172,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":46,\"parentId\":187,\"name\":\"材料管理\",\"url\":\"tx/materialtype\",\"type\":1,\"icon\":\"config\",\"orderNum\":2}]',10,'127.0.0.1','2018-11-06 00:24:09'),
(173,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":188,\"name\":\"预算定额分类\",\"url\":\"tx/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',32,'127.0.0.1','2018-11-13 20:27:01'),
(174,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":131,\"parentId\":188,\"name\":\"预算定额列表\",\"url\":\"tx/project\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',11,'127.0.0.1','2018-11-13 20:27:16'),
(175,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":127,\"parentId\":126,\"name\":\"查看\",\"perms\":\"tx:projecttype:list,tx:projecttype:info,tx:project:list,tx:project:info\",\"type\":2,\"orderNum\":6}]',12,'127.0.0.1','2018-11-14 00:29:27'),
(176,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":128,\"parentId\":126,\"name\":\"新增\",\"perms\":\"tx:projecttype:save,tx:project:save\",\"type\":2,\"orderNum\":6}]',10,'127.0.0.1','2018-11-14 00:29:36'),
(177,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":129,\"parentId\":126,\"name\":\"修改\",\"perms\":\"tx:projecttype:update,tx:project:update\",\"type\":2,\"orderNum\":6}]',11,'127.0.0.1','2018-11-14 00:29:43'),
(178,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":130,\"parentId\":126,\"name\":\"删除\",\"perms\":\"tx:projecttype:delete,tx:project:delete\",\"type\":2,\"orderNum\":6}]',11,'127.0.0.1','2018-11-14 00:29:49'),
(179,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[135]',22,'127.0.0.1','2018-11-14 00:29:54'),
(180,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[134]',11,'127.0.0.1','2018-11-14 00:29:58'),
(181,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[133]',7,'127.0.0.1','2018-11-14 00:30:01'),
(182,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[132]',12,'127.0.0.1','2018-11-14 00:30:03'),
(183,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[131]',6,'127.0.0.1','2018-11-14 00:30:05'),
(184,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":188,\"name\":\"预算定额\",\"url\":\"tx/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',19,'127.0.0.1','2018-12-12 10:33:51'),
(185,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":43,\"parentId\":41,\"name\":\"新增\",\"perms\":\"sys:dicttype:save\",\"type\":2,\"orderNum\":6}]',18,'127.0.0.1','2018-12-12 11:16:37'),
(186,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":44,\"parentId\":41,\"name\":\"修改\",\"perms\":\"sys:dicttype:update\",\"type\":2,\"orderNum\":6}]',13,'127.0.0.1','2018-12-12 11:16:44'),
(187,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":45,\"parentId\":41,\"name\":\"删除\",\"perms\":\"sys:dicttype:delete\",\"type\":2,\"orderNum\":6}]',11,'127.0.0.1','2018-12-12 11:16:52'),
(188,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":213,\"parentId\":188,\"name\":\"空间主材预算\",\"url\":\"tx/predictmaterial\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',24,'127.0.0.1','2018-12-12 15:27:07'),
(189,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":218,\"parentId\":188,\"name\":\"空间工程预算\",\"url\":\"tx/predictproject\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'127.0.0.1','2018-12-12 15:27:16'),
(190,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":223,\"parentId\":188,\"name\":\"模板空间\",\"url\":\"tx/predictroom\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-12 15:27:26'),
(191,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":188,\"name\":\"预算模板\",\"url\":\"tx/predicttemplate\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-12 15:27:34'),
(192,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[227]',30,'127.0.0.1','2018-12-13 13:33:18'),
(193,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[226]',10,'127.0.0.1','2018-12-13 13:33:22'),
(194,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[225]',15,'127.0.0.1','2018-12-13 13:33:23'),
(195,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[224]',6,'127.0.0.1','2018-12-13 13:33:25'),
(196,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[223]',14,'127.0.0.1','2018-12-13 13:33:28'),
(197,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[219]',15,'127.0.0.1','2018-12-13 13:33:58'),
(198,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[220]',15,'127.0.0.1','2018-12-13 13:34:00'),
(199,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[221]',13,'127.0.0.1','2018-12-13 13:34:02'),
(200,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[222]',9,'127.0.0.1','2018-12-13 13:34:03'),
(201,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[218]',8,'127.0.0.1','2018-12-13 13:34:05'),
(202,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[214]',10,'127.0.0.1','2018-12-13 13:34:23'),
(203,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[215]',13,'127.0.0.1','2018-12-13 13:34:25'),
(204,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[216]',12,'127.0.0.1','2018-12-13 13:34:27'),
(205,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[217]',16,'127.0.0.1','2018-12-13 13:34:28'),
(206,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[213]',10,'127.0.0.1','2018-12-13 13:34:30'),
(207,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":188,\"name\":\"预算定额\",\"url\":\"tx/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":0}]',8,'127.0.0.1','2018-12-13 13:35:05'),
(208,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":188,\"name\":\"预算模板\",\"url\":\"tx/predicttemplate\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]',15,'127.0.0.1','2018-12-13 13:35:12'),
(209,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":188,\"name\":\"预算模板\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]',29,'127.0.0.1','2018-12-13 13:42:46'),
(210,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":188,\"name\":\"预算定额\",\"url\":\"tx/project/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":0}]',26,'127.0.0.1','2018-12-13 14:07:38'),
(211,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":46,\"parentId\":187,\"name\":\"材料管理\",\"url\":\"tx/material/materialtype\",\"type\":1,\"icon\":\"config\",\"orderNum\":2}]',15,'127.0.0.1','2018-12-13 14:08:37'),
(212,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":176,\"parentId\":188,\"name\":\"验收类别\",\"url\":\"tx/accept/accepttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',16,'127.0.0.1','2018-12-13 14:10:45'),
(213,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":181,\"parentId\":188,\"name\":\"验收模板\",\"url\":\"tx/accept/accepttemplet\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'127.0.0.1','2018-12-13 14:10:55'),
(214,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":207,\"parentId\":187,\"name\":\"品牌维护\",\"url\":\"tx/brand/brandclass\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]',13,'127.0.0.1','2018-12-13 14:13:34'),
(215,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":171,\"parentId\":187,\"name\":\"考勤管理\",\"url\":\"tx/attendance/attendance\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',18,'127.0.0.1','2018-12-13 14:14:50'),
(216,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":66,\"parentId\":206,\"name\":\"施工日志\",\"url\":\"tx/constructionlog/constructionlog\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'127.0.0.1','2018-12-13 14:18:39'),
(217,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":71,\"parentId\":206,\"name\":\"投诉消息记录\",\"url\":\"tx/complaint/complaintinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-13 14:18:51'),
(218,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":76,\"parentId\":206,\"name\":\"投诉管理\",\"url\":\"tx/complaint/complaint\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',12,'127.0.0.1','2018-12-13 14:18:57'),
(219,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":81,\"parentId\":206,\"name\":\"任务\",\"url\":\"tx/task/task\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',8,'127.0.0.1','2018-12-13 14:19:05'),
(220,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":111,\"parentId\":206,\"name\":\"报修管理消息记录\",\"url\":\"tx/repairrepairinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',18,'127.0.0.1','2018-12-13 14:19:15'),
(221,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":111,\"parentId\":206,\"name\":\"报修管理消息记录\",\"url\":\"tx/repair/repairinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',16,'127.0.0.1','2018-12-13 14:19:22'),
(222,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":116,\"parentId\":206,\"name\":\"报修管理\",\"url\":\"tx/repair/repair\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',15,'127.0.0.1','2018-12-13 14:19:28'),
(223,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":56,\"parentId\":186,\"name\":\"我的客户\",\"url\":\"tx/client/formalclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'127.0.0.1','2018-12-13 14:22:11'),
(224,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":61,\"parentId\":186,\"name\":\"逃单客户\",\"url\":\"tx/client/escapeclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'127.0.0.1','2018-12-13 14:22:16'),
(225,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":106,\"parentId\":186,\"name\":\"客户公海池\",\"url\":\"tx/client/seaclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-13 14:22:22'),
(226,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":141,\"parentId\":186,\"name\":\"预约客户\",\"url\":\"tx/client/preclient\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-13 14:22:27'),
(227,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":161,\"parentId\":186,\"name\":\"客户记录\",\"url\":\"tx/client/clientinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',14,'127.0.0.1','2018-12-13 14:22:34'),
(228,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":86,\"parentId\":187,\"name\":\"业绩目标\",\"url\":\"tx/target/target\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',10,'127.0.0.1','2018-12-13 14:24:55'),
(229,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":136,\"parentId\":187,\"name\":\"售前阶段\",\"url\":\"tx/presale/presale\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',12,'127.0.0.1','2018-12-13 14:26:22'),
(230,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":156,\"parentId\":187,\"name\":\"小区维护\",\"url\":\"tx/community/community\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',8,'127.0.0.1','2018-12-13 14:26:30'),
(231,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":146,\"parentId\":188,\"name\":\"施工计划类别\",\"url\":\"tx/plan/plantype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-13 14:27:54'),
(232,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":188,\"name\":\"施工计划模板\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',6,'127.0.0.1','2018-12-13 14:28:00'),
(233,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":91,\"parentId\":205,\"name\":\"供应商管理\",\"url\":\"tx/supplier/supplier\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',13,'127.0.0.1','2018-12-13 14:29:48'),
(234,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":96,\"parentId\":205,\"name\":\"仓库管理\",\"url\":\"tx/store/store\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'127.0.0.1','2018-12-13 14:29:53'),
(235,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":121,\"parentId\":205,\"name\":\"单据类型维护\",\"url\":\"tx/receipt/receipt\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',15,'127.0.0.1','2018-12-13 14:29:59'),
(236,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":101,\"parentId\":189,\"name\":\"客户服务术语\",\"url\":\"tx/servingtech/servingtech\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',7,'127.0.0.1','2018-12-13 14:31:57'),
(237,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":195,\"parentId\":189,\"name\":\"离职员工\",\"url\":\"tx/sysretired/sysretired\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',17,'127.0.0.1','2018-12-13 14:32:04'),
(238,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位\",\"url\":\"tx/sysposition/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3}]',13,'127.0.0.1','2018-12-13 14:32:09'),
(239,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":141,\"parentId\":186,\"name\":\"预约客户\",\"url\":\"tx/client/clientpre\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',16,'127.0.0.1','2019-01-22 14:22:20'),
(240,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":233,\"parentId\":106,\"name\":\"领取\",\"url\":\"\",\"perms\":\"tx:seaclient:receive\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',9,'127.0.0.1','2019-01-28 16:23:14'),
(241,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":234,\"parentId\":56,\"name\":\"转入公海\",\"url\":\"\",\"perms\":\"tx:formalclient:sea\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',25,'127.0.0.1','2019-01-28 16:44:23'),
(242,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":235,\"parentId\":61,\"name\":\"转入公海\",\"url\":\"\",\"perms\":\"tx:escapeclient:sea\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',22,'127.0.0.1','2019-01-28 17:30:11'),
(243,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":236,\"parentId\":56,\"name\":\"逃单\",\"url\":\"\",\"perms\":\"tx:formalclient:escape\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',23,'127.0.0.1','2019-01-28 17:34:50'),
(244,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":77,\"parentId\":76,\"name\":\"查看\",\"perms\":\"tx:complaint:list,tx:complaint:info,tx:complaintinfo:list,tx:complaintinfo:info\",\"type\":2,\"orderNum\":6}]',28,'127.0.0.1','2019-01-29 00:27:34'),
(245,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":78,\"parentId\":76,\"name\":\"新增\",\"perms\":\"tx:complaint:save,tx:complaintinfo:save\",\"type\":2,\"orderNum\":6}]',16,'127.0.0.1','2019-01-29 00:27:47'),
(246,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":79,\"parentId\":76,\"name\":\"修改\",\"perms\":\"tx:complaint:update,tx:complaintinfo:update\",\"type\":2,\"orderNum\":6}]',17,'127.0.0.1','2019-01-29 00:27:56'),
(247,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":80,\"parentId\":76,\"name\":\"删除\",\"perms\":\"tx:complaint:delete,tx:complaintinfo:delete\",\"type\":2,\"orderNum\":6}]',15,'127.0.0.1','2019-01-29 00:28:06'),
(248,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[75]',45,'127.0.0.1','2019-01-29 00:29:05'),
(249,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[74]',24,'127.0.0.1','2019-01-29 00:29:09'),
(250,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[73]',21,'127.0.0.1','2019-01-29 00:29:13'),
(251,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[72]',15,'127.0.0.1','2019-01-29 00:29:16'),
(252,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[71]',16,'127.0.0.1','2019-01-29 00:29:20'),
(253,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[150]',20,'127.0.0.1','2019-01-30 11:45:20'),
(254,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[149]',16,'127.0.0.1','2019-01-30 11:45:25'),
(255,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[148]',12,'127.0.0.1','2019-01-30 11:45:26'),
(256,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[147]',12,'127.0.0.1','2019-01-30 11:45:28'),
(257,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[146]',15,'127.0.0.1','2019-01-30 11:45:32'),
(258,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[180]',35,'127.0.0.1','2019-01-30 11:46:29'),
(259,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[179]',14,'127.0.0.1','2019-01-30 11:46:32'),
(260,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[178]',7,'127.0.0.1','2019-01-30 11:46:34'),
(261,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[177]',5,'127.0.0.1','2019-01-30 11:46:35'),
(262,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[176]',13,'127.0.0.1','2019-01-30 11:46:37'),
(263,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":237,\"parentId\":1,\"name\":\"企业管理\",\"url\":\"sys/company\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',36,'127.0.0.1','2019-02-26 23:45:02'),
(264,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":242,\"parentId\":0,\"name\":\"企业管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"shouye\",\"orderNum\":0}]',10,'127.0.0.1','2019-02-28 00:26:25'),
(265,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":237,\"parentId\":242,\"name\":\"企业管理\",\"url\":\"sys/company\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',18,'127.0.0.1','2019-02-28 00:26:53'),
(266,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":243,\"parentId\":242,\"name\":\"用户管理\",\"url\":\"sys/user\",\"perms\":\"\",\"type\":1,\"icon\":\"admin\",\"orderNum\":0}]',8,'127.0.0.1','2019-02-28 00:28:42'),
(267,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":242,\"parentId\":0,\"name\":\"企业管理\",\"type\":0,\"icon\":\"shouye\",\"orderNum\":1}]',12,'127.0.0.1','2019-02-28 00:32:14'),
(268,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":206,\"parentId\":0,\"name\":\"日常管理\",\"type\":0,\"icon\":\"bianji\",\"orderNum\":2}]',13,'127.0.0.1','2019-02-28 00:32:27'),
(269,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":206,\"parentId\":0,\"name\":\"日常管理\",\"type\":0,\"icon\":\"bianji\",\"orderNum\":3}]',13,'127.0.0.1','2019-02-28 00:32:32'),
(270,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"组织机构管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":2}]',7,'127.0.0.1','2019-02-28 00:32:57'),
(271,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"type\":0,\"icon\":\"admin\",\"orderNum\":2}]',8,'127.0.0.1','2019-02-28 00:33:16'),
(272,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[16]',51,'127.0.0.1','2019-02-28 09:35:18'),
(273,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[13]',13,'127.0.0.1','2019-02-28 09:35:22'),
(274,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":238,\"parentId\":237,\"name\":\"查看\",\"perms\":\"sys:company:list,sys:company:info\",\"type\":2,\"orderNum\":6}]',17,'127.0.0.1','2019-02-28 09:39:13'),
(275,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，无新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,46,47,48,49,212,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,189,3,19,20,21,22,31,32,33,34,35,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,205,91,92,93,94,95,96,97,98,99,100,121,122,123,124,125,66,67,68,69,70,76,77,78,79,80,-666666,206]}]',183,'127.0.0.1','2019-02-28 10:11:49'),
(276,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[2]]',40,'127.0.0.1','2019-02-28 10:13:46'),
(277,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[3]]',8,'127.0.0.1','2019-02-28 10:13:53'),
(278,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[4]]',17,'127.0.0.1','2019-02-28 10:13:56'),
(279,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[5]]',13,'127.0.0.1','2019-02-28 10:13:59'),
(280,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[6]]',16,'127.0.0.1','2019-02-28 10:14:06'),
(281,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[7]]',6,'127.0.0.1','2019-02-28 10:14:08'),
(282,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":8,\"roleName\":\"超管\",\"remark\":\"所有权限\",\"createUserId\":1,\"menuIdList\":[1,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,41,42,43,44,45,186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,46,47,48,49,212,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,189,3,19,20,21,22,31,32,33,34,35,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,205,91,92,93,94,95,96,97,98,99,100,121,122,123,124,125,206,66,67,68,69,70,76,77,78,79,80,81,82,83,84,85,111,112,113,114,115,116,117,118,119,120,242,237,238,239,240,241,243,-666666],\"createTime\":\"Feb 28, 2019 10:15:13 AM\"}]',124,'127.0.0.1','2019-02-28 10:15:14'),
(283,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":9,\"roleName\":\"二级\",\"remark\":\"企业拥有部分权限，包括新增用户\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,46,47,48,49,212,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,189,3,19,20,21,22,31,32,33,34,35,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666],\"createTime\":\"Feb 28, 2019 10:16:28 AM\"}]',42,'127.0.0.1','2019-02-28 10:16:29'),
(284,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，无新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,46,47,48,49,212,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,189,3,19,20,21,22,31,32,33,34,35,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666]}]',46,'127.0.0.1','2019-02-28 10:16:49'),
(285,'admin','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[8]]',7,'127.0.0.1','2019-02-28 10:16:58'),
(286,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":10,\"roleName\":\"超管\",\"remark\":\"所有权限\",\"createUserId\":1,\"menuIdList\":[1,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,41,42,43,44,45,186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,46,47,48,49,212,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,189,3,19,20,21,22,31,32,33,34,35,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,205,91,92,93,94,95,96,97,98,99,100,121,122,123,124,125,206,66,67,68,69,70,76,77,78,79,80,81,82,83,84,85,111,112,113,114,115,116,117,118,119,120,242,237,238,239,240,241,243,-666666],\"createTime\":\"Feb 28, 2019 10:17:26 AM\"}]',55,'127.0.0.1','2019-02-28 10:17:26'),
(287,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":1,\"username\":\"admin\",\"password\":\"\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"mobile\":\"18912322217\",\"roleIdList\":[10]}]',54,'127.0.0.1','2019-02-28 10:20:23'),
(288,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"ifMain\":true,\"userId\":10,\"username\":\"王虎\",\"password\":\"\",\"mobile\":\"17625820115\",\"roleIdList\":[1]}]',87,'127.0.0.1','2019-02-28 10:37:08'),
(289,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"ifMain\":true,\"userId\":10,\"username\":\"王虎\",\"password\":\"\",\"mobile\":\"17625820115\",\"roleIdList\":[1]}]',9,'127.0.0.1','2019-02-28 10:37:27'),
(290,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":187,\"parentId\":0,\"name\":\"业务配置\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":3}]',29,'127.0.0.1','2019-02-28 23:24:14'),
(291,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"type\":0,\"icon\":\"admin\",\"orderNum\":4}]',17,'127.0.0.1','2019-02-28 23:24:20'),
(292,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":188,\"parentId\":0,\"name\":\"模板配置\",\"type\":0,\"icon\":\"log\",\"orderNum\":4}]',7,'127.0.0.1','2019-02-28 23:25:09'),
(293,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"type\":0,\"icon\":\"admin\",\"orderNum\":5}]',7,'127.0.0.1','2019-02-28 23:25:16'),
(294,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":206,\"parentId\":0,\"name\":\"日常管理\",\"type\":0,\"icon\":\"bianji\",\"orderNum\":6}]',15,'127.0.0.1','2019-02-28 23:25:22'),
(295,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":205,\"parentId\":0,\"name\":\"进销存管理\",\"type\":0,\"icon\":\"sql\",\"orderNum\":7}]',15,'127.0.0.1','2019-02-28 23:25:41'),
(296,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":11,\"roleName\":\"业务员\",\"remark\":\"只有客户管理权限\",\"createUserId\":10,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,-666666],\"createTime\":\"Feb 28, 2019 11:58:11 PM\"}]',234,'127.0.0.1','2019-02-28 23:58:12'),
(297,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":12,\"roleName\":\"工程部经理\",\"remark\":\"拥有模板等设计权限\",\"createUserId\":10,\"menuIdList\":[187,46,47,48,49,212,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,-666666],\"createTime\":\"Feb 28, 2019 11:59:00 PM\"}]',52,'127.0.0.1','2019-02-28 23:59:00'),
(298,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":17,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"黄小兵\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"17625820115\",\"job\":\"销售\",\"entry\":\"Mar 3, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',223,'127.0.0.1','2019-03-01 00:06:49'),
(299,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":244,\"parentId\":46,\"name\":\"导入\",\"url\":\"\",\"perms\":\"tx:material:import\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',18,'127.0.0.1','2019-03-05 13:41:09'),
(300,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":245,\"parentId\":126,\"name\":\"导出\",\"url\":\"\",\"perms\":\"tx:project:export\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',7,'127.0.0.1','2019-03-05 13:54:35'),
(301,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":246,\"parentId\":228,\"name\":\"导出\",\"url\":\"\",\"perms\":\"tx:predicttemplate:export\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',8,'127.0.0.1','2019-03-05 13:56:56'),
(302,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":13,\"roleName\":\"测试\",\"remark\":\"测试备注啊沙发沙发沙发发生发射点发射点发是否啊沙发沙发案说法阿斯蒂芬案说法阿斯蒂芬案说法案说法按时发撒地方撒发送\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:50:19 PM\"}]',159,'127.0.0.1','2019-03-05 22:50:19'),
(303,'王虎','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":13,\"roleName\":\"测试\",\"remark\":\"测试备注啊沙发沙发沙发发生发射点发射点发是否啊沙发沙发案说法阿斯蒂芬案说法阿斯蒂芬案说法案说法按时发撒地方撒发送\",\"createUserId\":10,\"menuIdList\":[56,57,58,59,60,234,236,-666666,186]}]',39,'127.0.0.1','2019-03-05 22:50:30'),
(304,'王虎','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[13]]',28,'127.0.0.1','2019-03-05 22:50:38'),
(305,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":14,\"roleName\":\"测试\",\"remark\":\"2\",\"createUserId\":10,\"menuIdList\":[56,57,58,59,60,234,236,-666666,186],\"createTime\":\"Mar 5, 2019 10:50:47 PM\"}]',30,'127.0.0.1','2019-03-05 22:50:47'),
(306,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":15,\"roleName\":\"测试2\",\"remark\":\"2\",\"createUserId\":10,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,-666666],\"createTime\":\"Mar 5, 2019 10:50:53 PM\"}]',45,'127.0.0.1','2019-03-05 22:50:54'),
(307,'王虎','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[14,15]]',22,'127.0.0.1','2019-03-05 22:50:59'),
(308,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":16,\"roleName\":\"测试2\",\"remark\":\"测试\",\"createUserId\":10,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,-666666],\"createTime\":\"Mar 5, 2019 10:51:09 PM\"}]',62,'127.0.0.1','2019-03-05 22:51:09'),
(309,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":17,\"roleName\":\"2\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:13 PM\"}]',25,'127.0.0.1','2019-03-05 22:51:13'),
(310,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":18,\"roleName\":\"3\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:16 PM\"}]',14,'127.0.0.1','2019-03-05 22:51:16'),
(311,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":19,\"roleName\":\"4\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:19 PM\"}]',21,'127.0.0.1','2019-03-05 22:51:20'),
(312,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":20,\"roleName\":\"5\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:23 PM\"}]',22,'127.0.0.1','2019-03-05 22:51:24'),
(313,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":21,\"roleName\":\"6\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:27 PM\"}]',22,'127.0.0.1','2019-03-05 22:51:27'),
(314,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":22,\"roleName\":\"7\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:31 PM\"}]',20,'127.0.0.1','2019-03-05 22:51:32'),
(315,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":23,\"roleName\":\"1\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:34 PM\"}]',25,'127.0.0.1','2019-03-05 22:51:35'),
(316,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":24,\"roleName\":\"2\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:38 PM\"}]',25,'127.0.0.1','2019-03-05 22:51:38'),
(317,'王虎','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":1,\"roleId\":25,\"roleName\":\"4\",\"remark\":\"\",\"createUserId\":10,\"menuIdList\":[-666666],\"createTime\":\"Mar 5, 2019 10:51:42 PM\"}]',24,'127.0.0.1','2019-03-05 22:51:43'),
(318,'王虎','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[17,18,19,20,21,22,23]]',17,'127.0.0.1','2019-03-05 22:51:55'),
(319,'王虎','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[24,25]]',20,'127.0.0.1','2019-03-05 22:52:00'),
(320,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":18,\"deptId\":7,\"deptName\":\"施工一部\",\"username\":\"陈振健\",\"password\":\"3cfe17b8a3f3fb3a24c869c1898f4396dda3d4cb93fa9d7bd386d885cbaad74a\",\"salt\":\"9lWSMH4IpkGroF0hf7zT\",\"mobile\":\"18912322217\",\"job\":\"CTO\",\"entry\":\"Mar 4, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[12],\"positionIdList\":[1,3],\"createTime\":\"Mar 5, 2019 10:59:11 PM\"}]',63,'127.0.0.1','2019-03-05 22:59:11'),
(321,'陈振健','修改密码','io.ttn.modules.sys.controller.SysUserController.password()','[{\"password\":\"000000\",\"newPassword\":\"admin\"}]',22,'127.0.0.1','2019-03-05 23:00:20'),
(322,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":5,\"deptName\":\"销售一部\",\"username\":\"黄小兵\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"17625820115\",\"job\":\"销售\",\"entry\":\"Mar 3, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',23,'127.0.0.1','2019-03-05 23:13:31'),
(323,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":5,\"deptName\":\"销售一部\",\"username\":\"黄小兵\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"17625820115\",\"job\":\"销售222\",\"entry\":\"Mar 3, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',20,'127.0.0.1','2019-03-05 23:13:52'),
(324,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":8,\"deptName\":\"销售一部\",\"username\":\"虞海波\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"16222211122\",\"job\":\"前端销售\",\"entry\":\"Mar 4, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',17,'127.0.0.1','2019-03-05 23:14:27'),
(325,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":19,\"deptId\":8,\"deptName\":\"施工二部\",\"username\":\"陈\",\"password\":\"b990c050ed0bbc9ece4876ed07c93ac9115b49da7d2146baf5db8a34be659148\",\"salt\":\"muUesWeayunMEPib2zpm\",\"mobile\":\"11222222222\",\"job\":\"测试3\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 6, 2019 12:02:42 AM\"}]',16,'127.0.0.1','2019-03-06 00:02:43'),
(326,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":20,\"deptId\":5,\"deptName\":\"销售一部\",\"username\":\"换\",\"password\":\"0295dd4c34e773124d622c9848ea0f98d5f0a1b8f15d7bb40af5feb487e98bc9\",\"salt\":\"kOpPmDGlR6kyfSLmT4LY\",\"mobile\":\"12222222222\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1,3],\"createTime\":\"Mar 6, 2019 12:03:24 AM\"}]',22,'127.0.0.1','2019-03-06 00:03:24'),
(327,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":19,\"deptId\":8,\"deptName\":\"施工二部\",\"username\":\"陈\",\"password\":\"b990c050ed0bbc9ece4876ed07c93ac9115b49da7d2146baf5db8a34be659148\",\"salt\":\"muUesWeayunMEPib2zpm\",\"mobile\":\"11222222222\",\"job\":\"测试3\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1,3],\"createTime\":\"Mar 6, 2019 12:02:43 AM\"}]',36,'127.0.0.1','2019-03-06 00:03:41'),
(328,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":19,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"哈哈\",\"password\":\"b990c050ed0bbc9ece4876ed07c93ac9115b49da7d2146baf5db8a34be659148\",\"salt\":\"muUesWeayunMEPib2zpm\",\"mobile\":\"12222222222\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1,4],\"createTime\":\"Mar 6, 2019 12:02:43 AM\"}]',3,'127.0.0.1','2019-03-06 00:04:06'),
(329,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":19,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"哈哈\",\"password\":\"b990c050ed0bbc9ece4876ed07c93ac9115b49da7d2146baf5db8a34be659148\",\"salt\":\"muUesWeayunMEPib2zpm\",\"mobile\":\"12222222233\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1,4],\"createTime\":\"Mar 6, 2019 12:02:43 AM\"}]',20,'127.0.0.1','2019-03-06 00:04:13'),
(330,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":8,\"deptName\":\"施工二部\",\"username\":\"虞海波\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"16222211122\",\"job\":\"前端销售\",\"entry\":\"Mar 4, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',22,'127.0.0.1','2019-03-06 00:04:51'),
(331,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":8,\"deptName\":\"施工二部\",\"username\":\"虞海波\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"16222211122\",\"job\":\"前端销售\",\"entry\":\"Mar 4, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1,3],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',17,'127.0.0.1','2019-03-06 00:06:16'),
(332,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":9,\"deptName\":\"施工二部\",\"username\":\"测试\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"13244442222\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[3],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',16,'127.0.0.1','2019-03-06 00:06:36'),
(333,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":9,\"deptName\":\"天堂鸟信息科技有限公司\",\"username\":\"测试\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"13244442222\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[3,1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',35,'127.0.0.1','2019-03-06 00:09:25'),
(334,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":9,\"deptName\":\"天堂鸟信息科技有限公司\",\"username\":\"测试\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"13244442222\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[3,1],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',20,'127.0.0.1','2019-03-06 00:09:49'),
(335,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":9,\"deptName\":\"天堂鸟信息科技有限公司\",\"username\":\"试试\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"12344445555\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[12],\"positionIdList\":[3],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',20,'127.0.0.1','2019-03-06 00:10:12'),
(336,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":17,\"deptId\":9,\"deptName\":\"天堂鸟信息科技有限公司\",\"username\":\"试试\",\"password\":\"e4907b9a1846a9a56a7de22d6c3135ca488bd1fd1fb2b25c2e24e8d710b5d64c\",\"salt\":\"tdIdyWzEPZIlO45MJaOo\",\"mobile\":\"12344445555\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[12,11],\"positionIdList\":[3],\"createTime\":\"Mar 1, 2019 12:06:48 AM\"}]',18,'127.0.0.1','2019-03-06 00:13:05'),
(337,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":21,\"deptId\":9,\"deptName\":\"天堂鸟信息科技有限公司\",\"username\":\"测试2\",\"password\":\"0288b0b11ac9fbcb33fa7f3da620db10d89a2ab8eecdd3bde184d6220ce92573\",\"salt\":\"fmccSCeTgUWQeH8v1aNi\",\"mobile\":\"12222222345\",\"job\":\"测试\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[],\"createTime\":\"Mar 6, 2019 12:13:23 AM\"}]',18,'127.0.0.1','2019-03-06 00:13:24'),
(338,'王虎','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[21]',40,'127.0.0.1','2019-03-06 00:13:39'),
(339,'王虎','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":17,\"personViewIdList\":[17]}]',23,'127.0.0.1','2019-03-06 10:49:54'),
(340,'王虎','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":20,\"personViewIdList\":[19]}]',6,'127.0.0.1','2019-03-06 10:50:08'),
(341,'王虎','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":17,\"deptViewIdList\":[6]}]',21,'127.0.0.1','2019-03-06 10:50:35'),
(342,'王虎','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":20,\"deptViewIdList\":[4,8]}]',15,'127.0.0.1','2019-03-06 10:50:49'),
(343,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":247,\"parentId\":31,\"name\":\"离职\",\"url\":\"\",\"perms\":\"sys:user:retired\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',12,'127.0.0.1','2019-03-06 13:06:52'),
(344,'admin','保存菜单','io.ttn.modules.sys.controller.SysMenuController.save()','[{\"menuId\":248,\"parentId\":31,\"name\":\"转客户\",\"url\":\"\",\"perms\":\"sys:user:exchange\",\"type\":2,\"icon\":\"\",\"orderNum\":0}]',26,'127.0.0.1','2019-03-06 13:07:54'),
(345,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，无新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,46,47,48,49,212,244,86,87,88,89,90,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666]}]',121,'127.0.0.1','2019-03-06 13:11:24'),
(346,'王虎','离职','io.ttn.modules.sys.controller.SysUserController.retired()','[17]',22,'127.0.0.1','2019-03-06 13:12:00'),
(347,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":1,\"username\":\"admin\",\"password\":\"czttn123!@#\",\"mobile\":\"18912322217\",\"ifOn\":true,\"roleIdList\":[10]}]',262,'180.116.178.211','2019-03-18 15:17:01'),
(348,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"userId\":1,\"username\":\"admin\",\"password\":\"czttn123!@#\",\"mobile\":\"18912322317\",\"ifOn\":true,\"roleIdList\":[10]}]',167,'180.116.178.211','2019-03-18 15:17:07'),
(349,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":0,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"测试\",\"password\":\"000000\",\"mobile\":\"18912322217\",\"job\":\"测试\",\"entry\":\"Mar 18, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[12],\"positionIdList\":[1]}]',125,'0:0:0:0:0:0:0:1','2019-03-19 11:27:51'),
(350,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":21,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"测试\",\"password\":\"9cddaa40b2158297288803aebdcd9296b3a49849280b9945ec21f92f100b8aec\",\"salt\":\"m9fjsyi4rEpCx7ts1UjX\",\"mobile\":\"18912322277\",\"job\":\"测试\",\"entry\":\"Mar 18, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[12],\"positionIdList\":[1],\"createTime\":\"Mar 19, 2019 11:27:55 AM\"}]',434,'0:0:0:0:0:0:0:1','2019-03-19 11:27:56'),
(351,'王虎','离职','io.ttn.modules.sys.controller.SysUserController.retired()','[21]',345,'0:0:0:0:0:0:0:1','2019-03-19 13:58:27'),
(352,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":22,\"deptId\":9,\"deptName\":\"销售管理部\",\"username\":\"厕所2\",\"password\":\"992769ba2c719d6711c292fa4782c55a013c915a9ed83e7d2318ea04617b4019\",\"salt\":\"t32ok1SAo6p9pvcTyAPd\",\"mobile\":\"18922222222\",\"job\":\"厕所2\",\"entry\":\"Mar 18, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 19, 2019 2:54:54 PM\"}]',388,'0:0:0:0:0:0:0:1','2019-03-19 14:54:55'),
(353,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":22,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"厕所2\",\"password\":\"992769ba2c719d6711c292fa4782c55a013c915a9ed83e7d2318ea04617b4019\",\"salt\":\"t32ok1SAo6p9pvcTyAPd\",\"mobile\":\"18922222222\",\"job\":\"厕所2\",\"entry\":\"Mar 18, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 19, 2019 2:54:55 PM\"}]',1162,'0:0:0:0:0:0:0:1','2019-03-19 14:57:10'),
(354,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":22,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"厕所2\",\"password\":\"992769ba2c719d6711c292fa4782c55a013c915a9ed83e7d2318ea04617b4019\",\"salt\":\"t32ok1SAo6p9pvcTyAPd\",\"mobile\":\"18922222222\",\"job\":\"厕所2\",\"entry\":\"Mar 18, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 19, 2019 2:54:55 PM\"}]',985,'0:0:0:0:0:0:0:1','2019-03-19 14:58:44'),
(355,'王虎','离职','io.ttn.modules.sys.controller.SysUserController.retired()','[22]',475,'0:0:0:0:0:0:0:1','2019-03-19 15:05:44'),
(356,'王虎','离职','io.ttn.modules.sys.controller.SysUserController.retired()','[20]',529,'0:0:0:0:0:0:0:1','2019-03-19 15:07:46'),
(357,'王虎','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"userId\":23,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"厕所222\",\"password\":\"51dc19a191de571d2d6fc2305c31aff0468442573fd150a2b6465022e1304b1a\",\"salt\":\"mbNGbxGXe2YkNZgykwh8\",\"mobile\":\"18933333333\",\"job\":\"厕所222\",\"entry\":\"Mar 18, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Mar 19, 2019 3:22:27 PM\"}]',524,'0:0:0:0:0:0:0:1','2019-03-19 15:22:28'),
(358,'王虎','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[23]',813,'0:0:0:0:0:0:0:1','2019-03-19 15:22:36'),
(359,'王虎','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":19,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"李聪\",\"password\":\"b990c050ed0bbc9ece4876ed07c93ac9115b49da7d2146baf5db8a34be659148\",\"salt\":\"muUesWeayunMEPib2zpm\",\"mobile\":\"12222222233\",\"job\":\"销售\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1,4],\"createTime\":\"Mar 6, 2019 12:02:43 AM\"}]',374,'0:0:0:0:0:0:0:1','2019-03-19 15:23:30'),
(360,'王虎','离职','io.ttn.modules.sys.controller.SysUserController.retired()','[10]',36,'0:0:0:0:0:0:0:1','2019-03-19 15:34:47'),
(361,'王虎','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[10]',0,'0:0:0:0:0:0:0:1','2019-03-19 15:34:51'),
(362,'王虎','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":19,\"personViewIdList\":[10,19]}]',185,'0:0:0:0:0:0:0:1','2019-03-19 15:35:18'),
(363,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，无新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,46,47,48,49,212,244,86,87,88,89,90,136,137,138,139,140,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666,187]}]',3967,'0:0:0:0:0:0:0:1','2019-03-19 16:40:55'),
(364,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":9,\"roleName\":\"二级\",\"remark\":\"企业拥有部分权限，包括新增用户\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,46,47,48,49,212,244,86,87,88,89,90,156,157,158,159,160,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666,187]}]',3243,'0:0:0:0:0:0:0:1','2019-03-19 16:41:43'),
(365,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，无新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,46,47,48,49,212,244,86,87,88,89,90,136,137,138,139,140,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666,187]}]',4125,'0:0:0:0:0:0:0:1','2019-03-19 16:42:09'),
(366,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,46,47,48,49,212,244,86,87,88,89,90,136,137,138,139,140,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666,187]}]',3947,'0:0:0:0:0:0:0:1','2019-03-19 16:42:26'),
(367,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":1,\"roleName\":\"一级\",\"remark\":\"企业拥有的部分权限，新增用户权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,46,47,48,49,212,244,86,87,88,89,90,156,157,158,159,160,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,36,37,38,39,40,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666,187]}]',3153,'0:0:0:0:0:0:0:1','2019-03-19 16:59:07'),
(368,'admin','修改密码','io.ttn.modules.sys.controller.SysUserController.password()','[{\"password\":\"admin\",\"newPassword\":\"ttn123!@#\"}]',115,'222.185.186.150','2019-03-20 23:52:28'),
(369,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":188,\"name\":\"施工项定额\",\"url\":\"tx/project/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":0}]',159,'222.185.186.150','2019-03-21 23:08:42'),
(370,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":188,\"name\":\"项目套餐模板\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]',80,'222.185.186.150','2019-03-21 23:10:46'),
(371,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":188,\"name\":\"工程套餐模板\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]',102,'222.185.186.150','2019-03-21 23:15:54'),
(372,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":187,\"parentId\":0,\"name\":\"基础配置\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":3}]',62,'222.185.186.150','2019-03-21 23:17:16'),
(373,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":188,\"parentId\":0,\"name\":\"业务配置\",\"type\":0,\"icon\":\"log\",\"orderNum\":4}]',75,'222.185.186.150','2019-03-21 23:17:27'),
(374,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业组织结构\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":2}]',100,'222.185.186.150','2019-03-21 23:17:42'),
(375,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业行政管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":2}]',49,'222.185.186.150','2019-03-21 23:19:02'),
(376,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":36,\"parentId\":187,\"name\":\"字典管理\",\"url\":\"sys/dict\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',67,'222.185.186.150','2019-03-21 23:29:48'),
(377,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":86,\"parentId\":189,\"name\":\"业绩目标\",\"url\":\"tx/target/target\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',85,'222.185.186.150','2019-03-21 23:33:29'),
(378,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"ifMain\":true,\"userId\":10,\"deptId\":3,\"deptName\":\"销售管理部\",\"username\":\"张三\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"mobile\":\"18922222222\",\"job\":\"CEO\",\"entry\":\"Oct 9, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1],\"positionIdList\":[],\"createTime\":\"Feb 28, 2019 10:36:29 AM\"}]',531,'0:0:0:0:0:0:0:1','2019-04-08 10:51:26'),
(379,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"userId\":19,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"李四\",\"password\":\"b990c050ed0bbc9ece4876ed07c93ac9115b49da7d2146baf5db8a34be659148\",\"salt\":\"muUesWeayunMEPib2zpm\",\"mobile\":\"12222222233\",\"job\":\"销售\",\"entry\":\"Mar 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11,12],\"positionIdList\":[1,4],\"createTime\":\"Mar 6, 2019 12:02:43 AM\"}]',636,'0:0:0:0:0:0:0:1','2019-04-08 10:51:51'),
(380,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":249,\"parentId\":1,\"name\":\"开户申请\",\"url\":\"sys/companyregist\",\"type\":1,\"icon\":\"config\",\"orderNum\":6}]',842,'0:0:0:0:0:0:0:1','2019-04-08 16:35:49'),
(381,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":250,\"parentId\":249,\"name\":\"查看\",\"perms\":\"sys:companyregist:list,sys:companyregist:info\",\"type\":2,\"orderNum\":6}]',258,'0:0:0:0:0:0:0:1','2019-04-08 16:38:58'),
(382,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":10,\"roleName\":\"超管\",\"remark\":\"所有权限\",\"createUserId\":1,\"menuIdList\":[4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,41,42,43,44,45,186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,36,37,38,39,40,46,47,48,49,212,244,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,86,87,88,89,90,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,205,91,92,93,94,95,96,97,98,99,100,121,122,123,124,125,206,66,67,68,69,70,76,77,78,79,80,81,82,83,84,85,111,112,113,114,115,116,117,118,119,120,242,237,238,239,240,241,243,-666666,1]}]',19275,'0:0:0:0:0:0:0:1','2019-04-08 16:39:36'),
(383,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":10,\"roleName\":\"超管\",\"remark\":\"所有权限\",\"createUserId\":1,\"menuIdList\":[4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,41,42,43,44,45,186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,36,37,38,39,40,46,47,48,49,212,244,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,86,87,88,89,90,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,205,91,92,93,94,95,96,97,98,99,100,121,122,123,124,125,206,66,67,68,69,70,76,77,78,79,80,81,82,83,84,85,111,112,113,114,115,116,117,118,119,120,242,237,238,239,240,241,243,-666666,1]}]',18397,'0:0:0:0:0:0:0:1','2019-04-08 16:39:49'),
(384,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":10,\"roleName\":\"超管\",\"remark\":\"所有权限\",\"createUserId\":1,\"menuIdList\":[1,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,41,42,43,44,45,249,250,251,252,253,186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,36,37,38,39,40,46,47,48,49,212,244,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,86,87,88,89,90,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,205,91,92,93,94,95,96,97,98,99,100,121,122,123,124,125,206,66,67,68,69,70,76,77,78,79,80,81,82,83,84,85,111,112,113,114,115,116,117,118,119,120,242,237,238,239,240,241,243,-666666]}]',3431,'0:0:0:0:0:0:0:1','2019-04-08 16:40:12'),
(385,'admin','修改密码','io.ttn.modules.sys.controller.SysUserController.password()','[{\"password\":\"admin\",\"newPassword\":\"xiao86ze\"}]',51,'180.115.237.223','2019-05-05 13:36:00'),
(386,'admin','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"username\":\"czczj\",\"password\":\"b6980d73f3e4d4af7e328d5c257526d94c018bc3c6bd02024655454bf7c599e8\",\"salt\":\"ikOoHfUxNLq0bNQDpcK6\",\"mobile\":\"18911111111\",\"ifOn\":true,\"roleIdList\":[9],\"createTime\":\"May 5, 2019 1:40:03 PM\"}]',1339,'180.115.237.223','2019-05-05 13:40:04'),
(387,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"username\":\"Mr.Yip\",\"password\":\"\",\"mobile\":\"18911111111\",\"ifOn\":true,\"roleIdList\":[9]}]',146,'180.115.237.223','2019-05-05 13:40:17'),
(388,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"username\":\"Mr.Yip\",\"password\":\"000000\",\"mobile\":\"18911111111\",\"ifOn\":true,\"roleIdList\":[9]}]',153,'180.115.237.223','2019-05-05 13:40:37'),
(389,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"username\":\"Mr.Yip\",\"password\":\"000000\",\"mobile\":\"18911111111\",\"ifOn\":true,\"roleIdList\":[9]}]',193,'180.115.237.223','2019-05-05 13:41:48'),
(390,'Mr.Yip','修改密码','io.ttn.modules.sys.controller.SysUserController.password()','[{\"password\":\"admin\",\"newPassword\":\"000000\"}]',27,'180.115.237.223','2019-05-05 13:43:45'),
(391,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"deptId\":10,\"deptName\":\"颐舍空间\",\"username\":\"Mr.Yip\",\"password\":\"12e416902db93462bf888e3dc0792be42ecd8a54a6c8ca63ba68cdd35947da15\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"mobile\":\"18911111111\",\"job\":\"ceo\",\"ifOn\":true,\"roleIdList\":[9],\"positionIdList\":[],\"createTime\":\"May 5, 2019 1:40:03 PM\"}]',310,'180.115.237.223','2019-05-05 13:50:34'),
(392,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"username\":\"Mr.Yip\",\"password\":\"\",\"mobile\":\"18042335123\",\"ifOn\":true,\"roleIdList\":[9]}]',154,'180.115.237.223','2019-05-05 14:12:07'),
(393,'张三','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"email\":\"2651782253@qq.com\",\"userId\":0,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"ces1\",\"password\":\"000000\",\"mobile\":\"18912322217\",\"job\":\"ces1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1]}]',119,'0:0:0:0:0:0:0:1','2019-05-06 11:23:14'),
(394,'张三','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"2651782253@qq.com\",\"userId\":26,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"ces1\",\"password\":\"a640ed41f54e426d9271986e00e81d1e83e1060be7d637b74f2d673971b5f8b2\",\"salt\":\"34vArEe3WJhjIlbQ35Lm\",\"mobile\":\"18912322216\",\"job\":\"ces1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"May 6, 2019 11:23:20 AM\"}]',347,'0:0:0:0:0:0:0:1','2019-05-06 11:23:21'),
(395,'张三','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[26]',309,'0:0:0:0:0:0:0:1','2019-05-06 11:26:48'),
(396,'张三','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"email\":\"2651782253@qq.com\",\"userId\":0,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"ces1\",\"password\":\"000000\",\"mobile\":\"18912322211\",\"job\":\"ce1\",\"entry\":\"May 6, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1]}]',105,'0:0:0:0:0:0:0:1','2019-05-06 11:27:20'),
(397,'张三','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"2651782251@qq.com\",\"userId\":27,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"ces1\",\"password\":\"a59231fcd44316c17faa05fad1815319d69cd329fc74288c3c4943c675ba5674\",\"salt\":\"IobSYsS4HcS7JlnfbqHn\",\"mobile\":\"18912322211\",\"job\":\"ce1\",\"entry\":\"May 6, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"May 6, 2019 11:27:27 AM\"}]',422,'0:0:0:0:0:0:0:1','2019-05-06 11:27:27'),
(398,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":189,\"name\":\"功能菜单分配\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2}]',167,'0:0:0:0:0:0:0:1','2019-05-06 15:55:49'),
(399,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位设置\",\"url\":\"tx/sysposition/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3}]',134,'0:0:0:0:0:0:0:1','2019-05-06 16:05:05'),
(400,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[25]',16,'0:0:0:0:0:0:0:1','2019-05-06 16:21:20'),
(401,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[1]',0,'0:0:0:0:0:0:0:1','2019-05-06 16:21:35'),
(402,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[25]',387,'0:0:0:0:0:0:0:1','2019-05-06 16:23:20'),
(403,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[27]',365,'0:0:0:0:0:0:0:1','2019-05-06 16:23:24'),
(404,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[19]',443,'0:0:0:0:0:0:0:1','2019-05-06 16:23:29'),
(405,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[18]',256,'0:0:0:0:0:0:0:1','2019-05-06 16:23:35'),
(406,'admin','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[28]',389,'0:0:0:0:0:0:0:1','2019-05-06 16:46:01'),
(407,'Mr.Yip','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":2,\"roleId\":17,\"roleName\":\"业务员\",\"remark\":\"\",\"createUserId\":24,\"menuIdList\":[57,58,59,234,108,233,-666666,186,56,106],\"createTime\":\"May 6, 2019 4:49:27 PM\"}]',497,'60.181.24.183','2019-05-06 16:49:28'),
(408,'Mr.Yip','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":2,\"roleId\":20,\"roleName\":\"设计师\",\"remark\":\"\",\"createUserId\":24,\"menuIdList\":[142,143,144,162,163,164,47,-666666,186,141,161,187,46],\"createTime\":\"May 6, 2019 4:52:01 PM\"}]',335,'60.181.24.183','2019-05-06 16:52:02'),
(409,'Mr.Yip','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":2,\"roleId\":21,\"roleName\":\"项目经理\",\"remark\":\"\",\"createUserId\":24,\"menuIdList\":[127,128,129,152,153,154,182,183,184,-666666,188,126,151,181],\"createTime\":\"May 6, 2019 4:55:21 PM\"}]',199,'122.228.128.10','2019-05-06 16:55:22'),
(410,'Mr.Yip','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"userId\":0,\"deptId\":10,\"deptName\":\"颐舍空间\",\"username\":\"01\",\"password\":\"000000\",\"mobile\":\"18042335123\",\"job\":\"设计师\",\"ifOn\":true,\"roleIdList\":[20],\"positionIdList\":[6]}]',31,'60.181.24.183','2019-05-06 16:58:34'),
(411,'Mr.Yip','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":2,\"userId\":30,\"deptId\":10,\"deptName\":\"颐舍空间\",\"username\":\"01\",\"password\":\"b23939f1ecb8adf386a46a9d992335faa47053ee91557224c40b65be5d6339a3\",\"salt\":\"iQhofdvhiemoBrEump9G\",\"mobile\":\"13857707923\",\"job\":\"设计师\",\"ifOn\":true,\"roleIdList\":[20],\"positionIdList\":[6],\"createTime\":\"May 6, 2019 4:58:52 PM\"}]',234,'60.181.26.125','2019-05-06 16:58:53'),
(412,'Mr.Yip','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":false,\"userId\":30,\"deptId\":10,\"deptName\":\"颐舍空间\",\"username\":\"铭亮\",\"password\":\"b23939f1ecb8adf386a46a9d992335faa47053ee91557224c40b65be5d6339a3\",\"salt\":\"iQhofdvhiemoBrEump9G\",\"mobile\":\"13857707923\",\"job\":\"设计师\",\"ifOn\":true,\"roleIdList\":[20],\"positionIdList\":[6],\"createTime\":\"May 6, 2019 4:58:52 PM\"}]',138,'60.181.26.125','2019-05-06 16:59:16'),
(413,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":1,\"parentId\":0,\"name\":\"系统管理\",\"type\":0,\"icon\":\"system\",\"orderNum\":0,\"ifAdmin\":true}]',264,'0:0:0:0:0:0:0:1','2019-05-06 17:07:19'),
(414,'Mr.Yip','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":24,\"personViewIdList\":[]}]',54,'60.181.24.183','2019-05-06 17:13:38'),
(415,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":5,\"parentId\":1,\"name\":\"SQL监控\",\"url\":\"http://localhost:8080/druid/sql.html\",\"type\":1,\"icon\":\"sql\",\"orderNum\":4,\"ifAdmin\":true}]',192,'0:0:0:0:0:0:0:1','2019-05-06 17:27:13'),
(416,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":6,\"parentId\":1,\"name\":\"定时任务\",\"url\":\"job/schedule\",\"type\":1,\"icon\":\"job\",\"orderNum\":5,\"ifAdmin\":true}]',134,'0:0:0:0:0:0:0:1','2019-05-06 17:27:18'),
(417,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":7,\"parentId\":6,\"name\":\"查看\",\"perms\":\"sys:schedule:list,sys:schedule:info\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',165,'0:0:0:0:0:0:0:1','2019-05-06 17:27:24'),
(418,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":8,\"parentId\":6,\"name\":\"新增\",\"perms\":\"sys:schedule:save\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',235,'0:0:0:0:0:0:0:1','2019-05-06 17:27:29'),
(419,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":9,\"parentId\":6,\"name\":\"修改\",\"perms\":\"sys:schedule:update\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',119,'0:0:0:0:0:0:0:1','2019-05-06 17:27:34'),
(420,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":10,\"parentId\":6,\"name\":\"删除\",\"perms\":\"sys:schedule:delete\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',141,'0:0:0:0:0:0:0:1','2019-05-06 17:27:40'),
(421,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":11,\"parentId\":6,\"name\":\"暂停\",\"perms\":\"sys:schedule:pause\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',134,'0:0:0:0:0:0:0:1','2019-05-06 17:27:46'),
(422,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":12,\"parentId\":6,\"name\":\"恢复\",\"perms\":\"sys:schedule:resume\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',115,'0:0:0:0:0:0:0:1','2019-05-06 17:27:51'),
(423,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":13,\"parentId\":6,\"name\":\"立即执行\",\"perms\":\"sys:schedule:run\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',363,'0:0:0:0:0:0:0:1','2019-05-06 17:28:03'),
(424,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":14,\"parentId\":6,\"name\":\"日志列表\",\"perms\":\"sys:schedule:log\",\"type\":2,\"orderNum\":0,\"ifAdmin\":true}]',140,'0:0:0:0:0:0:0:1','2019-05-06 17:28:09'),
(425,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":27,\"parentId\":1,\"name\":\"参数管理\",\"url\":\"sys/config\",\"perms\":\"sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":true}]',118,'0:0:0:0:0:0:0:1','2019-05-06 17:31:19'),
(426,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":29,\"parentId\":1,\"name\":\"系统日志\",\"url\":\"sys/log\",\"perms\":\"sys:log:list\",\"type\":1,\"icon\":\"log\",\"orderNum\":7,\"ifAdmin\":true}]',125,'0:0:0:0:0:0:0:1','2019-05-06 17:31:27'),
(427,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":30,\"parentId\":1,\"name\":\"文件上传\",\"url\":\"oss/oss\",\"perms\":\"sys:oss:all\",\"type\":1,\"icon\":\"oss\",\"orderNum\":6,\"ifAdmin\":true}]',132,'0:0:0:0:0:0:0:1','2019-05-06 17:31:34'),
(428,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":41,\"parentId\":1,\"name\":\"字典类型\",\"url\":\"sys/dicttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":true}]',121,'0:0:0:0:0:0:0:1','2019-05-06 17:31:41'),
(429,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":42,\"parentId\":41,\"name\":\"查看\",\"perms\":\"sys:dicttype:list,sys:dicttype:info\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',112,'0:0:0:0:0:0:0:1','2019-05-06 17:31:47'),
(430,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":43,\"parentId\":41,\"name\":\"新增\",\"perms\":\"sys:dicttype:save\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',173,'0:0:0:0:0:0:0:1','2019-05-06 17:31:53'),
(431,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":44,\"parentId\":41,\"name\":\"修改\",\"perms\":\"sys:dicttype:update\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',109,'0:0:0:0:0:0:0:1','2019-05-06 17:31:58'),
(432,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":45,\"parentId\":41,\"name\":\"删除\",\"perms\":\"sys:dicttype:delete\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',110,'0:0:0:0:0:0:0:1','2019-05-06 17:32:03'),
(433,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":249,\"parentId\":1,\"name\":\"开户申请\",\"url\":\"sys/companyregist\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":true}]',121,'0:0:0:0:0:0:0:1','2019-05-06 17:32:10'),
(434,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":250,\"parentId\":249,\"name\":\"查看\",\"perms\":\"sys:companyregist:list,sys:companyregist:info\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',216,'0:0:0:0:0:0:0:1','2019-05-06 17:32:15'),
(435,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":251,\"parentId\":249,\"name\":\"新增\",\"perms\":\"sys:companyregist:save\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',210,'0:0:0:0:0:0:0:1','2019-05-06 17:32:20'),
(436,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":252,\"parentId\":249,\"name\":\"修改\",\"perms\":\"sys:companyregist:update\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',119,'0:0:0:0:0:0:0:1','2019-05-06 17:32:25'),
(437,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":253,\"parentId\":249,\"name\":\"删除\",\"perms\":\"sys:companyregist:delete\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',195,'0:0:0:0:0:0:0:1','2019-05-06 17:32:32'),
(438,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":237,\"parentId\":242,\"name\":\"企业管理\",\"url\":\"sys/company\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":true}]',370,'0:0:0:0:0:0:0:1','2019-05-06 17:33:12'),
(439,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":238,\"parentId\":237,\"name\":\"查看\",\"perms\":\"sys:company:list,sys:company:info\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',104,'0:0:0:0:0:0:0:1','2019-05-06 17:33:33'),
(440,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":242,\"parentId\":0,\"name\":\"企业管理\",\"type\":0,\"icon\":\"shouye\",\"orderNum\":1,\"ifAdmin\":true}]',138,'0:0:0:0:0:0:0:1','2019-05-06 17:33:46'),
(441,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":239,\"parentId\":237,\"name\":\"新增\",\"perms\":\"sys:company:save\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',117,'0:0:0:0:0:0:0:1','2019-05-06 17:33:52'),
(442,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":240,\"parentId\":237,\"name\":\"修改\",\"perms\":\"sys:company:update\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',190,'0:0:0:0:0:0:0:1','2019-05-06 17:34:00'),
(443,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":241,\"parentId\":237,\"name\":\"删除\",\"perms\":\"sys:company:delete\",\"type\":2,\"orderNum\":6,\"ifAdmin\":true}]',152,'0:0:0:0:0:0:0:1','2019-05-06 17:34:04'),
(444,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":243,\"parentId\":242,\"name\":\"用户管理\",\"url\":\"sys/user\",\"type\":1,\"icon\":\"admin\",\"orderNum\":0,\"ifAdmin\":true}]',153,'0:0:0:0:0:0:0:1','2019-05-06 17:34:10'),
(445,'admin','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":2,\"ifMain\":true,\"userId\":24,\"deptId\":10,\"username\":\"Mr.Yip\",\"password\":\"\",\"mobile\":\"18042335123\",\"ifOn\":true,\"roleIdList\":[9,1]}]',413,'0:0:0:0:0:0:0:1','2019-05-06 17:37:42'),
(446,'陈总','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":6,\"roleId\":22,\"roleName\":\"项目经理\",\"remark\":\"所有菜单\",\"createUserId\":29,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,86,87,88,89,90,3,19,20,21,22,31,32,33,34,35,247,248,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,187,46,47,48,49,212,244,156,157,158,159,160,207,208,209,210,211,36,37,38,39,40,-666666],\"createTime\":\"May 6, 2019 5:40:59 PM\"}]',3017,'0:0:0:0:0:0:0:1','2019-05-06 17:41:02'),
(447,'陈总','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":6,\"roleId\":23,\"roleName\":\"项目经理\",\"remark\":\"所有菜单\",\"createUserId\":29,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,86,87,88,89,90,3,19,20,21,22,31,32,33,34,35,247,248,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,187,46,47,48,49,212,244,156,157,158,159,160,207,208,209,210,211,36,37,38,39,40,-666666],\"createTime\":\"May 6, 2019 5:41:02 PM\"}]',2257,'0:0:0:0:0:0:0:1','2019-05-06 17:41:05'),
(448,'陈总','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[23]]',195,'0:0:0:0:0:0:0:1','2019-05-06 17:42:34'),
(449,'陈总','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":6,\"roleId\":24,\"roleName\":\"测试\",\"remark\":\"1\",\"createUserId\":29,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,-666666],\"createTime\":\"May 6, 2019 5:42:48 PM\"}]',1162,'0:0:0:0:0:0:0:1','2019-05-06 17:42:49'),
(450,'陈总','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":24,\"roleName\":\"测试\",\"remark\":\"1\",\"createUserId\":29,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,86,87,88,89,90,3,19,20,21,22,31,32,33,34,35,247,248,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666]}]',2066,'0:0:0:0:0:0:0:1','2019-05-06 17:43:06'),
(451,'陈总','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":6,\"roleId\":25,\"roleName\":\"测试1\",\"remark\":\"11\",\"createUserId\":29,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,86,87,88,89,90,3,19,20,21,22,31,32,33,34,35,247,248,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666],\"createTime\":\"May 6, 2019 5:45:36 PM\"}]',1651,'0:0:0:0:0:0:0:1','2019-05-06 17:45:38'),
(452,'陈总','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[25]]',198,'0:0:0:0:0:0:0:1','2019-05-06 17:45:42'),
(453,'陈总','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[24]]',177,'0:0:0:0:0:0:0:1','2019-05-06 17:45:45'),
(454,'陈总','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":22,\"roleName\":\"项目经理\",\"remark\":\"所有菜单\",\"createUserId\":29,\"menuIdList\":[61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,86,87,88,89,90,3,19,20,21,22,31,32,33,34,35,247,248,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,187,46,47,48,49,212,244,156,157,158,159,160,207,208,209,210,211,36,37,38,39,40,-666666,186]}]',2160,'0:0:0:0:0:0:0:1','2019-05-06 17:49:11'),
(455,'陈总','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"email\":\"2651782253@qq.com\",\"userId\":0,\"deptId\":15,\"deptName\":\"销售部\",\"username\":\"管文强\",\"password\":\"000000\",\"mobile\":\"18911111111\",\"job\":\"前端工程师\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[22],\"positionIdList\":[]}]',205,'0:0:0:0:0:0:0:1','2019-05-06 21:58:07'),
(456,'陈总','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[22]]',207,'0:0:0:0:0:0:0:1','2019-05-06 21:59:20'),
(457,'陈总','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[29]',4,'0:0:0:0:0:0:0:1','2019-05-06 21:59:33'),
(458,'陈总','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"email\":\"493804771@qq.com\",\"userId\":0,\"deptId\":15,\"deptName\":\"销售部\",\"username\":\"1\",\"password\":\"000000\",\"mobile\":\"18912322217\",\"job\":\"1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[],\"positionIdList\":[]}]',23,'0:0:0:0:0:0:0:1','2019-05-06 23:34:49'),
(459,'陈总','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":6,\"email\":\"493804781@qq.com\",\"userId\":31,\"deptId\":14,\"deptName\":\"流雪科技\",\"username\":\"1\",\"password\":\"3f0dd2b82fbfb911c52c5c8ab84771bd0f445d6b8640af72b5e06ba41a001505\",\"salt\":\"c9Z7Fnhv4L24Ni2Va25f\",\"mobile\":\"18911111111\",\"job\":\"1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[],\"positionIdList\":[],\"createTime\":\"May 6, 2019 11:38:12 PM\"}]',394,'0:0:0:0:0:0:0:1','2019-05-06 23:38:13'),
(460,'陈总','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":6,\"email\":\"493804781@qq.com\",\"ifMain\":false,\"userId\":31,\"deptId\":14,\"deptName\":\"流雪科技\",\"username\":\"1\",\"password\":\"3f0dd2b82fbfb911c52c5c8ab84771bd0f445d6b8640af72b5e06ba41a001505\",\"salt\":\"c9Z7Fnhv4L24Ni2Va25f\",\"mobile\":\"18911111111\",\"job\":\"1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[],\"positionIdList\":[],\"createTime\":\"May 6, 2019 11:38:12 PM\"}]',256,'0:0:0:0:0:0:0:1','2019-05-06 23:39:24'),
(461,'陈总','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":6,\"email\":\"493804781@qq.com\",\"ifMain\":false,\"userId\":31,\"deptId\":14,\"deptName\":\"流雪科技\",\"username\":\"1\",\"password\":\"3f0dd2b82fbfb911c52c5c8ab84771bd0f445d6b8640af72b5e06ba41a001505\",\"salt\":\"c9Z7Fnhv4L24Ni2Va25f\",\"mobile\":\"18911111111\",\"job\":\"1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[],\"positionIdList\":[],\"createTime\":\"May 6, 2019 11:38:12 PM\"}]',207,'0:0:0:0:0:0:0:1','2019-05-06 23:40:14'),
(462,'陈总','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"cpId\":6,\"roleId\":26,\"roleName\":\"ces\",\"remark\":\"1\",\"createUserId\":29,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,-666666],\"createTime\":\"May 6, 2019 11:41:03 PM\"}]',807,'0:0:0:0:0:0:0:1','2019-05-06 23:41:04'),
(463,'陈总','修改用户','io.ttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":6,\"email\":\"493804781@qq.com\",\"ifMain\":false,\"userId\":31,\"deptId\":14,\"deptName\":\"流雪科技\",\"username\":\"1\",\"password\":\"3f0dd2b82fbfb911c52c5c8ab84771bd0f445d6b8640af72b5e06ba41a001505\",\"salt\":\"c9Z7Fnhv4L24Ni2Va25f\",\"mobile\":\"18911111111\",\"job\":\"1\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[26],\"positionIdList\":[],\"createTime\":\"May 6, 2019 11:38:12 PM\"}]',268,'0:0:0:0:0:0:0:1','2019-05-06 23:41:44'),
(464,'陈总','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[31]',322,'0:0:0:0:0:0:0:1','2019-05-06 23:41:59'),
(465,'陈总','保存用户','io.ttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":6,\"email\":\"493804781@qq.com\",\"ifMain\":false,\"userId\":32,\"deptId\":15,\"deptName\":\"销售部\",\"username\":\"管文强\",\"password\":\"a6a465940138b6627f10553162c8042960acb70056b3a7f47b0d50818b7f8d9f\",\"salt\":\"fy6JjnVnUAQ6UUHOOIFb\",\"mobile\":\"18922222222\",\"job\":\"销售人员\",\"entry\":\"May 5, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[26],\"positionIdList\":[8],\"createTime\":\"May 6, 2019 11:43:59 PM\"}]',299,'0:0:0:0:0:0:0:1','2019-05-06 23:44:00'),
(466,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":189,\"name\":\"部门管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":false,\"ifShow\":false}]',199,'0:0:0:0:0:0:0:1','2019-05-07 00:38:28'),
(467,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":189,\"name\":\"部门管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":false,\"ifShow\":true}]',140,'0:0:0:0:0:0:0:1','2019-05-07 00:38:40'),
(468,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位设置\",\"url\":\"tx/sysposition/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3,\"ifAdmin\":false,\"ifShow\":false}]',262,'0:0:0:0:0:0:0:1','2019-05-07 00:38:58'),
(469,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":189,\"name\":\"部门员工管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":false,\"ifShow\":true}]',126,'0:0:0:0:0:0:0:1','2019-05-07 08:13:29'),
(470,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":195,\"parentId\":189,\"name\":\"离职员工\",\"url\":\"tx/sysretired/sysretired\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":false,\"ifShow\":false}]',109,'0:0:0:0:0:0:0:1','2019-05-07 09:16:25'),
(471,'陈总','更新用户岗位','io.ttn.modules.sys.controller.SysUserController.updateUserPosition()','[{\"userId\":29,\"positionIdList\":[8]}]',208,'0:0:0:0:0:0:0:1','2019-05-07 14:03:41'),
(472,'陈总','更新用户个人视野','io.ttn.modules.sys.controller.SysUserController.updatePersonView()','[{\"userId\":29,\"personViewIdList\":[]}]',115,'0:0:0:0:0:0:0:1','2019-05-07 14:03:51'),
(473,'陈总','更新用户部门视野','io.ttn.modules.sys.controller.SysUserController.updateDeptView()','[{\"userId\":29,\"deptViewIdList\":[14,15,17,16]}]',211,'0:0:0:0:0:0:0:1','2019-05-07 14:03:55'),
(474,'陈总','更新用户角色','io.ttn.modules.sys.controller.SysUserController.updateUserRole()','[{\"userId\":29,\"roleIdList\":[1,26]}]',109,'0:0:0:0:0:0:0:1','2019-05-07 14:04:04'),
(475,'陈总','离职','io.ttn.modules.sys.controller.SysUserController.retired()','[29]',16,'0:0:0:0:0:0:0:1','2019-05-07 14:04:46'),
(476,'陈总','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[29]',0,'0:0:0:0:0:0:0:1','2019-05-07 14:04:56'),
(477,'陈总','删除角色','io.ttn.modules.sys.controller.SysRoleController.delete()','[[26]]',464,'0:0:0:0:0:0:0:1','2019-05-07 15:27:21'),
(478,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业行政管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":2,\"ifAdmin\":2,\"ifShow\":true}]',185,'0:0:0:0:0:0:0:1','2019-05-07 15:41:49'),
(479,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":189,\"name\":\"功能菜单分配\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2,\"ifAdmin\":2,\"ifShow\":false}]',156,'0:0:0:0:0:0:0:1','2019-05-07 15:42:14'),
(480,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位设置\",\"url\":\"tx/sysposition/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3,\"ifAdmin\":2,\"ifShow\":false}]',129,'0:0:0:0:0:0:0:1','2019-05-07 15:42:23'),
(481,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":27,\"roleName\":\"销售\",\"remark\":\"只拥有\\\"客户管理\\\"菜单功能\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,-666666],\"createTime\":\"May 7, 2019 3:46:39 PM\"}]',853,'0:0:0:0:0:0:0:1','2019-05-07 15:46:40'),
(482,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":28,\"roleName\":\"管理员\",\"remark\":\"拥有所有菜单权限\",\"createUserId\":1,\"menuIdList\":[-666666],\"createTime\":\"May 7, 2019 3:47:58 PM\"}]',161,'0:0:0:0:0:0:0:1','2019-05-07 15:47:58'),
(483,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":28,\"roleName\":\"总经理\",\"remark\":\"拥有所有菜单权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,187,36,37,38,39,40,46,47,48,49,212,244,136,137,138,139,140,156,157,158,159,160,171,172,173,174,175,207,208,209,210,211,188,126,127,128,129,130,245,151,152,153,154,155,181,182,183,184,185,228,229,230,231,232,246,189,3,19,20,21,22,31,32,33,34,35,247,248,86,87,88,89,90,101,102,103,104,105,195,196,197,198,199,200,201,202,203,204,-666666]}]',2166,'0:0:0:0:0:0:0:1','2019-05-07 15:49:15'),
(484,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":101,\"parentId\":189,\"name\":\"客户服务术语\",\"url\":\"tx/servingtech/servingtech\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":2,\"ifShow\":true}]',210,'0:0:0:0:0:0:0:1','2019-05-07 16:31:08'),
(485,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":27,\"roleName\":\"销售\",\"remark\":\"只拥有\\\"客户管理\\\"菜单功能, 和\\\"客户服务术语\\\"查看权限, 和 \\\"新增小区\\\" 权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,157,158,87,102,-666666,187,156,189,86,101]}]',1584,'0:0:0:0:0:0:0:1','2019-05-07 16:39:49'),
(486,'admin','修改角色','io.ttn.modules.sys.controller.SysRoleController.update()','[{\"roleId\":27,\"roleName\":\"销售\",\"remark\":\"只拥有\\\"客户管理\\\"菜单功能, 和\\\"客户服务术语\\\"查看权限, 和 \\\"新增小区\\\"  和\\\"查看业绩目标\\\"权限\",\"createUserId\":1,\"menuIdList\":[186,56,57,58,59,60,234,236,61,62,63,64,65,235,106,107,108,109,110,233,141,142,143,144,145,161,162,163,164,165,157,158,87,102,-666666,187,156,189,86,101]}]',956,'0:0:0:0:0:0:0:1','2019-05-07 16:40:29'),
(487,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":6,\"parentId\":0,\"name\":\"定时任务\",\"url\":\"job/schedule\",\"type\":1,\"icon\":\"job\",\"orderNum\":5,\"ifAdmin\":1,\"ifShow\":true}]',128,'0:0:0:0:0:0:0:1','2019-05-08 12:22:01'),
(488,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":6,\"parentId\":1,\"name\":\"定时任务\",\"url\":\"job/schedule\",\"type\":1,\"icon\":\"job\",\"orderNum\":5,\"ifAdmin\":1,\"ifShow\":true}]',163,'0:0:0:0:0:0:0:1','2019-05-08 12:22:39'),
(489,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":0,\"name\":\"部门员工管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":true}]',170,'0:0:0:0:0:0:0:1','2019-05-08 12:44:24'),
(490,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":0,\"name\":\"子账号管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"config\",\"orderNum\":0,\"ifAdmin\":0,\"ifShow\":true}]',238,'0:0:0:0:0:0:0:1','2019-05-08 12:45:28'),
(491,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":0,\"name\":\"报价模板\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":1,\"ifAdmin\":0,\"ifShow\":true}]',97,'0:0:0:0:0:0:0:1','2019-05-08 12:47:52'),
(492,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"type\":0,\"icon\":\"admin\",\"orderNum\":3,\"ifAdmin\":0,\"ifShow\":true}]',112,'0:0:0:0:0:0:0:1','2019-05-08 12:48:55'),
(493,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业行政管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":4,\"ifAdmin\":2,\"ifShow\":true}]',107,'0:0:0:0:0:0:0:1','2019-05-08 12:49:39'),
(494,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":188,\"name\":\"施工计划模板\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":7,\"ifAdmin\":0,\"ifShow\":true}]',192,'0:0:0:0:0:0:0:1','2019-05-08 12:51:06'),
(495,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":0,\"name\":\"报价模板\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"config\",\"orderNum\":1,\"ifAdmin\":0,\"ifShow\":true}]',130,'0:0:0:0:0:0:0:1','2019-05-08 12:51:29'),
(496,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":188,\"name\":\"施工管理\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":7,\"ifAdmin\":0,\"ifShow\":true}]',417,'0:0:0:0:0:0:0:1','2019-05-08 12:56:28'),
(497,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":0,\"name\":\"施工管理\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":5,\"ifAdmin\":0,\"ifShow\":true}]',100,'0:0:0:0:0:0:0:1','2019-05-08 12:56:58'),
(498,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":126,\"parentId\":187,\"name\":\"施工项定额\",\"url\":\"tx/project/projecttype\",\"type\":1,\"icon\":\"config\",\"orderNum\":0,\"ifAdmin\":0,\"ifShow\":true}]',122,'0:0:0:0:0:0:0:1','2019-05-08 12:57:09'),
(499,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":181,\"parentId\":0,\"name\":\"项目验收\",\"url\":\"tx/accept/accepttemplet\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":true}]',100,'0:0:0:0:0:0:0:1','2019-05-08 12:57:45'),
(500,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[188]',237,'0:0:0:0:0:0:0:1','2019-05-08 12:57:55'),
(501,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":1,\"parentId\":0,\"name\":\"系统管理\",\"type\":0,\"icon\":\"system\",\"orderNum\":10,\"ifAdmin\":1,\"ifShow\":true}]',111,'0:0:0:0:0:0:0:1','2019-05-08 13:00:54'),
(502,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":242,\"parentId\":0,\"name\":\"企业管理\",\"type\":0,\"icon\":\"shouye\",\"orderNum\":101,\"ifAdmin\":1,\"ifShow\":true}]',109,'0:0:0:0:0:0:0:1','2019-05-08 13:01:18'),
(503,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":1,\"parentId\":0,\"name\":\"系统管理\",\"type\":0,\"icon\":\"system\",\"orderNum\":102,\"ifAdmin\":1,\"ifShow\":true}]',137,'0:0:0:0:0:0:0:1','2019-05-08 13:01:24'),
(504,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":0,\"name\":\"施工管理\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"config\",\"orderNum\":3,\"ifAdmin\":0,\"ifShow\":true}]',100,'0:0:0:0:0:0:0:1','2019-05-08 13:01:50'),
(505,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"type\":0,\"icon\":\"admin\",\"orderNum\":5,\"ifAdmin\":0,\"ifShow\":true}]',126,'0:0:0:0:0:0:0:1','2019-05-08 13:02:23'),
(506,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":187,\"parentId\":0,\"name\":\"基础配置\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":true}]',116,'0:0:0:0:0:0:0:1','2019-05-08 13:02:37'),
(507,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":187,\"parentId\":0,\"name\":\"基础配置\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":7,\"ifAdmin\":0,\"ifShow\":true}]',116,'0:0:0:0:0:0:0:1','2019-05-08 13:03:04'),
(508,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":206,\"parentId\":0,\"name\":\"日常管理\",\"type\":0,\"icon\":\"bianji\",\"orderNum\":201,\"ifAdmin\":0,\"ifShow\":true}]',115,'0:0:0:0:0:0:0:1','2019-05-08 13:03:24'),
(509,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":205,\"parentId\":0,\"name\":\"进销存管理\",\"type\":0,\"icon\":\"sql\",\"orderNum\":202,\"ifAdmin\":0,\"ifShow\":true}]',278,'0:0:0:0:0:0:0:1','2019-05-08 13:03:37'),
(510,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":187,\"name\":\"功能菜单分配\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2,\"ifAdmin\":2,\"ifShow\":false}]',124,'0:0:0:0:0:0:0:1','2019-05-08 13:04:54'),
(511,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":187,\"name\":\"服务岗位设置\",\"url\":\"tx/sysposition/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3,\"ifAdmin\":2,\"ifShow\":false}]',123,'0:0:0:0:0:0:0:1','2019-05-08 13:05:04'),
(512,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":86,\"parentId\":187,\"name\":\"业绩目标\",\"url\":\"tx/target/target\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":true}]',171,'0:0:0:0:0:0:0:1','2019-05-08 13:05:14'),
(513,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":101,\"parentId\":0,\"name\":\"客户服务术语\",\"url\":\"tx/servingtech/servingtech\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":2,\"ifShow\":true}]',97,'0:0:0:0:0:0:0:1','2019-05-08 13:05:55'),
(514,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":101,\"parentId\":189,\"name\":\"客户服务术语\",\"url\":\"tx/servingtech/servingtech\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":2,\"ifShow\":true}]',117,'0:0:0:0:0:0:0:1','2019-05-08 13:07:12'),
(515,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":86,\"parentId\":189,\"name\":\"业绩目标\",\"url\":\"tx/target/target\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":true}]',129,'0:0:0:0:0:0:0:1','2019-05-08 13:07:58'),
(516,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":200,\"parentId\":189,\"name\":\"服务岗位设置\",\"url\":\"tx/sysposition/sysposition\",\"type\":1,\"icon\":\"config\",\"orderNum\":3,\"ifAdmin\":2,\"ifShow\":false}]',206,'0:0:0:0:0:0:0:1','2019-05-08 13:08:17'),
(517,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业行政管理\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":6,\"ifAdmin\":2,\"ifShow\":true}]',268,'0:0:0:0:0:0:0:1','2019-05-08 13:09:42'),
(518,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":181,\"parentId\":0,\"name\":\"项目验收\",\"url\":\"tx/accept/accepttemplet\",\"type\":1,\"icon\":\"config\",\"orderNum\":4,\"ifAdmin\":0,\"ifShow\":true}]',109,'0:0:0:0:0:0:0:1','2019-05-08 13:09:49'),
(519,'陈总','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[32]',270,'0:0:0:0:0:0:0:1','2019-05-08 13:13:33'),
(520,'陈总','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[29]',1,'0:0:0:0:0:0:0:1','2019-05-08 13:13:59'),
(521,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":31,\"parentId\":0,\"name\":\"子账号管理\",\"url\":\"sys/dept\",\"type\":1,\"icon\":\"admin\",\"orderNum\":0,\"ifAdmin\":0,\"ifShow\":true}]',104,'0:0:0:0:0:0:0:1','2019-05-08 13:20:22'),
(522,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":0,\"name\":\"报价模板\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"bianji\",\"orderNum\":1,\"ifAdmin\":0,\"ifShow\":true}]',154,'0:0:0:0:0:0:0:1','2019-05-08 13:20:37'),
(523,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":0,\"name\":\"施工管理\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"job\",\"orderNum\":3,\"ifAdmin\":0,\"ifShow\":true}]',85,'0:0:0:0:0:0:0:1','2019-05-08 13:21:02'),
(524,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":181,\"parentId\":0,\"name\":\"项目验收\",\"url\":\"tx/accept/accepttemplet\",\"type\":1,\"icon\":\"sousuo\",\"orderNum\":4,\"ifAdmin\":0,\"ifShow\":true}]',93,'0:0:0:0:0:0:0:1','2019-05-08 13:21:14'),
(525,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":186,\"parentId\":0,\"name\":\"客户管理\",\"type\":0,\"icon\":\"geren\",\"orderNum\":5,\"ifAdmin\":0,\"ifShow\":true}]',116,'0:0:0:0:0:0:0:1','2019-05-08 13:21:32'),
(526,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"企业行政管理\",\"type\":0,\"icon\":\"daohang\",\"orderNum\":6,\"ifAdmin\":2,\"ifShow\":true}]',93,'0:0:0:0:0:0:0:1','2019-05-08 13:22:08'),
(527,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":0,\"name\":\"报价表\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"bianji\",\"orderNum\":1,\"ifAdmin\":0,\"ifShow\":true}]',180,'0:0:0:0:0:0:0:1','2019-05-09 00:06:20'),
(528,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":151,\"parentId\":0,\"name\":\"施工管理\",\"url\":\"tx/plan/plantemplat\",\"type\":1,\"icon\":\"job\",\"orderNum\":3,\"ifAdmin\":0,\"ifShow\":false}]',108,'0:0:0:0:0:0:0:1','2019-05-11 22:21:29'),
(529,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":181,\"parentId\":0,\"name\":\"项目验收\",\"url\":\"tx/accept/accepttemplet\",\"type\":1,\"icon\":\"sousuo\",\"orderNum\":4,\"ifAdmin\":0,\"ifShow\":false}]',114,'0:0:0:0:0:0:0:1','2019-05-11 22:21:42'),
(530,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":161,\"parentId\":186,\"name\":\"客户记录\",\"url\":\"tx/client/clientinfo\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":false}]',236,'0:0:0:0:0:0:0:1','2019-05-11 23:29:32'),
(531,'陈总','删除用户','io.ttn.modules.sys.controller.SysUserController.delete()','[29]',0,'0:0:0:0:0:0:0:1','2019-05-12 10:28:11'),
(532,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":0,\"name\":\"报价表\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"bianji\",\"orderNum\":1,\"ifAdmin\":2,\"ifShow\":true}]',146,'0:0:0:0:0:0:0:1','2019-05-12 10:30:38'),
(533,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":259,\"parentId\":1,\"name\":\"首页管理\",\"url\":\"sys/index\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":1,\"ifShow\":true}]',9,'0:0:0:0:0:0:0:1','2019-07-05 16:01:16'),
(534,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":264,\"parentId\":1,\"name\":\"版本管理\",\"url\":\"sys/version\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":1,\"ifShow\":true}]',24,'0:0:0:0:0:0:0:1','2019-07-08 11:05:00'),
(535,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[256]',35,'0:0:0:0:0:0:0:1','2019-07-08 11:39:54'),
(536,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[257]',12,'0:0:0:0:0:0:0:1','2019-07-08 11:39:56'),
(537,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[258]',16,'0:0:0:0:0:0:0:1','2019-07-08 11:39:59'),
(538,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[255]',6,'0:0:0:0:0:0:0:1','2019-07-08 11:40:02'),
(539,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[254]',13,'0:0:0:0:0:0:0:1','2019-07-08 11:40:05'),
(540,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":187,\"parentId\":0,\"name\":\"基础配置\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":7,\"ifAdmin\":2,\"ifShow\":true}]',9,'0:0:0:0:0:0:0:1','2019-07-08 11:52:54'),
(541,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":189,\"parentId\":0,\"name\":\"行政管理\",\"type\":0,\"icon\":\"daohang\",\"orderNum\":6,\"ifAdmin\":2,\"ifShow\":true}]',10,'0:0:0:0:0:0:0:1','2019-07-08 11:55:00'),
(542,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":3,\"parentId\":187,\"name\":\"功能菜单分配\",\"url\":\"sys/role\",\"type\":1,\"icon\":\"role\",\"orderNum\":2,\"ifAdmin\":2,\"ifShow\":true}]',11,'0:0:0:0:0:0:0:1','2019-07-08 11:57:19'),
(543,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[263]',15,'0:0:0:0:0:0:0:1','2019-07-08 17:42:56'),
(544,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[262]',9,'0:0:0:0:0:0:0:1','2019-07-08 17:42:58'),
(545,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[261]',13,'0:0:0:0:0:0:0:1','2019-07-08 17:43:00'),
(546,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[260]',11,'0:0:0:0:0:0:0:1','2019-07-08 17:43:02'),
(547,'admin','删除菜单','io.ttn.modules.sys.controller.SysMenuController.delete()','[259]',5,'0:0:0:0:0:0:0:1','2019-07-08 17:43:05'),
(548,'admin','保存角色','io.ttn.modules.sys.controller.SysRoleController.save()','[{\"roleId\":31,\"roleName\":\"个人账号\",\"remark\":\"无账号管理，无客户公海池等功能。\",\"createUserId\":1,\"menuIdList\":[228,246,229,230,231,232,236,57,58,59,60,62,63,64,65,141,142,143,144,145,161,162,163,164,165,126,245,127,128,129,130,207,208,209,210,211,46,244,47,48,49,212,36,37,38,39,40,156,157,158,159,160,-666666,186,56,61,187],\"createTime\":\"Jul 9, 2019 10:18:01 AM\"}]',134,'0:0:0:0:0:0:0:1','2019-07-09 10:18:02'),
(549,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":36,\"parentId\":187,\"name\":\"选项设置\",\"url\":\"sys/dict\",\"type\":1,\"icon\":\"config\",\"orderNum\":6,\"ifAdmin\":0,\"ifShow\":true}]',9,'0:0:0:0:0:0:0:1','2019-07-09 11:03:20'),
(550,'admin','修改菜单','io.ttn.modules.sys.controller.SysMenuController.update()','[{\"menuId\":228,\"parentId\":0,\"name\":\"智能报价\",\"url\":\"tx/predict/predicttemplate\",\"type\":1,\"icon\":\"bianji\",\"orderNum\":1,\"ifAdmin\":2,\"ifShow\":true}]',4,'0:0:0:0:0:0:0:1','2019-07-09 11:27:02'),
(551,'admin','删除用户','top.czttn.modules.sys.controller.SysUserController.delete()','[32]',1,'0:0:0:0:0:0:0:1','2019-12-27 15:53:50'),
(552,'admin','删除用户','top.czttn.modules.sys.controller.SysUserController.delete()','[32]',1,'0:0:0:0:0:0:0:1','2019-12-27 15:54:04'),
(553,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"18912322211@163.com\",\"userId\":33,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"仲采白\",\"password\":\"25a3ef5e9229ba8cf2cb7e9862a61b3a58716fadd0c9f59bf6f53f230a237855\",\"salt\":\"4zh4Jtl3FfYjY8HY4Gvm\",\"mobile\":\"18912322211\",\"job\":\"销售\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 3:59:37 PM\"}]',98,'0:0:0:0:0:0:0:1','2019-12-27 15:59:38'),
(554,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"18923211111@163.com\",\"userId\":34,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"祁紫菱\",\"password\":\"218b4c2996dedcc68c3b86e59de089be892ba7ae57cc24410b9be7d1555d5d69\",\"salt\":\"4TSBRTjXUWjGsuXHVcf0\",\"mobile\":\"18923211111\",\"job\":\"销售\",\"entry\":\"Dec 2, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 4:00:13 PM\"}]',14,'0:0:0:0:0:0:0:1','2019-12-27 16:00:14'),
(555,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"email\":\"18912322211@163.com\",\"userId\":0,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"詹怡月\",\"password\":\"000000\",\"mobile\":\"18912322211\",\"job\":\"工人\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1]}]',0,'0:0:0:0:0:0:0:1','2019-12-27 16:00:54'),
(556,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"email\":\"18912322211@163.com\",\"userId\":0,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"詹怡月\",\"password\":\"000000\",\"mobile\":\"18912322212\",\"job\":\"工人\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1]}]',1,'0:0:0:0:0:0:0:1','2019-12-27 16:00:59'),
(557,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"18912322212@163.com\",\"userId\":35,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"詹怡月\",\"password\":\"a9eec08920016d9f4536e9f6617a6c7f624533b9480322c0826599bc735c543b\",\"salt\":\"Yp6Z1yPf31OB3ft5AsbO\",\"mobile\":\"18912322212\",\"job\":\"工人\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 4:01:02 PM\"}]',10,'0:0:0:0:0:0:0:1','2019-12-27 16:01:02'),
(558,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"18912322255@163.com\",\"userId\":36,\"deptId\":6,\"deptName\":\"销售二部\",\"username\":\"眭痴香\",\"password\":\"4bdeb7d5bc1b7d22245044f6fee47e7317cdea108a3d0a757abc08bb47db1e29\",\"salt\":\"EynRsDigFXL6idk4OBzW\",\"mobile\":\"18912322255\",\"job\":\"销售\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 4:01:50 PM\"}]',6,'0:0:0:0:0:0:0:1','2019-12-27 16:01:51'),
(559,'张三','修改用户','top.czttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"email\":\"18988888888@163.com\",\"ifMain\":true,\"lastLoginTime\":\"2019-12-27 15:58:06.0\",\"userId\":10,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"张三\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"mobile\":\"18988888888\",\"job\":\"CEO\",\"entry\":\"Oct 9, 2018 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[1],\"positionIdList\":[],\"createTime\":\"Feb 28, 2019 10:36:29 AM\"}]',16,'0:0:0:0:0:0:0:1','2019-12-27 16:02:26'),
(560,'张三','修改用户','top.czttn.modules.sys.controller.SysUserController.update()','[{\"cpId\":1,\"email\":\"18912322255@163.com\",\"ifMain\":false,\"userId\":36,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"眭痴香\",\"password\":\"4bdeb7d5bc1b7d22245044f6fee47e7317cdea108a3d0a757abc08bb47db1e29\",\"salt\":\"EynRsDigFXL6idk4OBzW\",\"mobile\":\"18912322255\",\"job\":\"销售\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 4:01:51 PM\"}]',8,'0:0:0:0:0:0:0:1','2019-12-27 16:02:39'),
(561,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"18922222222@163.com\",\"ifMain\":false,\"userId\":37,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"牛景明\",\"password\":\"54a641f13ae1526ca717c310e7342fb2d3dd28cbc9f266a66f573868299862b6\",\"salt\":\"H9eIScbrGqC86JQhzrVK\",\"mobile\":\"18922222222\",\"job\":\"技术\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 4:03:29 PM\"}]',14,'0:0:0:0:0:0:0:1','2019-12-27 16:03:29'),
(562,'张三','保存用户','top.czttn.modules.sys.controller.SysUserController.save()','[{\"cpId\":1,\"email\":\"18912355555@163.com\",\"ifMain\":false,\"userId\":38,\"deptId\":2,\"deptName\":\"综合管理部\",\"username\":\"呼玉树\",\"password\":\"db8b714c7fa9656ebf8d58568cbbc3bdcfc34124a1aa04798e6215228f514ca6\",\"salt\":\"iQJMrAgyzvyIY3XT7aiR\",\"mobile\":\"18912355555\",\"job\":\"销售\",\"entry\":\"Nov 30, 2019 12:00:00 AM\",\"ifOn\":true,\"roleIdList\":[11],\"positionIdList\":[1],\"createTime\":\"Dec 27, 2019 4:04:02 PM\"}]',14,'0:0:0:0:0:0:0:1','2019-12-27 16:04:03'),
(563,'admin','修改密码','top.czttn.modules.sys.controller.SysUserController.password()','[{\"password\":\"xiao86ze\",\"newPassword\":\"admin\"}]',8,'0:0:0:0:0:0:0:1','2019-12-27 17:55:47');

/*Table structure for table `sys_menu` */

CREATE TABLE `sys_menu` (
                            `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
                            `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
                            `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
                            `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
                            `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
                            `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
                            `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
                            `order_num` int(11) DEFAULT NULL COMMENT '排序',
                            `if_admin` int(11) NOT NULL DEFAULT '0' COMMENT '是否超级菜单',
                            `if_show` int(11) NOT NULL DEFAULT '1' COMMENT '普通用户导航是否显示',
                            PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`if_admin`,`if_show`) values
(1,0,'系统管理',NULL,NULL,0,'system',102,1,1),
(3,187,'功能菜单分配','sys/role',NULL,1,'role',2,2,1),
(4,1,'菜单管理','sys/menu',NULL,1,'menu',3,1,1),
(5,1,'SQL监控','http://localhost:8080/druid/sql.html',NULL,1,'sql',4,1,1),
(6,1,'定时任务','job/schedule',NULL,1,'job',5,1,1),
(7,6,'查看',NULL,'sys:schedule:list,sys:schedule:info',2,NULL,0,1,1),
(8,6,'新增',NULL,'sys:schedule:save',2,NULL,0,1,1),
(9,6,'修改',NULL,'sys:schedule:update',2,NULL,0,1,1),
(10,6,'删除',NULL,'sys:schedule:delete',2,NULL,0,1,1),
(11,6,'暂停',NULL,'sys:schedule:pause',2,NULL,0,1,1),
(12,6,'恢复',NULL,'sys:schedule:resume',2,NULL,0,1,1),
(13,6,'立即执行',NULL,'sys:schedule:run',2,NULL,0,1,1),
(14,6,'日志列表',NULL,'sys:schedule:log',2,NULL,0,1,1),
(19,3,'查看',NULL,'sys:role:list,sys:role:info',2,NULL,0,0,1),
(20,3,'新增',NULL,'sys:role:save,sys:menu:list',2,NULL,0,0,1),
(21,3,'修改',NULL,'sys:role:update,sys:menu:list',2,NULL,0,0,1),
(22,3,'删除',NULL,'sys:role:delete',2,NULL,0,0,1),
(23,4,'查看',NULL,'sys:menu:list,sys:menu:info',2,NULL,0,1,1),
(24,4,'新增',NULL,'sys:menu:save,sys:menu:select',2,NULL,0,1,1),
(25,4,'修改',NULL,'sys:menu:update,sys:menu:select',2,NULL,0,1,1),
(26,4,'删除',NULL,'sys:menu:delete',2,NULL,0,1,1),
(27,1,'参数管理','sys/config','sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete',1,'config',6,1,1),
(29,1,'系统日志','sys/log','sys:log:list',1,'log',7,1,1),
(30,1,'文件上传','oss/oss','sys:oss:all',1,'oss',6,1,1),
(31,0,'子账号管理','sys/dept',NULL,1,'admin',0,0,1),
(32,31,'查看',NULL,'sys:dept:list,sys:dept:info,sys:user:list,sys:user:info',2,NULL,6,0,1),
(33,31,'新增',NULL,'sys:dept:save,sys:user:save,sys:role:select',2,NULL,6,0,1),
(34,31,'修改',NULL,'sys:dept:update,sys:user:update,sys:role:select',2,NULL,6,0,1),
(35,31,'删除',NULL,'sys:dept:delete,sys:user:delete',2,NULL,6,0,1),
(36,187,'选项设置','sys/dict',NULL,1,'config',6,0,1),
(37,36,'查看',NULL,'sys:dict:list,sys:dict:info',2,NULL,6,0,1),
(38,36,'新增',NULL,'sys:dict:save',2,NULL,6,0,1),
(39,36,'修改',NULL,'sys:dict:update',2,NULL,6,0,1),
(40,36,'删除',NULL,'sys:dict:delete',2,NULL,6,0,1),
(41,1,'字典类型','sys/dicttype',NULL,1,'config',6,1,1),
(42,41,'查看',NULL,'sys:dicttype:list,sys:dicttype:info',2,NULL,6,1,1),
(43,41,'新增',NULL,'sys:dicttype:save',2,NULL,6,1,1),
(44,41,'修改',NULL,'sys:dicttype:update',2,NULL,6,1,1),
(45,41,'删除',NULL,'sys:dicttype:delete',2,NULL,6,1,1),
(46,187,'材料管理','tx/material/materialtype',NULL,1,'config',2,0,1),
(47,46,'查看',NULL,'tx:materialtype:list,tx:materialtype:info,tx:material:list,tx:material:info',2,NULL,6,0,1),
(48,46,'新增',NULL,'tx:materialtype:save,tx:material:save',2,NULL,6,0,1),
(49,46,'修改',NULL,'tx:materialtype:update,tx:material:update',2,NULL,6,0,1),
(56,186,'我的客户','tx/client/formalclient',NULL,1,'config',6,0,1),
(57,56,'查看',NULL,'tx:formalclient:list,tx:formalclient:info',2,NULL,6,0,1),
(58,56,'新增',NULL,'tx:formalclient:save',2,NULL,6,0,1),
(59,56,'修改',NULL,'tx:formalclient:update',2,NULL,6,0,1),
(60,56,'删除',NULL,'tx:formalclient:delete',2,NULL,6,0,1),
(61,186,'逃单客户','tx/client/escapeclient',NULL,1,'config',6,0,1),
(62,61,'查看',NULL,'tx:escapeclient:list,tx:escapeclient:info',2,NULL,6,0,1),
(63,61,'新增',NULL,'tx:escapeclient:save',2,NULL,6,0,1),
(64,61,'修改',NULL,'tx:escapeclient:update',2,NULL,6,0,1),
(65,61,'删除',NULL,'tx:escapeclient:delete',2,NULL,6,0,1),
(66,206,'施工日志','tx/constructionlog/constructionlog',NULL,1,'config',6,0,1),
(67,66,'查看',NULL,'tx:constructionlog:list,tx:constructionlog:info',2,NULL,6,0,1),
(68,66,'新增',NULL,'tx:constructionlog:save',2,NULL,6,0,1),
(69,66,'修改',NULL,'tx:constructionlog:update',2,NULL,6,0,1),
(70,66,'删除',NULL,'tx:constructionlog:delete',2,NULL,6,0,1),
(76,206,'投诉管理','tx/complaint/complaint',NULL,1,'config',6,0,1),
(77,76,'查看',NULL,'tx:complaint:list,tx:complaint:info,tx:complaintinfo:list,tx:complaintinfo:info',2,NULL,6,0,1),
(78,76,'新增',NULL,'tx:complaint:save,tx:complaintinfo:save',2,NULL,6,0,1),
(79,76,'修改',NULL,'tx:complaint:update,tx:complaintinfo:update',2,NULL,6,0,1),
(80,76,'删除',NULL,'tx:complaint:delete,tx:complaintinfo:delete',2,NULL,6,0,1),
(81,206,'任务','tx/task/task',NULL,1,'config',6,0,1),
(82,81,'查看',NULL,'tx:task:list,tx:task:info',2,NULL,6,0,1),
(83,81,'新增',NULL,'tx:task:save',2,NULL,6,0,1),
(84,81,'修改',NULL,'tx:task:update',2,NULL,6,0,1),
(85,81,'删除',NULL,'tx:task:delete',2,NULL,6,0,1),
(86,189,'业绩目标','tx/target/target',NULL,1,'config',6,0,1),
(87,86,'查看',NULL,'tx:target:list,tx:target:info',2,NULL,6,0,1),
(88,86,'新增',NULL,'tx:target:save',2,NULL,6,0,1),
(89,86,'修改',NULL,'tx:target:update',2,NULL,6,0,1),
(90,86,'删除',NULL,'tx:target:delete',2,NULL,6,0,1),
(91,205,'供应商管理','tx/supplier/supplier',NULL,1,'config',6,0,1),
(92,91,'查看',NULL,'tx:supplier:list,tx:supplier:info',2,NULL,6,0,1),
(93,91,'新增',NULL,'tx:supplier:save',2,NULL,6,0,1),
(94,91,'修改',NULL,'tx:supplier:update',2,NULL,6,0,1),
(95,91,'删除',NULL,'tx:supplier:delete',2,NULL,6,0,1),
(96,205,'仓库管理','tx/store/store',NULL,1,'config',6,0,1),
(97,96,'查看',NULL,'tx:store:list,tx:store:info',2,NULL,6,0,1),
(98,96,'新增',NULL,'tx:store:save',2,NULL,6,0,1),
(99,96,'修改',NULL,'tx:store:update',2,NULL,6,0,1),
(100,96,'删除',NULL,'tx:store:delete',2,NULL,6,0,1),
(101,189,'客户服务术语','tx/servingtech/servingtech',NULL,1,'config',6,2,1),
(102,101,'查看',NULL,'tx:servingtech:list,tx:servingtech:info',2,NULL,6,0,1),
(103,101,'新增',NULL,'tx:servingtech:save',2,NULL,6,0,1),
(104,101,'修改',NULL,'tx:servingtech:update',2,NULL,6,0,1),
(105,101,'删除',NULL,'tx:servingtech:delete',2,NULL,6,0,1),
(106,186,'客户公海池','tx/client/seaclient',NULL,1,'config',6,0,1),
(107,106,'查看',NULL,'tx:seaclient:list,tx:seaclient:info',2,NULL,6,0,1),
(108,106,'新增',NULL,'tx:seaclient:save',2,NULL,6,0,1),
(109,106,'修改',NULL,'tx:seaclient:update',2,NULL,6,0,1),
(110,106,'删除',NULL,'tx:seaclient:delete',2,NULL,6,0,1),
(111,206,'报修管理消息记录','tx/repair/repairinfo',NULL,1,'config',6,0,1),
(112,111,'查看',NULL,'tx:repairinfo:list,tx:repairinfo:info',2,NULL,6,0,1),
(113,111,'新增',NULL,'tx:repairinfo:save',2,NULL,6,0,1),
(114,111,'修改',NULL,'tx:repairinfo:update',2,NULL,6,0,1),
(115,111,'删除',NULL,'tx:repairinfo:delete',2,NULL,6,0,1),
(116,206,'报修管理','tx/repair/repair',NULL,1,'config',6,0,1),
(117,116,'查看',NULL,'tx:repair:list,tx:repair:info',2,NULL,6,0,1),
(118,116,'新增',NULL,'tx:repair:save',2,NULL,6,0,1),
(119,116,'修改',NULL,'tx:repair:update',2,NULL,6,0,1),
(120,116,'删除',NULL,'tx:repair:delete',2,NULL,6,0,1),
(121,205,'单据类型维护','tx/receipt/receipt',NULL,1,'config',6,0,1),
(122,121,'查看',NULL,'tx:receipt:list,tx:receipt:info',2,NULL,6,0,1),
(123,121,'新增',NULL,'tx:receipt:save',2,NULL,6,0,1),
(124,121,'修改',NULL,'tx:receipt:update',2,NULL,6,0,1),
(125,121,'删除',NULL,'tx:receipt:delete',2,NULL,6,0,1),
(126,187,'施工项定额','tx/project/projecttype',NULL,1,'config',0,0,1),
(127,126,'查看',NULL,'tx:projecttype:list,tx:projecttype:info,tx:project:list,tx:project:info',2,NULL,6,0,1),
(128,126,'新增',NULL,'tx:projecttype:save,tx:project:save',2,NULL,6,0,1),
(129,126,'修改',NULL,'tx:projecttype:update,tx:project:update',2,NULL,6,0,1),
(130,126,'删除',NULL,'tx:projecttype:delete,tx:project:delete',2,NULL,6,0,1),
(136,187,'售前阶段','tx/presale/presale',NULL,1,'config',6,0,1),
(137,136,'查看',NULL,'tx:presale:list,tx:presale:info',2,NULL,6,0,1),
(138,136,'新增',NULL,'tx:presale:save',2,NULL,6,0,1),
(139,136,'修改',NULL,'tx:presale:update',2,NULL,6,0,1),
(140,136,'删除',NULL,'tx:presale:delete',2,NULL,6,0,1),
(141,186,'预约客户','tx/client/clientpre',NULL,1,'config',6,0,1),
(142,141,'查看',NULL,'tx:clientpre:list,tx:clientpre:info',2,NULL,6,0,1),
(143,141,'新增',NULL,'tx:clientpre:save',2,NULL,6,0,1),
(144,141,'修改',NULL,'tx:clientpre:update',2,NULL,6,0,1),
(145,141,'删除',NULL,'tx:clientpre:delete',2,NULL,6,0,1),
(151,0,'施工管理','tx/plan/plantemplat',NULL,1,'job',3,0,0),
(152,151,'查看',NULL,'tx:plantemplat:list,tx:plantemplat:info',2,NULL,6,0,1),
(153,151,'新增',NULL,'tx:plantemplat:save',2,NULL,6,0,1),
(154,151,'修改',NULL,'tx:plantemplat:update',2,NULL,6,0,1),
(155,151,'删除',NULL,'tx:plantemplat:delete',2,NULL,6,0,1),
(156,187,'小区维护','tx/community/community',NULL,1,'config',6,0,1),
(157,156,'查看',NULL,'tx:community:list,tx:community:info',2,NULL,6,0,1),
(158,156,'新增',NULL,'tx:community:save',2,NULL,6,0,1),
(159,156,'修改',NULL,'tx:community:update',2,NULL,6,0,1),
(160,156,'删除',NULL,'tx:community:delete',2,NULL,6,0,1),
(161,186,'客户记录','tx/client/clientinfo',NULL,1,'config',6,0,0),
(162,161,'查看',NULL,'tx:clientinfo:list,tx:clientinfo:info',2,NULL,6,0,1),
(163,161,'新增',NULL,'tx:clientinfo:save',2,NULL,6,0,1),
(164,161,'修改',NULL,'tx:clientinfo:update',2,NULL,6,0,1),
(165,161,'删除',NULL,'tx:clientinfo:delete',2,NULL,6,0,1),
(171,187,'考勤管理','tx/attendance/attendance',NULL,1,'config',6,0,1),
(172,171,'查看',NULL,'tx:attendance:list,tx:attendance:info',2,NULL,6,0,1),
(173,171,'新增',NULL,'tx:attendance:save',2,NULL,6,0,1),
(174,171,'修改',NULL,'tx:attendance:update',2,NULL,6,0,1),
(175,171,'删除',NULL,'tx:attendance:delete',2,NULL,6,0,1),
(181,0,'项目验收','tx/accept/accepttemplet',NULL,1,'sousuo',4,0,0),
(182,181,'查看',NULL,'tx:accepttemplet:list,tx:accepttemplet:info',2,NULL,6,0,1),
(183,181,'新增',NULL,'tx:accepttemplet:save',2,NULL,6,0,1),
(184,181,'修改',NULL,'tx:accepttemplet:update',2,NULL,6,0,1),
(185,181,'删除',NULL,'tx:accepttemplet:delete',2,NULL,6,0,1),
(186,0,'客户管理',NULL,NULL,0,'geren',5,0,1),
(187,0,'基础配置',NULL,NULL,0,'zonghe',7,2,1),
(189,0,'行政管理',NULL,NULL,0,'daohang',6,2,1),
(195,189,'离职员工','tx/sysretired/sysretired',NULL,1,'config',6,0,0),
(196,195,'查看',NULL,'tx:sysretired:list,tx:sysretired:info',2,NULL,6,0,1),
(197,195,'新增',NULL,'tx:sysretired:save',2,NULL,6,0,1),
(198,195,'修改',NULL,'tx:sysretired:update',2,NULL,6,0,1),
(199,195,'删除',NULL,'tx:sysretired:delete',2,NULL,6,0,1),
(200,189,'服务岗位设置','tx/sysposition/sysposition',NULL,1,'config',3,2,0),
(201,200,'查看',NULL,'tx:sysposition:list,tx:sysposition:info',2,NULL,6,0,1),
(202,200,'新增',NULL,'tx:sysposition:save',2,NULL,6,0,1),
(203,200,'修改',NULL,'tx:sysposition:update',2,NULL,6,0,1),
(204,200,'删除',NULL,'tx:sysposition:delete',2,NULL,6,0,1),
(205,0,'进销存管理',NULL,NULL,0,'sql',202,0,1),
(206,0,'日常管理',NULL,NULL,0,'bianji',201,0,1),
(207,187,'品牌维护','tx/brand/brandclass',NULL,1,'config',1,0,1),
(208,207,'查看',NULL,'tx:brandclass:list,tx:brandclass:info,tx:brand:list,tx:brand:info',2,NULL,6,0,1),
(209,207,'新增',NULL,'tx:brandclass:save,tx:brand:save',2,NULL,6,0,1),
(210,207,'修改',NULL,'tx:brand:update,tx:brandclass:update',2,NULL,6,0,1),
(211,207,'删除',NULL,'tx:brandclass:delete,tx:brand:delete',2,NULL,6,0,1),
(212,46,'删除',NULL,'tx:materialtype:delete,tx:material:delete',2,NULL,6,0,1),
(228,0,'智能报价','tx/predict/predicttemplate',NULL,1,'bianji',1,2,1),
(229,228,'查看',NULL,'tx:predicttemplate:list,tx:predicttemplate:info',2,NULL,6,0,1),
(230,228,'新增',NULL,'tx:predicttemplate:save',2,NULL,6,0,1),
(231,228,'修改',NULL,'tx:predicttemplate:update',2,NULL,6,0,1),
(232,228,'删除',NULL,'tx:predicttemplate:delete',2,NULL,6,0,1),
(233,106,'领取',NULL,'tx:seaclient:receive',2,NULL,0,0,1),
(234,56,'转入公海',NULL,'tx:formalclient:sea',2,NULL,0,0,1),
(235,61,'转入公海',NULL,'tx:escapeclient:sea',2,NULL,0,0,1),
(236,56,'逃单',NULL,'tx:formalclient:escape',2,NULL,0,0,1),
(237,242,'企业管理','sys/company',NULL,1,'config',6,1,1),
(238,237,'查看',NULL,'sys:company:list,sys:company:info',2,NULL,6,1,1),
(239,237,'新增',NULL,'sys:company:save',2,NULL,6,1,1),
(240,237,'修改',NULL,'sys:company:update',2,NULL,6,1,1),
(241,237,'删除',NULL,'sys:company:delete',2,NULL,6,1,1),
(242,0,'企业管理',NULL,NULL,0,'shouye',101,1,1),
(243,242,'用户管理','sys/user',NULL,1,'admin',0,1,1),
(244,46,'导入',NULL,'tx:material:import',2,NULL,0,0,1),
(245,126,'导出',NULL,'tx:project:export',2,NULL,0,0,1),
(246,228,'导出',NULL,'tx:predicttemplate:export',2,NULL,0,0,1),
(247,31,'离职',NULL,'sys:user:retired',2,NULL,0,0,1),
(248,31,'转客户',NULL,'sys:user:exchange',2,NULL,0,0,1),
(249,1,'开户申请','sys/companyregist',NULL,1,'config',6,1,1),
(250,249,'查看',NULL,'sys:companyregist:list,sys:companyregist:info',2,NULL,6,1,1),
(251,249,'新增',NULL,'sys:companyregist:save',2,NULL,6,1,1),
(252,249,'修改',NULL,'sys:companyregist:update',2,NULL,6,1,1),
(253,249,'删除',NULL,'sys:companyregist:delete',2,NULL,6,1,1),
(264,1,'版本管理','sys/version',NULL,1,'config',6,1,1),
(265,264,'查看',NULL,'sys:version:list,sys:version:info',2,NULL,6,0,1),
(266,264,'新增',NULL,'sys:version:save',2,NULL,6,0,1),
(267,264,'修改',NULL,'sys:version:update',2,NULL,6,0,1),
(268,264,'删除',NULL,'sys:version:delete',2,NULL,6,0,1);

/*Table structure for table `sys_oss` */

CREATE TABLE `sys_oss` (
                           `id` bigint(20) NOT NULL AUTO_INCREMENT,
                           `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
                           `create_date` datetime DEFAULT NULL COMMENT '创建时间',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='文件上传';

/*Data for the table `sys_oss` */

insert  into `sys_oss`(`id`,`url`,`create_date`) values
(1,'http://www.czttn.top/20190218/b519142e49744633861fad6685a3c822.png','2019-02-18 16:36:54'),
(2,'http://www.czttn.top/20190218/9b22a4fbc4a043e4a35548157fc1bed2.png','2019-02-18 16:37:04'),
(3,'http://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/2d37bd6e7fc241519729536aa5ac45df.png','2019-02-18 16:42:50'),
(4,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/98cd92b2b16a470b8dc2e5ddd5fcd032.png','2019-02-18 16:46:11'),
(5,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/2d28261541694f4982e9bb5e9181544f.png','2019-02-18 16:56:29'),
(6,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/f0abcd53d7ae4dbc8d9da0f9d994f824.png','2019-02-18 17:24:37'),
(7,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/c94e3783ca9a4bfeafd372472bd8d38e.png','2019-02-18 17:25:06'),
(8,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/17f28ace5f1f4faaa242cf394f864b4f.png','2019-02-18 17:26:12'),
(9,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/422faddb2c6f436f82f0ad8c374d7f57.png','2019-02-18 17:26:17'),
(10,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/7d2c7b7af3e54368b44fb4b23c4e6fed.png','2019-02-18 17:28:16'),
(11,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/273da50b3c724f8db2e572a120857321.png','2019-02-18 17:28:21'),
(12,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/e82fedf2c91d4e1b877a08d35f46fe71.png','2019-02-18 17:28:23'),
(13,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/48cec865266d444eb4f3d870bd6b8a92.png','2019-02-18 17:32:01'),
(14,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/e57a7f1f8074484e89529fe799ffde84.png','2019-02-18 17:32:03'),
(15,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/cfb04de4147d4f6a807d91ebb38aa160.png','2019-02-18 17:32:06'),
(16,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/7f21785b13a54e208b333e6c795d5d2f.png','2019-02-18 17:37:31'),
(17,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/d3eec5c7c3b94e17937d86317181999f.png','2019-02-18 17:37:34'),
(18,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/ad9e12f57d954d92887306dc0934d6f7.png','2019-02-18 17:37:39'),
(19,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/ff6fa81f25164fe58200e6f30bb50875.png','2019-02-18 17:41:20'),
(20,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/4fe7dc8b6b9e4823a5b95b57dddfff46.png','2019-02-18 17:41:25'),
(21,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/e97468fa374f410fbb191746674dca34.png','2019-02-18 17:42:44'),
(22,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/3b81ae2b84be4c4cae09e4ee9ac66b80.png','2019-02-18 17:45:33'),
(23,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/4dbf6846412c4ab79c909dd4e2882eb7.png','2019-02-18 17:47:52'),
(24,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/eeee6f32db574c36b31ef9558cc0dac1.png','2019-02-18 17:54:47'),
(25,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/0ea8ac6f06214da7a2d7242fd2068123.png','2019-02-18 17:56:20'),
(26,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/12594d5106394d36bd8543fa002f6360.png','2019-02-18 17:57:00'),
(27,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/4d92f018a8484b5691fa0571e0fb6396.png','2019-02-18 17:57:39'),
(28,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/9d54139c47714722aa734f7bf66e869d.png','2019-02-18 18:01:40'),
(29,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/d2b922b8e8e34ff89f8e0537160616b2.png','2019-02-18 18:02:09'),
(30,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/57ba454b28dd4f6d9166c91674f55749.png','2019-02-18 18:03:23'),
(31,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/e014f759a5af4663b940eb84517dd967.png','2019-02-18 18:03:45'),
(32,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/cea7a56ab4ee43b29835b3dadbab85df.png','2019-03-02 22:28:05'),
(33,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/4bae891930064d4f94752ccfb4f480f8.png','2019-03-02 22:52:03'),
(34,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/91b0d74bbf3049f8916fab860de703fc.png','2019-03-02 22:56:29'),
(35,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/d851273dd9c54c5ebad178c1b91e37f3.png','2019-03-02 22:58:33'),
(36,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/4e5edde705534b32851712fac9438213.csv','2019-03-02 23:05:50'),
(37,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/80ff1389449a4afdb4ecba99545120c9.jpg','2019-03-02 23:06:28'),
(38,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190327/8e1790b9677b47a4ad68c067144d78c2.jpg','2019-03-27 01:06:19'),
(39,'https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190507/2b13a660c1a146c38604155405c9e56f.jpg','2019-05-07 17:55:07');

/*Table structure for table `sys_position` */

CREATE TABLE `sys_position` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `name` varchar(50) NOT NULL COMMENT '岗位名称',
                                `if_on` tinyint(1) NOT NULL COMMENT '是否启用',
                                `description` varchar(100) DEFAULT NULL COMMENT '服务岗位描述',
                                `cp_id` bigint(20) DEFAULT NULL,
                                `if_common` int(11) NOT NULL DEFAULT '0' COMMENT '是否基础数据',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='公司职位';

/*Data for the table `sys_position` */

insert  into `sys_position`(`id`,`name`,`if_on`,`description`,`cp_id`,`if_common`) values
(1,'销售',1,'销售岗位',1,0),
(2,'设计师',0,'设计图纸',1,0),
(3,'项目经理',1,'管控项目质量和进度',1,0),
(4,'会计',1,'财务核算',1,0),
(5,'工程部',1,'工程管理',2,0),
(6,'设计部',1,'设计任务管理',2,0),
(7,'业务部',1,'业务管理',2,0),
(9,'销售',1,'销售人员',NULL,1),
(10,'设计师',1,'效果,工程图纸设计人员',NULL,1),
(11,'会计',1,'财务管理人员',NULL,1),
(12,'销售',1,'销售人员',6,0),
(13,'设计师',1,'效果,工程图纸设计人员',6,0),
(14,'会计',1,'财务管理人员',6,0),
(15,'销售',1,'销售人员',7,0),
(16,'设计师',1,'效果,工程图纸设计人员',7,0),
(17,'会计',1,'财务管理人员',7,0),
(18,'销售',1,'销售人员',8,0),
(19,'设计师',1,'效果,工程图纸设计人员',8,0),
(20,'会计',1,'财务管理人员',8,0),
(21,'销售',1,'销售人员',1,0),
(22,'设计师',1,'效果,工程图纸设计人员',1,0),
(23,'会计',1,'财务管理人员',1,0);

/*Table structure for table `sys_retired` */

CREATE TABLE `sys_retired` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                               `name` varchar(20) NOT NULL COMMENT '姓名',
                               `phone` varchar(20) NOT NULL COMMENT '手机号',
                               `entry_time` datetime NOT NULL COMMENT '入职日期',
                               `job` varchar(20) NOT NULL COMMENT '公司职位',
                               `cp_id` bigint(20) DEFAULT NULL COMMENT '所属公司',
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='离职员工';

/*Data for the table `sys_retired` */

insert  into `sys_retired`(`id`,`name`,`phone`,`entry_time`,`job`,`cp_id`) values
(2,'测试','18912322277','2019-03-18 00:00:00','测试',1),
(4,'换','12222222222','2019-03-05 00:00:00','测试',1);

/*Table structure for table `sys_role` */

CREATE TABLE `sys_role` (
                            `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
                            `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
                            `remark` varchar(100) DEFAULT NULL COMMENT '备注',
                            `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `cp_id` bigint(20) DEFAULT NULL,
                            `if_common` int(11) NOT NULL DEFAULT '0' COMMENT '是否为通用数据',
                            PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='角色';

/*Data for the table `sys_role` */

insert  into `sys_role`(`role_id`,`role_name`,`remark`,`create_user_id`,`create_time`,`cp_id`,`if_common`) values
(1,'一级','企业拥有的部分权限，新增用户权限',1,'2018-10-13 01:26:09',NULL,0),
(9,'二级','企业拥有部分权限，包括新增用户',1,'2019-02-28 10:16:29',NULL,0),
(10,'超管','所有权限',1,'2019-02-28 10:17:26',NULL,0),
(11,'业务员','只有客户管理权限',10,'2019-02-28 23:58:12',1,0),
(12,'工程部经理','拥有模板等设计权限',10,'2019-02-28 23:59:00',1,0),
(16,'测试2','测试',10,'2019-03-05 22:51:09',1,0),
(17,'业务员',NULL,24,'2019-05-06 16:49:28',2,0),
(20,'设计师',NULL,24,'2019-05-06 16:52:02',2,0),
(21,'项目经理',NULL,24,'2019-05-06 16:55:22',2,0),
(27,'销售','只拥有\"客户管理\"菜单功能, 和\"客户服务术语\"查看权限, 和 \"新增小区\"  和\"查看业绩目标\"权限',1,'2019-05-07 15:46:39',NULL,1),
(28,'总经理','拥有所有菜单权限',1,'2019-05-07 15:47:58',NULL,1),
(29,'销售','只拥有\"客户管理\"菜单功能',1,'2019-05-07 15:46:39',6,0),
(30,'总经理','拥有所有菜单权限',1,'2019-05-07 15:47:58',6,0),
(31,'个人账号','无账号管理，无客户公海池等功能。',1,'2019-07-09 10:18:02',NULL,0),
(32,'销售','只拥有\"客户管理\"菜单功能, 和\"客户服务术语\"查看权限, 和 \"新增小区\"  和\"查看业绩目标\"权限',1,'2019-05-07 15:46:39',7,0),
(33,'总经理','拥有所有菜单权限',1,'2019-05-07 15:47:58',7,0),
(34,'销售','只拥有\"客户管理\"菜单功能, 和\"客户服务术语\"查看权限, 和 \"新增小区\"  和\"查看业绩目标\"权限',1,'2019-05-07 15:46:39',8,0),
(35,'总经理','拥有所有菜单权限',1,'2019-05-07 15:47:58',8,0),
(36,'销售','只拥有\"客户管理\"菜单功能, 和\"客户服务术语\"查看权限, 和 \"新增小区\"  和\"查看业绩目标\"权限',1,'2019-05-07 15:46:39',1,0),
(37,'总经理','拥有所有菜单权限',1,'2019-05-07 15:47:58',1,0);

/*Table structure for table `sys_role_menu` */

CREATE TABLE `sys_role_menu` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
                                 `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3077 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values
(772,11,186),
(773,11,56),
(774,11,57),
(775,11,58),
(776,11,59),
(777,11,60),
(778,11,234),
(779,11,236),
(780,11,61),
(781,11,62),
(782,11,63),
(783,11,64),
(784,11,65),
(785,11,235),
(786,11,106),
(787,11,107),
(788,11,108),
(789,11,109),
(790,11,110),
(791,11,233),
(792,11,141),
(793,11,142),
(794,11,143),
(795,11,144),
(796,11,145),
(797,11,161),
(798,11,162),
(799,11,163),
(800,11,164),
(801,11,165),
(802,11,-666666),
(803,12,187),
(804,12,46),
(805,12,47),
(806,12,48),
(807,12,49),
(808,12,212),
(809,12,86),
(810,12,87),
(811,12,88),
(812,12,89),
(813,12,90),
(814,12,136),
(815,12,137),
(816,12,138),
(817,12,139),
(818,12,140),
(819,12,156),
(820,12,157),
(821,12,158),
(822,12,159),
(823,12,160),
(824,12,171),
(825,12,172),
(826,12,173),
(827,12,174),
(828,12,175),
(829,12,207),
(830,12,208),
(831,12,209),
(832,12,210),
(833,12,211),
(835,12,126),
(836,12,127),
(837,12,128),
(838,12,129),
(839,12,130),
(840,12,151),
(841,12,152),
(842,12,153),
(843,12,154),
(844,12,155),
(845,12,181),
(846,12,182),
(847,12,183),
(848,12,184),
(849,12,185),
(850,12,228),
(851,12,229),
(852,12,230),
(853,12,231),
(854,12,232),
(855,12,-666666),
(906,16,186),
(907,16,56),
(908,16,57),
(909,16,58),
(910,16,59),
(911,16,60),
(912,16,234),
(913,16,236),
(914,16,61),
(915,16,62),
(916,16,63),
(917,16,64),
(918,16,65),
(919,16,235),
(920,16,106),
(921,16,107),
(922,16,108),
(923,16,109),
(924,16,110),
(925,16,233),
(926,16,141),
(927,16,142),
(928,16,143),
(929,16,144),
(930,16,145),
(931,16,161),
(932,16,162),
(933,16,163),
(934,16,164),
(935,16,165),
(936,16,-666666),
(1179,9,186),
(1180,9,56),
(1181,9,57),
(1182,9,58),
(1183,9,59),
(1184,9,60),
(1185,9,234),
(1186,9,236),
(1187,9,61),
(1188,9,62),
(1189,9,63),
(1190,9,64),
(1191,9,65),
(1192,9,235),
(1193,9,106),
(1194,9,107),
(1195,9,108),
(1196,9,109),
(1197,9,110),
(1198,9,233),
(1199,9,141),
(1200,9,142),
(1201,9,143),
(1202,9,144),
(1203,9,145),
(1204,9,161),
(1205,9,162),
(1206,9,163),
(1207,9,164),
(1208,9,165),
(1209,9,46),
(1210,9,47),
(1211,9,48),
(1212,9,49),
(1213,9,212),
(1214,9,244),
(1215,9,86),
(1216,9,87),
(1217,9,88),
(1218,9,89),
(1219,9,90),
(1220,9,156),
(1221,9,157),
(1222,9,158),
(1223,9,159),
(1224,9,160),
(1225,9,207),
(1226,9,208),
(1227,9,209),
(1228,9,210),
(1229,9,211),
(1231,9,126),
(1232,9,127),
(1233,9,128),
(1234,9,129),
(1235,9,130),
(1236,9,245),
(1237,9,151),
(1238,9,152),
(1239,9,153),
(1240,9,154),
(1241,9,155),
(1242,9,181),
(1243,9,182),
(1244,9,183),
(1245,9,184),
(1246,9,185),
(1247,9,228),
(1248,9,229),
(1249,9,230),
(1250,9,231),
(1251,9,232),
(1252,9,246),
(1253,9,189),
(1254,9,3),
(1255,9,19),
(1256,9,20),
(1257,9,21),
(1258,9,22),
(1259,9,31),
(1260,9,32),
(1261,9,33),
(1262,9,34),
(1263,9,35),
(1264,9,247),
(1265,9,248),
(1266,9,36),
(1267,9,37),
(1268,9,38),
(1269,9,39),
(1270,9,40),
(1271,9,101),
(1272,9,102),
(1273,9,103),
(1274,9,104),
(1275,9,105),
(1276,9,195),
(1277,9,196),
(1278,9,197),
(1279,9,198),
(1280,9,199),
(1281,9,200),
(1282,9,201),
(1283,9,202),
(1284,9,203),
(1285,9,204),
(1286,9,-666666),
(1287,9,187),
(1506,1,186),
(1507,1,56),
(1508,1,57),
(1509,1,58),
(1510,1,59),
(1511,1,60),
(1512,1,234),
(1513,1,236),
(1514,1,61),
(1515,1,62),
(1516,1,63),
(1517,1,64),
(1518,1,65),
(1519,1,235),
(1520,1,106),
(1521,1,107),
(1522,1,108),
(1523,1,109),
(1524,1,110),
(1525,1,233),
(1526,1,141),
(1527,1,142),
(1528,1,143),
(1529,1,144),
(1530,1,145),
(1531,1,161),
(1532,1,162),
(1533,1,163),
(1534,1,164),
(1535,1,165),
(1536,1,46),
(1537,1,47),
(1538,1,48),
(1539,1,49),
(1540,1,212),
(1541,1,244),
(1542,1,86),
(1543,1,87),
(1544,1,88),
(1545,1,89),
(1546,1,90),
(1547,1,156),
(1548,1,157),
(1549,1,158),
(1550,1,159),
(1551,1,160),
(1552,1,207),
(1553,1,208),
(1554,1,209),
(1555,1,210),
(1556,1,211),
(1558,1,126),
(1559,1,127),
(1560,1,128),
(1561,1,129),
(1562,1,130),
(1563,1,245),
(1564,1,151),
(1565,1,152),
(1566,1,153),
(1567,1,154),
(1568,1,155),
(1569,1,181),
(1570,1,182),
(1571,1,183),
(1572,1,184),
(1573,1,185),
(1574,1,228),
(1575,1,229),
(1576,1,230),
(1577,1,231),
(1578,1,232),
(1579,1,246),
(1580,1,189),
(1581,1,3),
(1582,1,19),
(1583,1,20),
(1584,1,21),
(1585,1,22),
(1586,1,31),
(1587,1,32),
(1588,1,33),
(1589,1,34),
(1590,1,35),
(1591,1,247),
(1592,1,248),
(1593,1,36),
(1594,1,37),
(1595,1,38),
(1596,1,39),
(1597,1,40),
(1598,1,101),
(1599,1,102),
(1600,1,103),
(1601,1,104),
(1602,1,105),
(1603,1,195),
(1604,1,196),
(1605,1,197),
(1606,1,198),
(1607,1,199),
(1608,1,200),
(1609,1,201),
(1610,1,202),
(1611,1,203),
(1612,1,204),
(1613,1,-666666),
(1614,1,187),
(1999,10,1),
(2000,10,4),
(2001,10,23),
(2002,10,24),
(2003,10,25),
(2004,10,26),
(2005,10,5),
(2006,10,6),
(2007,10,7),
(2008,10,8),
(2009,10,9),
(2010,10,10),
(2011,10,11),
(2012,10,12),
(2013,10,13),
(2014,10,14),
(2015,10,27),
(2016,10,29),
(2017,10,30),
(2018,10,41),
(2019,10,42),
(2020,10,43),
(2021,10,44),
(2022,10,45),
(2023,10,249),
(2024,10,250),
(2025,10,251),
(2026,10,252),
(2027,10,253),
(2028,10,186),
(2029,10,56),
(2030,10,57),
(2031,10,58),
(2032,10,59),
(2033,10,60),
(2034,10,234),
(2035,10,236),
(2036,10,61),
(2037,10,62),
(2038,10,63),
(2039,10,64),
(2040,10,65),
(2041,10,235),
(2042,10,106),
(2043,10,107),
(2044,10,108),
(2045,10,109),
(2046,10,110),
(2047,10,233),
(2048,10,141),
(2049,10,142),
(2050,10,143),
(2051,10,144),
(2052,10,145),
(2053,10,161),
(2054,10,162),
(2055,10,163),
(2056,10,164),
(2057,10,165),
(2058,10,187),
(2059,10,36),
(2060,10,37),
(2061,10,38),
(2062,10,39),
(2063,10,40),
(2064,10,46),
(2065,10,47),
(2066,10,48),
(2067,10,49),
(2068,10,212),
(2069,10,244),
(2070,10,136),
(2071,10,137),
(2072,10,138),
(2073,10,139),
(2074,10,140),
(2075,10,156),
(2076,10,157),
(2077,10,158),
(2078,10,159),
(2079,10,160),
(2080,10,171),
(2081,10,172),
(2082,10,173),
(2083,10,174),
(2084,10,175),
(2085,10,207),
(2086,10,208),
(2087,10,209),
(2088,10,210),
(2089,10,211),
(2091,10,126),
(2092,10,127),
(2093,10,128),
(2094,10,129),
(2095,10,130),
(2096,10,245),
(2097,10,151),
(2098,10,152),
(2099,10,153),
(2100,10,154),
(2101,10,155),
(2102,10,181),
(2103,10,182),
(2104,10,183),
(2105,10,184),
(2106,10,185),
(2107,10,228),
(2108,10,229),
(2109,10,230),
(2110,10,231),
(2111,10,232),
(2112,10,246),
(2113,10,189),
(2114,10,3),
(2115,10,19),
(2116,10,20),
(2117,10,21),
(2118,10,22),
(2119,10,31),
(2120,10,32),
(2121,10,33),
(2122,10,34),
(2123,10,35),
(2124,10,247),
(2125,10,248),
(2126,10,86),
(2127,10,87),
(2128,10,88),
(2129,10,89),
(2130,10,90),
(2131,10,101),
(2132,10,102),
(2133,10,103),
(2134,10,104),
(2135,10,105),
(2136,10,195),
(2137,10,196),
(2138,10,197),
(2139,10,198),
(2140,10,199),
(2141,10,200),
(2142,10,201),
(2143,10,202),
(2144,10,203),
(2145,10,204),
(2146,10,205),
(2147,10,91),
(2148,10,92),
(2149,10,93),
(2150,10,94),
(2151,10,95),
(2152,10,96),
(2153,10,97),
(2154,10,98),
(2155,10,99),
(2156,10,100),
(2157,10,121),
(2158,10,122),
(2159,10,123),
(2160,10,124),
(2161,10,125),
(2162,10,206),
(2163,10,66),
(2164,10,67),
(2165,10,68),
(2166,10,69),
(2167,10,70),
(2168,10,76),
(2169,10,77),
(2170,10,78),
(2171,10,79),
(2172,10,80),
(2173,10,81),
(2174,10,82),
(2175,10,83),
(2176,10,84),
(2177,10,85),
(2178,10,111),
(2179,10,112),
(2180,10,113),
(2181,10,114),
(2182,10,115),
(2183,10,116),
(2184,10,117),
(2185,10,118),
(2186,10,119),
(2187,10,120),
(2188,10,242),
(2189,10,237),
(2190,10,238),
(2191,10,239),
(2192,10,240),
(2193,10,241),
(2194,10,243),
(2195,10,-666666),
(2196,17,57),
(2197,17,58),
(2198,17,59),
(2199,17,234),
(2200,17,108),
(2201,17,233),
(2202,17,-666666),
(2203,17,186),
(2204,17,56),
(2205,17,106),
(2206,20,142),
(2207,20,143),
(2208,20,144),
(2209,20,162),
(2210,20,163),
(2211,20,164),
(2212,20,47),
(2213,20,-666666),
(2214,20,186),
(2215,20,141),
(2216,20,161),
(2217,20,187),
(2218,20,46),
(2219,21,127),
(2220,21,128),
(2221,21,129),
(2222,21,152),
(2223,21,153),
(2224,21,154),
(2225,21,182),
(2226,21,183),
(2227,21,184),
(2228,21,-666666),
(2230,21,126),
(2231,21,151),
(2232,21,181),
(2821,28,186),
(2822,28,56),
(2823,28,57),
(2824,28,58),
(2825,28,59),
(2826,28,60),
(2827,28,234),
(2828,28,236),
(2829,28,61),
(2830,28,62),
(2831,28,63),
(2832,28,64),
(2833,28,65),
(2834,28,235),
(2835,28,106),
(2836,28,107),
(2837,28,108),
(2838,28,109),
(2839,28,110),
(2840,28,233),
(2841,28,141),
(2842,28,142),
(2843,28,143),
(2844,28,144),
(2845,28,145),
(2846,28,161),
(2847,28,162),
(2848,28,163),
(2849,28,164),
(2850,28,165),
(2851,28,187),
(2852,28,36),
(2853,28,37),
(2854,28,38),
(2855,28,39),
(2856,28,40),
(2857,28,46),
(2858,28,47),
(2859,28,48),
(2860,28,49),
(2861,28,212),
(2862,28,244),
(2863,28,136),
(2864,28,137),
(2865,28,138),
(2866,28,139),
(2867,28,140),
(2868,28,156),
(2869,28,157),
(2870,28,158),
(2871,28,159),
(2872,28,160),
(2873,28,171),
(2874,28,172),
(2875,28,173),
(2876,28,174),
(2877,28,175),
(2878,28,207),
(2879,28,208),
(2880,28,209),
(2881,28,210),
(2882,28,211),
(2884,28,126),
(2885,28,127),
(2886,28,128),
(2887,28,129),
(2888,28,130),
(2889,28,245),
(2890,28,151),
(2891,28,152),
(2892,28,153),
(2893,28,154),
(2894,28,155),
(2895,28,181),
(2896,28,182),
(2897,28,183),
(2898,28,184),
(2899,28,185),
(2900,28,228),
(2901,28,229),
(2902,28,230),
(2903,28,231),
(2904,28,232),
(2905,28,246),
(2906,28,189),
(2907,28,3),
(2908,28,19),
(2909,28,20),
(2910,28,21),
(2911,28,22),
(2912,28,31),
(2913,28,32),
(2914,28,33),
(2915,28,34),
(2916,28,35),
(2917,28,247),
(2918,28,248),
(2919,28,86),
(2920,28,87),
(2921,28,88),
(2922,28,89),
(2923,28,90),
(2924,28,101),
(2925,28,102),
(2926,28,103),
(2927,28,104),
(2928,28,105),
(2929,28,195),
(2930,28,196),
(2931,28,197),
(2932,28,198),
(2933,28,199),
(2934,28,200),
(2935,28,201),
(2936,28,202),
(2937,28,203),
(2938,28,204),
(2939,28,-666666),
(2980,27,186),
(2981,27,56),
(2982,27,57),
(2983,27,58),
(2984,27,59),
(2985,27,60),
(2986,27,234),
(2987,27,236),
(2988,27,61),
(2989,27,62),
(2990,27,63),
(2991,27,64),
(2992,27,65),
(2993,27,235),
(2994,27,106),
(2995,27,107),
(2996,27,108),
(2997,27,109),
(2998,27,110),
(2999,27,233),
(3000,27,141),
(3001,27,142),
(3002,27,143),
(3003,27,144),
(3004,27,145),
(3005,27,161),
(3006,27,162),
(3007,27,163),
(3008,27,164),
(3009,27,165),
(3010,27,157),
(3011,27,158),
(3012,27,87),
(3013,27,102),
(3014,27,-666666),
(3015,27,187),
(3016,27,156),
(3017,27,189),
(3018,27,86),
(3019,27,101),
(3020,31,228),
(3021,31,246),
(3022,31,229),
(3023,31,230),
(3024,31,231),
(3025,31,232),
(3026,31,236),
(3027,31,57),
(3028,31,58),
(3029,31,59),
(3030,31,60),
(3031,31,62),
(3032,31,63),
(3033,31,64),
(3034,31,65),
(3035,31,141),
(3036,31,142),
(3037,31,143),
(3038,31,144),
(3039,31,145),
(3040,31,161),
(3041,31,162),
(3042,31,163),
(3043,31,164),
(3044,31,165),
(3045,31,126),
(3046,31,245),
(3047,31,127),
(3048,31,128),
(3049,31,129),
(3050,31,130),
(3051,31,207),
(3052,31,208),
(3053,31,209),
(3054,31,210),
(3055,31,211),
(3056,31,46),
(3057,31,244),
(3058,31,47),
(3059,31,48),
(3060,31,49),
(3061,31,212),
(3062,31,36),
(3063,31,37),
(3064,31,38),
(3065,31,39),
(3066,31,40),
(3067,31,156),
(3068,31,157),
(3069,31,158),
(3070,31,159),
(3071,31,160),
(3072,31,-666666),
(3073,31,186),
(3074,31,56),
(3075,31,61),
(3076,31,187);

/*Table structure for table `sys_user` */

CREATE TABLE `sys_user` (
                            `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
                            `dept_id` bigint(20) DEFAULT NULL,
                            `username` varchar(50) NOT NULL COMMENT '用户名',
                            `password` varchar(100) DEFAULT NULL COMMENT '密码',
                            `salt` varchar(20) DEFAULT NULL COMMENT '盐',
                            `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
                            `job` varchar(100) DEFAULT NULL,
                            `entry` date DEFAULT NULL COMMENT '入职时间',
                            `if_on` tinyint(1) DEFAULT NULL,
                            `cp_id` bigint(20) DEFAULT NULL,
                            `if_main` tinyint(1) NOT NULL DEFAULT '0',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
                            `last_login_time` datetime DEFAULT NULL,
                            PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='系统用户';

/*Data for the table `sys_user` */

insert  into `sys_user`(`user_id`,`dept_id`,`username`,`password`,`salt`,`mobile`,`job`,`entry`,`if_on`,`cp_id`,`if_main`,`create_time`,`email`,`last_login_time`) values
(1,9,'admin','9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d','YzcmCZNvbXocrsz9dm8e','czczj','超管','2018-10-23',1,NULL,0,'2019-02-28 10:36:24',NULL,NULL),
(10,2,'张三','9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d','YzcmCZNvbXocrsz9dm8e','18988888888','CEO','2018-10-09',1,1,1,'2019-02-28 10:36:29','18988888888@163.com','2019-12-27 17:58:46'),
(24,10,'Mr.Yip','12e416902db93462bf888e3dc0792be42ecd8a54a6c8ca63ba68cdd35947da15','YzcmCZNvbXocrsz9dm8e','18042335123','ceo',NULL,1,2,1,'2019-05-05 13:40:03',NULL,NULL),
(31,22,'bcd7d','b5060a9a553ff972f7c3288f418232e86b5c0ae466be726f762fc6749e8aee5b','iM53Fzcn9pJZ0FFOMxdq',NULL,NULL,NULL,1,7,1,'2019-07-09 10:39:22','2651782252@qq.com','2019-07-09 11:10:56'),
(32,23,'c5fa7','e1e2680fa344c795022ff8e0f6683170e742b50f21677e6d82e238147e3ef85a','WmP4S0pMx7vCJJtqVtM4',NULL,NULL,NULL,1,8,1,'2019-07-09 11:12:51','2651782253@qq.com','2019-07-09 17:05:19'),
(33,2,'仲采白','25a3ef5e9229ba8cf2cb7e9862a61b3a58716fadd0c9f59bf6f53f230a237855','4zh4Jtl3FfYjY8HY4Gvm','18912322211','销售','2019-11-30',1,1,0,'2019-12-27 15:59:38','18912322211@163.com',NULL),
(34,2,'祁紫菱','218b4c2996dedcc68c3b86e59de089be892ba7ae57cc24410b9be7d1555d5d69','4TSBRTjXUWjGsuXHVcf0','18923211111','销售','2019-12-02',1,1,0,'2019-12-27 16:00:14','18923211111@163.com',NULL),
(35,2,'詹怡月','a9eec08920016d9f4536e9f6617a6c7f624533b9480322c0826599bc735c543b','Yp6Z1yPf31OB3ft5AsbO','18912322212','工人','2019-11-30',1,1,0,'2019-12-27 16:01:02','18912322212@163.com',NULL),
(36,2,'眭痴香','4bdeb7d5bc1b7d22245044f6fee47e7317cdea108a3d0a757abc08bb47db1e29','EynRsDigFXL6idk4OBzW','18912322255','销售','2019-11-30',1,1,0,'2019-12-27 16:01:51','18912322255@163.com',NULL),
(37,2,'牛景明','54a641f13ae1526ca717c310e7342fb2d3dd28cbc9f266a66f573868299862b6','H9eIScbrGqC86JQhzrVK','18922222222','技术','2019-11-30',1,1,0,'2019-12-27 16:03:29','18922222222@163.com',NULL),
(38,2,'呼玉树','db8b714c7fa9656ebf8d58568cbbc3bdcfc34124a1aa04798e6215228f514ca6','iQJMrAgyzvyIY3XT7aiR','18912355555','销售','2019-11-30',1,1,0,'2019-12-27 16:04:03','18912355555@163.com',NULL);

/*Table structure for table `sys_user_position` */

CREATE TABLE `sys_user_position` (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                     `user_id` bigint(20) NOT NULL,
                                     `position_id` bigint(20) NOT NULL,
                                     `cp_id` bigint(20) DEFAULT NULL,
                                     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_position` */

insert  into `sys_user_position`(`id`,`user_id`,`position_id`,`cp_id`) values
(36,20,1,NULL),
(37,20,3,NULL),
(51,17,3,NULL),
(52,21,1,NULL),
(55,22,1,NULL),
(64,30,6,NULL),
(66,29,8,NULL),
(67,33,1,NULL),
(68,34,1,NULL),
(69,35,1,NULL),
(71,36,1,NULL),
(72,37,1,NULL),
(73,38,1,NULL);

/*Table structure for table `sys_user_role` */

CREATE TABLE `sys_user_role` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
                                 `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values
(16,NULL,1),
(70,1,10),
(93,30,20),
(94,24,9),
(95,24,1),
(98,29,1),
(99,31,31),
(100,32,31),
(101,33,11),
(102,34,11),
(103,35,11),
(105,10,1),
(106,36,11),
(107,37,11),
(108,38,11);

/*Table structure for table `sys_user_token` */

CREATE TABLE `sys_user_token` (
                                  `user_id` bigint(20) NOT NULL,
                                  `token` varchar(100) NOT NULL COMMENT 'token',
                                  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
                                  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                  PRIMARY KEY (`user_id`),
                                  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户Token';

/*Data for the table `sys_user_token` */

insert  into `sys_user_token`(`user_id`,`token`,`expire_time`,`update_time`) values
(1,'8ac90427d5a66201fba7ac524c44b578','2019-12-28 05:55:55','2019-12-27 17:55:55'),
(10,'d0d6091469de1736869ae226a9ae3be0','2019-12-28 05:58:47','2019-12-27 17:58:47'),
(18,'6cfa56dbbeefe5cfd068531049f2eeec','2019-03-06 11:00:32','2019-03-05 23:00:32'),
(19,'3314bfcee73adb60d7397fa68f6c2fc7','2019-03-20 03:45:43','2019-03-19 15:45:43'),
(20,'ca2a06d2492579b74287ade532a4efb7','2019-03-08 02:40:30','2019-03-07 14:40:30'),
(24,'c5e05c7f6e5fddc77b9db2ed509de96a','2019-05-07 04:41:44','2019-05-06 16:41:44'),
(25,'84d1e66ab151d04774e4a5b7288a479e','2019-05-07 04:16:36','2019-05-06 16:16:36'),
(27,'7e5948b5e9172a7f1be368e9b4bebc88','2019-05-06 23:28:43','2019-05-06 11:28:43'),
(28,'ade2003344f6aea3046187170616d5b1','2019-05-07 04:27:41','2019-05-06 16:27:41'),
(29,'8aa1edf46931e33b4e36cfdf1fc3b5d9','2019-07-09 03:18:33','2019-07-08 15:18:33'),
(31,'353b50641bd1221ef90c8534af1e43d4','2019-07-09 23:10:57','2019-07-09 11:10:57'),
(32,'a7900754117a3d8bcaa313d880f7f456','2019-07-10 05:05:19','2019-07-09 17:05:19');

/*Table structure for table `sys_user_view` */

CREATE TABLE `sys_user_view` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `user_id` bigint(20) NOT NULL,
                                 `view_id` bigint(20) NOT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='个人视野';

/*Data for the table `sys_user_view` */

insert  into `sys_user_view`(`id`,`user_id`,`view_id`) values
(21,10,10);

/*Table structure for table `sys_version` */

CREATE TABLE `sys_version` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT,
                               `version` varchar(128) DEFAULT NULL COMMENT '版本号',
                               `update_time` date DEFAULT NULL COMMENT '更新时间',
                               `description` varchar(256) DEFAULT NULL COMMENT '更新描述',
                               `win32_href` varchar(128) DEFAULT NULL COMMENT 'win32更新包',
                               `win64_href` varchar(128) DEFAULT NULL COMMENT 'win64更新包',
                               `mac_href` varchar(128) DEFAULT NULL COMMENT 'mac更新包',
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sys_version` */

insert  into `sys_version`(`id`,`version`,`update_time`,`description`,`win32_href`,`win64_href`,`mac_href`) values
(1,'1.0.0','2019-07-08','第一个正式版本','https://ttn-package.oss-cn-hangzhou.aliyuncs.com/erp/decoration-client%20Setup%201.0.0.exe','https://ttn-package.oss-cn-hangzhou.aliyuncs.com/erp/decoration-client%20Setup%201.0.0.exe','https://ttn-package.oss-cn-hangzhou.aliyuncs.com/erp/decoration-client%20Setup%201.0.0.exe');

/*Table structure for table `tb_user` */

CREATE TABLE `tb_user` (
                           `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
                           `username` varchar(50) NOT NULL COMMENT '用户名',
                           `mobile` varchar(20) NOT NULL COMMENT '手机号',
                           `password` varchar(64) DEFAULT NULL COMMENT '密码',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           PRIMARY KEY (`user_id`),
                           UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户';

/*Data for the table `tb_user` */

insert  into `tb_user`(`user_id`,`username`,`mobile`,`password`,`create_time`) values
(1,'mark','13612345678','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','2017-03-23 22:37:41');

/*Table structure for table `tx_accept_templet` */

CREATE TABLE `tx_accept_templet` (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `accept_type` bigint(20) NOT NULL COMMENT '验收类别',
                                     `project_id` bigint(20) NOT NULL COMMENT '验收项目',
                                     `standard` varchar(300) NOT NULL COMMENT '标准',
                                     `if_must` tinyint(1) NOT NULL COMMENT '是否必检',
                                     `picture_json` text COMMENT '标准图片_json',
                                     `name` varchar(255) DEFAULT NULL COMMENT '模板名称',
                                     `cp_id` bigint(20) DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `FK_Reference_8tx` (`accept_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='验收模板';

/*Data for the table `tx_accept_templet` */

insert  into `tx_accept_templet`(`id`,`accept_type`,`project_id`,`standard`,`if_must`,`picture_json`,`name`,`cp_id`) values
(1,1,2,'完整对齐，无脱落',1,NULL,NULL,NULL);

/*Table structure for table `tx_accept_type` */

CREATE TABLE `tx_accept_type` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                  `name` varchar(50) NOT NULL COMMENT '名称',
                                  `if_on` tinyint(1) NOT NULL COMMENT '是否启用',
                                  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                                  `cp_id` bigint(20) DEFAULT NULL,
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='验收类别';

/*Data for the table `tx_accept_type` */

insert  into `tx_accept_type`(`id`,`name`,`if_on`,`remark`,`cp_id`) values
(1,'验收第一步',1,'第一步备注',NULL),
(2,'示例：瓷砖铺设',1,'验收类别，瓷砖铺设',1),
(3,'示例：水电铺设',1,NULL,1),
(4,'验收1',1,'111',6);

/*Table structure for table `tx_attendance` */

CREATE TABLE `tx_attendance` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                 `name` varchar(20) NOT NULL COMMENT '考勤点名称',
                                 `address` varchar(100) NOT NULL COMMENT '考勤点地址',
                                 `error_range` decimal(10,0) DEFAULT NULL COMMENT '误差范围',
                                 `start_time` varchar(10) DEFAULT NULL COMMENT '上班时间',
                                 `end_time` varchar(10) DEFAULT NULL COMMENT '下班时间',
                                 `applicable` varchar(1000) DEFAULT NULL COMMENT '适用部门',
                                 `estart_time` varchar(10) DEFAULT NULL COMMENT '最早打卡时',
                                 `eend_time` varchar(10) DEFAULT NULL COMMENT '最晚打卡时',
                                 `lgt` float DEFAULT NULL COMMENT '考勤点经度',
                                 `lat` float DEFAULT NULL COMMENT '考勤点维度',
                                 `cp_id` bigint(20) DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='考勤管理';

/*Data for the table `tx_attendance` */

insert  into `tx_attendance`(`id`,`name`,`address`,`error_range`,`start_time`,`end_time`,`applicable`,`estart_time`,`eend_time`,`lgt`,`lat`,`cp_id`) values
(1,'武进','湖塘武宜中路188号',300,'08:30','10:00',NULL,'01:00','02:00',119.948,31.7333,1),
(2,'公司','江苏省常州市武进区湖塘创研港3(510大道东50米)',100,'09:00','18:00',NULL,'00:30','23:30',119.975,31.6866,1);

/*Table structure for table `tx_brand` */

CREATE TABLE `tx_brand` (
                            `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                            `type_id` bigint(20) DEFAULT NULL,
                            `name` varchar(50) NOT NULL COMMENT '名称',
                            `picture_url` longtext COMMENT '图片_url',
                            `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                            `cp_id` bigint(20) DEFAULT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='品牌维护';

/*Data for the table `tx_brand` */

insert  into `tx_brand`(`id`,`type_id`,`name`,`picture_url`,`remark`,`cp_id`) values
(1,1,'ces','ces',NULL,1),
(2,1,'cc','cc','cc',1),
(3,1,'c','c','c',1),
(4,6,'ddd','dd','dd',1),
(5,10,'东鹏瓷砖','https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/d851273dd9c54c5ebad178c1b91e37f3.png','东鹏瓷砖',1),
(6,11,'窗帘品牌1',NULL,'11',1),
(7,11,'窗帘品牌2',NULL,'窗帘品牌2',1),
(8,NULL,'中铁',NULL,NULL,1),
(9,10,'卡琳娜','https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190302/80ff1389449a4afdb4ecba99545120c9.jpg',NULL,1),
(10,13,'施耐德',NULL,NULL,1),
(12,29,'c','https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190507/2b13a660c1a146c38604155405c9e56f.jpg','1',6);

/*Table structure for table `tx_client` */

CREATE TABLE `tx_client` (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `belong_id` bigint(20) DEFAULT NULL COMMENT '所属人',
                             `client_name` varchar(20) NOT NULL COMMENT '客户姓名',
                             `phone` varchar(20) NOT NULL COMMENT '客户电话',
                             `client_code` varchar(20) DEFAULT NULL COMMENT '客户编码',
                             `sex` varchar(5) DEFAULT NULL COMMENT '性别',
                             `address` varchar(200) DEFAULT NULL COMMENT '地址',
                             `bus_type` varchar(10) DEFAULT NULL COMMENT '业务类型',
                             `bus_phase` varchar(10) DEFAULT NULL COMMENT '阶段',
                             `room_type` varchar(10) DEFAULT NULL COMMENT '户型',
                             `house_type` varchar(10) DEFAULT NULL COMMENT '房型',
                             `create_man` varchar(20) DEFAULT NULL COMMENT '创建人',
                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                             `useful_area` decimal(10,0) DEFAULT NULL COMMENT '实用面积',
                             `status` varchar(10) DEFAULT NULL COMMENT '所处状态',
                             `buid_area` decimal(10,0) DEFAULT NULL COMMENT '建筑面积',
                             `receive_time` datetime DEFAULT NULL COMMENT '领取时间',
                             `source` varchar(10) DEFAULT NULL COMMENT '数据来源',
                             `open_see` varchar(10) DEFAULT NULL COMMENT '所属公海',
                             `client_type` varchar(10) DEFAULT NULL COMMENT '客户类型',
                             `escape` varchar(255) DEFAULT NULL COMMENT '逃单描述',
                             `hope_amount` decimal(10,0) DEFAULT NULL COMMENT '期望签单金额',
                             `hope_time` datetime DEFAULT NULL COMMENT '期望签单日期',
                             `contract_amount` decimal(10,0) DEFAULT NULL COMMENT '合同金额',
                             `paid_amount` decimal(10,0) DEFAULT NULL COMMENT '已收款',
                             `unfollwed_days` int(11) DEFAULT NULL COMMENT '未跟进天数',
                             `community` varchar(100) DEFAULT NULL COMMENT '小区',
                             `roof` varchar(20) DEFAULT NULL COMMENT '栋',
                             `unit` varchar(20) DEFAULT NULL COMMENT '单位',
                             `doorplate` varchar(20) DEFAULT NULL COMMENT '门牌',
                             `reserve_time` datetime DEFAULT NULL COMMENT '预约时间',
                             `receive_count` int(11) DEFAULT '0' COMMENT '领取次数',
                             `cp_id` bigint(20) DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='我的客户';

/*Data for the table `tx_client` */

insert  into `tx_client`(`id`,`belong_id`,`client_name`,`phone`,`client_code`,`sex`,`address`,`bus_type`,`bus_phase`,`room_type`,`house_type`,`create_man`,`create_time`,`useful_area`,`status`,`buid_area`,`receive_time`,`source`,`open_see`,`client_type`,`escape`,`hope_amount`,`hope_time`,`contract_amount`,`paid_amount`,`unfollwed_days`,`community`,`roof`,`unit`,`doorplate`,`reserve_time`,`receive_count`,`cp_id`) values
(2,1,'王五','18788889999','MY2221','2','中海凤凰熙岸','43','32','161','89',NULL,NULL,100,'1',200,'2019-01-28 17:33:54','49',NULL,'61','测试',20000,'2019-01-21 17:22:10',30000,30000,1,'1','1','2','1',NULL,3,1),
(3,1,'火舞','18222222222','MY99921','1','中吴大道1095','43','32','160','90','admin','2019-01-28 14:47:37',100,'1',118,'2019-01-28 14:47:04','48',NULL,'61',NULL,100,'2019-01-28 14:47:20',100000,50000,10,'1','1','1','1',NULL,1,1),
(4,1,'恐惧','18222201110',NULL,'1','ces','44','32','162','91','admin','2019-01-28 15:53:33',44,NULL,43,'2019-01-28 23:45:27','53',NULL,'60',NULL,444,'2019-01-28 16:07:36',NULL,NULL,NULL,'1','1','1','1',NULL,2,1),
(5,10,'王五','18922281192',NULL,'1','中吴大道1099','46','34','163','90','admin','2019-01-28 16:20:55',11,NULL,12,'2019-04-08 11:33:36','52',NULL,'58','观察对比',30000,'2019-01-28 16:20:51',NULL,NULL,NULL,'1','1','2','3',NULL,3,1),
(6,10,'赵六','1891112222','111','1','常州江宁街道111','42','30','159','89','换','2019-03-07 14:48:09',20,'1',30,'2019-03-07 14:47:13','53',NULL,'61','观察对比',10000,'2019-03-07 14:47:31',100000,0,2,'1','1','1','1',NULL,0,1),
(8,10,'张三','18922222222','001','1','北京市xxx区xxxx路','42','30','159','89','张三','2019-04-08 10:57:51',100,'1',100,'2019-04-08 10:57:23','53',NULL,'62','观察',100000,'2019-04-08 10:57:37',100000,10000,1,'1','11','11','11',NULL,0,1),
(9,10,'李四','18912322211111','002','1','北京市xxx区xxxx路','43','31','160','90','张三','2019-04-08 10:58:49',100,'1',100,'2019-04-08 10:58:27','52',NULL,'60','观察对比',100000,'2019-04-08 10:58:34',100000,100000,2,'1','11','22','22',NULL,0,1),
(10,10,'荣家欣','18933333333',NULL,'1','北京市海淀区花园北路49号','42','31','160','90','张三','2019-04-08 11:07:21',100,NULL,100,'2019-04-08 11:33:42','51',NULL,'63','观察对比',100,'2019-04-08 11:07:14',NULL,NULL,NULL,'1','1','1','1',NULL,3,1),
(11,10,'圭静柏','19022222222',NULL,'2','北京市海淀区花园北路49号','44','33','162','91','张三','2019-04-08 11:08:07',99,NULL,99,'2019-04-08 11:33:42','50',NULL,'61','观察对比',100,'2019-04-08 11:08:03',NULL,NULL,NULL,'1','1','1','1',NULL,3,1),
(12,10,'源海宁','18988888888',NULL,'2','北京市海淀区花园北路49号','45','35','163','90','张三','2019-04-08 11:09:00',110,NULL,120,'2019-04-08 11:33:42','53',NULL,'59','观察对比',100000,'2019-04-08 11:08:55',NULL,NULL,NULL,'1','2','2','2',NULL,3,1),
(13,10,'罗飞驰','18722222222',NULL,'1','北京市海淀区花园北路49号','46','33','162','89','张三','2019-04-08 11:10:12',200,NULL,200,'2019-04-08 11:33:42','50',NULL,'57','观察对比',200000,'2019-04-08 11:10:07',NULL,NULL,NULL,'1','1','1','1',NULL,3,1),
(14,10,'欧阳子民','18788888888',NULL,'1','北京市海淀区花园北路49号','43','32','161','90','张三','2019-04-08 11:12:08',100,NULL,100,'2019-04-08 11:33:42','52',NULL,'63','观察对比',100000,'2019-04-08 11:12:03',NULL,NULL,NULL,'3','1','1','1',NULL,3,1),
(15,10,'凤以柳','17677777777',NULL,'1','北京市海淀区花园北路49号','47','31','162','89','张三','2019-04-08 11:13:00',130,NULL,130,'2019-04-08 11:33:42','48',NULL,'57','观察对比',90000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,1),
(16,10,'眭昊焱','10900000000',NULL,'1','北京市海淀区花园北路49号','42','30','162','89','张三','2019-04-08 11:13:46',140,NULL,150,'2019-04-08 11:33:42','51',NULL,'59','观察对比',90000,'2019-04-08 11:13:41',NULL,NULL,NULL,'2','1','1','1',NULL,3,1),
(17,10,'苌芮优','18777777777',NULL,'1','北京市海淀区花园北路49号','44','31','159','89','张三','2019-04-08 11:14:37',90,NULL,99,'2019-04-08 11:33:42','49',NULL,'62',NULL,80000,'2019-04-08 11:14:32',NULL,NULL,NULL,'3','1','1','1',NULL,3,1),
(18,10,'伊睿哲','18877777777',NULL,'1','北京市海淀区花园北路49号','44','30','162','90','张三','2019-04-08 11:15:26',90,NULL,100,'2019-04-08 11:33:42','48',NULL,'57',NULL,90000,'2019-04-08 11:15:19',NULL,NULL,NULL,'3','2','2','2',NULL,3,1),
(19,10,'招谷芹','16666666666',NULL,'1','北京市海淀区花园北路49号','42','30','159','89','张三','2019-04-08 11:16:18',100,NULL,80,'2019-04-08 11:33:42','54',NULL,'59',NULL,80000,'2019-04-08 11:16:14',NULL,NULL,NULL,'3','3','3','3',NULL,3,1),
(20,24,'郑总','000000000000',NULL,'1','中央公园',NULL,NULL,NULL,NULL,'Mr.Yip','2019-05-06 17:17:58',NULL,'5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2),
(21,32,'1','1','1','1','1',NULL,NULL,NULL,NULL,'c5fa7','2019-07-09 11:41:43',NULL,'1',NULL,NULL,NULL,NULL,NULL,'123123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,8);

/*Table structure for table `tx_client_info` */

CREATE TABLE `tx_client_info` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                  `client_id` bigint(20) DEFAULT NULL COMMENT '客户id',
                                  `create_time` datetime NOT NULL COMMENT '时间',
                                  `client_action` varchar(20) NOT NULL COMMENT '动作',
                                  `content` varchar(50) DEFAULT NULL COMMENT '内容',
                                  `cp_id` bigint(20) DEFAULT NULL,
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户记录';

/*Data for the table `tx_client_info` */

/*Table structure for table `tx_client_pre` */

CREATE TABLE `tx_client_pre` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                 `client_id` bigint(20) DEFAULT NULL COMMENT '客户id',
                                 `client_name` varchar(50) DEFAULT NULL COMMENT '客户名称',
                                 `phone` varchar(50) DEFAULT NULL COMMENT '联系电话',
                                 `pre_time` datetime DEFAULT NULL COMMENT '预约时间',
                                 `status` varchar(10) NOT NULL COMMENT '状态',
                                 `deal_man` varchar(50) DEFAULT NULL COMMENT '处理人',
                                 `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                 `cp_id` bigint(20) DEFAULT NULL,
                                 `belong_id` bigint(20) DEFAULT NULL COMMENT '所属用户id',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预约客户';

/*Data for the table `tx_client_pre` */

/*Table structure for table `tx_community` */

CREATE TABLE `tx_community` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `region_code` varchar(10) NOT NULL COMMENT '小区行政编码',
                                `name` varchar(50) NOT NULL COMMENT '小区名称',
                                `lgt` float DEFAULT NULL COMMENT '经度',
                                `lat` float DEFAULT NULL COMMENT '维度',
                                `cp_id` bigint(20) DEFAULT NULL,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='小区维护';

/*Data for the table `tx_community` */

insert  into `tx_community`(`id`,`region_code`,`name`,`lgt`,`lat`,`cp_id`) values
(1,'320100','凤凰熙岸',119.997,31.7555,1),
(2,'320200','蔚蓝天地',116.328,39.9008,1),
(3,'310200','绿卡小镇',116.328,39.9008,1),
(4,'娄桥','中央公园',NULL,NULL,2);

/*Table structure for table `tx_complaint` */

CREATE TABLE `tx_complaint` (
                                `id` bigint(20) NOT NULL COMMENT 'id',
                                `client_id` bigint(20) NOT NULL COMMENT '投诉客户',
                                `complaint_type` varchar(10) NOT NULL COMMENT '投诉类型',
                                `complaint_desc` varchar(200) DEFAULT NULL COMMENT '投诉描述',
                                `complaint_pic` longtext COMMENT '投诉照片json',
                                `status` varchar(20) DEFAULT NULL COMMENT '受理状态',
                                `opinion` varchar(200) DEFAULT NULL COMMENT '受理意见',
                                `cp_id` bigint(20) DEFAULT NULL,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉管理';

/*Data for the table `tx_complaint` */

insert  into `tx_complaint`(`id`,`client_id`,`complaint_type`,`complaint_desc`,`complaint_pic`,`status`,`opinion`,`cp_id`) values
(1,3,'69','asfdasdfasdfa',NULL,'1','可以适当处理以下',1);

/*Table structure for table `tx_complaint_info` */

CREATE TABLE `tx_complaint_info` (
                                     `id` bigint(20) NOT NULL COMMENT 'id',
                                     `complaint_id` bigint(20) NOT NULL COMMENT '投诉主表id',
                                     `man_id` bigint(20) NOT NULL COMMENT '发言人',
                                     `action` varchar(50) DEFAULT NULL COMMENT '动作行为',
                                     `content` varchar(300) DEFAULT NULL COMMENT '内容',
                                     `create_time` datetime NOT NULL COMMENT '时间',
                                     `cp_id` bigint(20) DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `FK_Reference_10tx` (`complaint_id`),
                                     CONSTRAINT `FK_Reference_10tx` FOREIGN KEY (`complaint_id`) REFERENCES `tx_complaint` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉消息记录';

/*Data for the table `tx_complaint_info` */

/*Table structure for table `tx_construction_log` */

CREATE TABLE `tx_construction_log` (
                                       `id` bigint(20) NOT NULL COMMENT 'id',
                                       `create_time` datetime NOT NULL COMMENT '发生时间',
                                       `operate_man` bigint(20) NOT NULL COMMENT '操作人',
                                       `linked_client` bigint(20) NOT NULL COMMENT '关联客户',
                                       `status` int(11) NOT NULL COMMENT '施工状态',
                                       `description` varchar(200) DEFAULT NULL COMMENT '描述',
                                       `picture` longtext COMMENT '照片json',
                                       `action` varchar(20) NOT NULL COMMENT '动作',
                                       `cp_id` bigint(20) DEFAULT NULL,
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='施工日志';

/*Data for the table `tx_construction_log` */

/*Table structure for table `tx_material` */

CREATE TABLE `tx_material` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                               `type_id` bigint(20) NOT NULL COMMENT '分类id',
                               `name` varchar(50) NOT NULL COMMENT '名称',
                               `picture_json` longtext COMMENT '图片',
                               `brand` bigint(50) DEFAULT NULL COMMENT '品牌',
                               `model` varchar(100) DEFAULT NULL COMMENT '型号',
                               `room_area` bigint(10) DEFAULT NULL COMMENT '房间区域',
                               `origin` varchar(100) DEFAULT NULL COMMENT '产地',
                               `unit` varchar(32) DEFAULT NULL COMMENT '标准单位',
                               `price_purchase` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '采购价',
                               `price_salse` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售价',
                               `price_contract` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '承包价',
                               `super_code` varchar(20) DEFAULT NULL COMMENT '特项编码',
                               `other_code` varchar(20) DEFAULT NULL COMMENT '其他编码',
                               `purchase_unit` varchar(20) DEFAULT NULL COMMENT '采购转换单位',
                               `purchase_ceo` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '采购转换系数',
                               `salse_unit` varchar(20) DEFAULT NULL COMMENT '销售转换单位',
                               `salse_ceo` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售转换系数',
                               `if_on` tinyint(1) NOT NULL COMMENT '是否启用',
                               `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                               `cp_id` bigint(20) DEFAULT NULL,
                               PRIMARY KEY (`id`),
                               KEY `FK_Reference_7tx` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='材料列表';

/*Data for the table `tx_material` */

insert  into `tx_material`(`id`,`type_id`,`name`,`picture_json`,`brand`,`model`,`room_area`,`origin`,`unit`,`price_purchase`,`price_salse`,`price_contract`,`super_code`,`other_code`,`purchase_unit`,`purchase_ceo`,`salse_unit`,`salse_ceo`,`if_on`,`remark`,`cp_id`) values
(3,10,'地砖 800x800地板砖墙砖全抛釉瓷砖釉面砖臻皇玉帝皇 臻皇玉白色',NULL,5,'800x800',22,'中国大陆','片',69.00,100.00,80.00,'10024650893',NULL,NULL,0.00,NULL,0.00,1,'10024650893',1),
(4,10,'通体大理石瓷砖地砖800x800客厅地板砖磁砖',NULL,5,'800*800',18,'中国大陆','片',169.00,200.00,210.00,'28406256688',NULL,NULL,0.00,NULL,0.00,1,'每片可铺贴0.64㎡ 3片/箱 需整箱购买',1),
(7,12,'ces22121',NULL,NULL,'22',20,'2','122',1.00,1.00,2.00,'ces',NULL,NULL,0.00,NULL,0.00,1,'1',1),
(8,10,'仿古水磨石瓷砖600x600客厅餐厅地砖防滑800x800餐厅灰色地板砖',NULL,5,'800x800餐厅灰色地板砖',20,'其他','m2',100.00,120.00,120.00,'001',NULL,NULL,0.00,NULL,0.00,1,NULL,1),
(9,10,'瓷砖背景墙现代简约客厅3D电视背景墙装饰墙砖套餐',NULL,5,'ELEPHANT STATE/象邦',22,'中国','m2',100.00,120.00,130.00,'002',NULL,NULL,0.00,NULL,0.00,1,NULL,1),
(10,10,'真石大板通体砖客餐厅地砖菲拉格',NULL,5,'CS9020AS ',24,'广东','m2',100.00,120.00,120.00,'003',NULL,NULL,0.00,NULL,0.00,1,NULL,1),
(11,10,'青山白砖白色文化砖红砖仿古电视背景墙北欧外墙砖瓷砖客厅文化石',NULL,5,'605【平面】 607【平面】',23,'其他','m2',100.00,120.00,120.00,'004',NULL,NULL,0.00,NULL,0.00,1,NULL,1),
(12,10,'文化石电视背景墙室内墙砖仿古砖外墙砖外墙瓷砖文化砖',NULL,5,'TG 7009',22,'广东','m2',90.00,100.00,100.00,'TG 7009',NULL,NULL,0.00,NULL,0.00,1,NULL,1),
(13,24,'木料（国标）',NULL,NULL,'3*5',NULL,NULL,'米',1.00,1.00,1.00,NULL,NULL,NULL,0.00,NULL,0.00,1,NULL,2),
(14,24,'木料（非标）',NULL,NULL,'3*5',NULL,NULL,'米',1.00,1.00,1.00,NULL,NULL,NULL,0.00,NULL,0.00,1,NULL,2),
(16,29,'仿古砖800大小',NULL,12,'800x800',187,'广东','片',11.00,111.00,111.00,'33313131',NULL,NULL,0.00,NULL,0.00,1,'正常销售',6);

/*Table structure for table `tx_material_type` */

CREATE TABLE `tx_material_type` (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `parent_id` bigint(20) DEFAULT NULL COMMENT '上级分类',
                                    `type_name` varchar(20) NOT NULL COMMENT '分类名称',
                                    `type_code` varchar(10) DEFAULT NULL COMMENT '分类编码',
                                    `cp_id` bigint(20) DEFAULT NULL,
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='材料分类';

/*Data for the table `tx_material_type` */

insert  into `tx_material_type`(`id`,`parent_id`,`type_name`,`type_code`,`cp_id`) values
(10,NULL,'瓷砖','0101',1),
(11,NULL,'窗帘','02',1),
(13,NULL,'开关','03',1),
(14,NULL,'地板','05',1),
(15,NULL,'灯饰','02',1),
(16,NULL,'电器','22',1),
(17,NULL,'吊顶','00',1),
(18,NULL,'橱柜','09',1),
(19,NULL,'衣柜','88',1),
(24,25,'木工材料','ES-000001',2),
(25,NULL,'仓库','00000',2),
(26,25,'水电材料','ES-000002',2),
(27,25,'泥工材料','ES-000003',2),
(28,25,'油漆材料','ES-000004',2);

/*Table structure for table `tx_plan_templat` */

CREATE TABLE `tx_plan_templat` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                   `plan_type` bigint(20) NOT NULL COMMENT '计划类别',
                                   `project_id` bigint(20) NOT NULL COMMENT '项目',
                                   `offset_days` int(11) DEFAULT NULL COMMENT '偏移天数',
                                   `duration_days` int(11) DEFAULT NULL COMMENT '历时天数',
                                   `sort` int(11) DEFAULT NULL COMMENT '排序',
                                   `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                                   `cp_id` bigint(20) DEFAULT NULL,
                                   PRIMARY KEY (`id`),
                                   KEY `FK_Reference_9tx` (`plan_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='施工计划模板';

/*Data for the table `tx_plan_templat` */

insert  into `tx_plan_templat`(`id`,`plan_type`,`project_id`,`offset_days`,`duration_days`,`sort`,`remark`,`cp_id`) values
(1,1,1,1,1,1,'测试模板',1),
(2,2,12,1,1,1,'1',6);

/*Table structure for table `tx_plan_type` */

CREATE TABLE `tx_plan_type` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `name` varchar(50) NOT NULL COMMENT '名称',
                                `if_on` tinyint(1) NOT NULL COMMENT '启用',
                                `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                                `cp_id` bigint(20) DEFAULT NULL,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='施工计划类别';

/*Data for the table `tx_plan_type` */

insert  into `tx_plan_type`(`id`,`name`,`if_on`,`remark`,`cp_id`) values
(1,'默认模板',0,'默认模板不能删除',1),
(2,'1',1,'2',6);

/*Table structure for table `tx_predict_material` */

CREATE TABLE `tx_predict_material` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                       `material_id` bigint(20) NOT NULL,
                                       `room_id` bigint(20) NOT NULL,
                                       `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
                                       `cp_id` bigint(20) DEFAULT NULL,
                                       PRIMARY KEY (`id`),
                                       KEY `FK_Reference_18` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='空间主材预算';

/*Data for the table `tx_predict_material` */

insert  into `tx_predict_material`(`id`,`material_id`,`room_id`,`amount`,`cp_id`) values
(1,2,1,0.00,1),
(2,2,10,0.00,1),
(3,15,29,0.00,6),
(4,15,29,0.00,6),
(5,15,29,0.00,6),
(6,15,29,0.00,6),
(7,15,29,0.00,6),
(8,15,29,0.00,6),
(9,15,29,0.00,6),
(10,15,29,0.00,6),
(11,15,29,0.00,6),
(12,15,29,0.00,6),
(13,15,29,0.00,6),
(14,15,29,0.00,6),
(15,15,29,0.00,6),
(16,15,29,0.00,6),
(22,16,5,1.00,6),
(23,3,1,2.00,1),
(24,9,1,3.00,1);

/*Table structure for table `tx_predict_project` */

CREATE TABLE `tx_predict_project` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                      `room_id` bigint(20) NOT NULL,
                                      `project_id` bigint(20) DEFAULT NULL,
                                      `name` varchar(50) NOT NULL COMMENT '项目名称',
                                      `work_type` bigint(10) DEFAULT NULL COMMENT '工种',
                                      `unit` varchar(5) DEFAULT NULL COMMENT '单位',
                                      `cp_id` bigint(20) DEFAULT NULL,
                                      `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '报价数量',
                                      PRIMARY KEY (`id`),
                                      KEY `FK_Reference_17` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='空间工程预算';

/*Data for the table `tx_predict_project` */

insert  into `tx_predict_project`(`id`,`room_id`,`project_id`,`name`,`work_type`,`unit`,`cp_id`,`amount`) values
(1,1,1,'嵌入式',170,'m2',1,0.00),
(2,1,2,'木制踢脚线粘贴',170,'m',1,1.00),
(3,2,3,'瓷砖门槛石铺设',171,'m2',1,0.00),
(4,1,1,'嵌入式',170,'m2',1,0.00),
(16,5,12,'铺设电路',183,'m',6,100.00),
(17,5,14,'铺设踢脚线',185,'m',6,12.00),
(18,5,15,'铺色地砖',185,'㎡',6,14.00),
(21,5,17,'腻子涂抹',186,'m2',6,0.00),
(22,5,18,'彩色漆涂抹',186,'m2',6,0.00),
(23,5,19,'1',186,'1',6,0.00),
(24,5,20,'2',186,NULL,6,0.00),
(25,5,21,'3',186,NULL,6,0.00),
(26,5,22,'4',186,'4',6,0.00),
(27,5,23,'5',186,'5',6,0.00),
(28,5,24,'6',186,'66',6,0.00),
(29,5,25,'7',186,'777',6,0.00),
(30,5,26,'8',186,'88',6,0.00),
(31,6,12,'铺设电路',183,'m',6,0.00),
(33,1,8,'铺设地砖',171,'平方米',1,0.00),
(34,1,9,'铺设墙砖',171,'平方米',1,0.00),
(35,2,7,'铺设水管',170,'米',1,2.00);

/*Table structure for table `tx_predict_room` */

CREATE TABLE `tx_predict_room` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                   `template_id` bigint(20) NOT NULL,
                                   `name` varchar(256) DEFAULT NULL,
                                   `cp_id` bigint(20) DEFAULT NULL,
                                   PRIMARY KEY (`id`),
                                   KEY `FK_Reference_16` (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='模板空间';

/*Data for the table `tx_predict_room` */

insert  into `tx_predict_room`(`id`,`template_id`,`name`,`cp_id`) values
(1,1,'卧室',1),
(2,1,'厨房',1),
(3,1,'客厅',1),
(27,9,'客厅',6),
(28,10,'客厅',6),
(29,11,'客厅',8),
(30,12,'客厅',8),
(31,9,'客厅',NULL);

/*Table structure for table `tx_predict_template` */

CREATE TABLE `tx_predict_template` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                       `name` varchar(256) NOT NULL COMMENT '报价表名称',
                                       `template_type` bigint(20) NOT NULL COMMENT '报价表类型',
                                       `cp_id` bigint(20) DEFAULT NULL,
                                       `client_id` bigint(20) DEFAULT NULL COMMENT '客户id',
                                       `belong_id` bigint(20) DEFAULT NULL COMMENT '所属用户',
                                       `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='预算模板';

/*Data for the table `tx_predict_template` */

insert  into `tx_predict_template`(`id`,`name`,`template_type`,`cp_id`,`client_id`,`belong_id`,`create_time`) values
(1,'998套餐',180,1,NULL,NULL,NULL),
(2,'豪华套餐',181,1,NULL,NULL,NULL),
(9,'示例报价表模板',184,6,NULL,NULL,NULL),
(10,'[克隆副本]示例报价表模板',184,6,NULL,NULL,'2019-07-05 15:01:29'),
(11,'998套餐',191,8,NULL,NULL,NULL),
(12,'[克隆副本]998套餐',191,8,NULL,NULL,'2019-07-09 11:43:01');

/*Table structure for table `tx_presale` */

CREATE TABLE `tx_presale` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                              `name` varchar(50) NOT NULL COMMENT '阶段名称',
                              `status` int(11) NOT NULL COMMENT '阶段状态',
                              `percentage` decimal(10,0) DEFAULT NULL COMMENT '成单率',
                              `cp_id` bigint(20) DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='售前阶段';

/*Data for the table `tx_presale` */

insert  into `tx_presale`(`id`,`name`,`status`,`percentage`,`cp_id`) values
(1,'沟通',1,100,1);

/*Table structure for table `tx_project` */

CREATE TABLE `tx_project` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                              `type_id` bigint(20) NOT NULL COMMENT '分类id',
                              `name` varchar(50) NOT NULL COMMENT '项目名称',
                              `work_type` int(10) DEFAULT NULL COMMENT '工种',
                              `unit` varchar(5) DEFAULT NULL COMMENT '单位',
                              `total_price` decimal(10,2) NOT NULL COMMENT '综合价',
                              `super_code` varchar(10) DEFAULT NULL COMMENT '特项编码',
                              `total_cost` decimal(10,2) NOT NULL COMMENT '综合成本',
                              `human_cost` decimal(10,2) NOT NULL COMMENT '人工成本',
                              `help_cost` decimal(10,2) NOT NULL COMMENT '辅材成本',
                              `if_on` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
                              `if_editble` tinyint(1) DEFAULT NULL COMMENT '能否改价',
                              `cp_id` bigint(20) DEFAULT NULL,
                              `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`id`),
                              KEY `FK_Reference_6tx` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='工程列表';

/*Data for the table `tx_project` */

insert  into `tx_project`(`id`,`type_id`,`name`,`work_type`,`unit`,`total_price`,`super_code`,`total_cost`,`human_cost`,`help_cost`,`if_on`,`if_editble`,`cp_id`,`remark`) values
(2,1,'木制踢脚线粘贴',172,'m',100.00,'H22321',80.00,60.00,20.00,1,1,1,NULL),
(5,10,'ces',170,'1',22.00,'',22.00,22.00,11.00,1,1,1,NULL),
(6,12,'铺设电线',170,'米',10.00,'',10.00,100.00,20.00,1,1,1,NULL),
(7,12,'铺设水管',170,'米',10.00,'',10.00,200.00,10.00,1,1,1,NULL),
(8,13,'铺设地砖',171,'平方米',10.00,'',10.00,100.00,10.00,1,1,1,NULL),
(9,13,'铺设墙砖',171,'平方米',10.00,'',10.00,100.00,10.00,1,1,1,NULL),
(10,14,'打制衣柜',172,'平方米',10.00,'',10.00,100.00,10.00,1,1,1,NULL),
(11,14,'打制鞋柜',172,'平方米',10.00,'',10.00,100.00,10.00,1,1,1,NULL);

/*Table structure for table `tx_project_type` */

CREATE TABLE `tx_project_type` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                   `parent_id` bigint(20) DEFAULT NULL COMMENT '上级分类',
                                   `name` varchar(50) NOT NULL COMMENT '分类名称',
                                   `cp_id` bigint(20) DEFAULT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='工程分类';

/*Data for the table `tx_project_type` */

insert  into `tx_project_type`(`id`,`parent_id`,`name`,`cp_id`) values
(12,NULL,'水电工',1),
(13,NULL,'瓦工',1),
(14,NULL,'木工',1),
(17,NULL,'ASD',2),
(18,NULL,'DSDSA',2),
(24,NULL,'电工',6),
(25,NULL,'瓦工',6),
(26,NULL,'油漆工',6),
(27,NULL,'电工',8);

/*Table structure for table `tx_receipt` */

CREATE TABLE `tx_receipt` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                              `receipt_type` varchar(10) NOT NULL COMMENT '单据类型',
                              `name` varchar(50) NOT NULL COMMENT '单据名称',
                              `if_on` tinyint(1) NOT NULL COMMENT '是否启用',
                              `logistics` varchar(300) DEFAULT NULL COMMENT '物流信息',
                              `status` int(11) DEFAULT NULL COMMENT '标记状态',
                              `cp_id` bigint(20) DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='单据类型维护';

/*Data for the table `tx_receipt` */

insert  into `tx_receipt`(`id`,`receipt_type`,`name`,`if_on`,`logistics`,`status`,`cp_id`) values
(1,'1','测试',1,'单号22222',0,1);

/*Table structure for table `tx_repair` */

CREATE TABLE `tx_repair` (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `client_id` bigint(20) NOT NULL COMMENT '报修客户',
                             `repair_type` varchar(10) NOT NULL COMMENT '保修类型',
                             `repair_desc` varchar(200) DEFAULT NULL COMMENT '报修描述',
                             `repair_pic` longtext COMMENT '报修照片json',
                             `repair_man` varchar(20) DEFAULT NULL COMMENT '修理人',
                             `repair_phone` varchar(20) DEFAULT NULL COMMENT '修理人联系电话',
                             `distribute_desc` varchar(200) DEFAULT NULL COMMENT '分配描述',
                             `repair_source` varchar(10) DEFAULT NULL COMMENT '报修来源',
                             `amount` decimal(10,0) DEFAULT NULL COMMENT '核价',
                             `status` int(11) DEFAULT NULL COMMENT '状态',
                             `feedback_time` datetime DEFAULT NULL COMMENT '反馈时间',
                             `launch_time` datetime NOT NULL COMMENT '发起时间',
                             `cp_id` bigint(20) DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='报修管理';

/*Data for the table `tx_repair` */

insert  into `tx_repair`(`id`,`client_id`,`repair_type`,`repair_desc`,`repair_pic`,`repair_man`,`repair_phone`,`distribute_desc`,`repair_source`,`amount`,`status`,`feedback_time`,`launch_time`,`cp_id`) values
(1,3,'152',NULL,'[]','张三','18912322213','无',NULL,120,0,'2019-02-18 17:37:23','2019-02-18 17:37:25',1),
(2,4,'152','测试','[{\"status\":\"success\",\"name\":\"标准制修订.png\",\"size\":39812,\"percentage\":100,\"uid\":1550483271588,\"raw\":{\"uid\":1550483271588},\"url\":\"blob:http://localhost:8001/276473fd-ca61-45c2-a5f5-fc01243aff96\",\"response\":{\"msg\":\"success\",\"code\":0,\"url\":\"https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/4dbf6846412c4ab79c909dd4e2882eb7.png\"}},{\"name\":\"标准信息服务.png\",\"url\":\"https://ttn-decoration.oss-cn-beijing.aliyuncs.com/20190218/e014f759a5af4663b940eb84517dd967.png\",\"uid\":1550484225341,\"status\":\"success\"}]','测试','8','123',NULL,123,0,'2019-02-18 17:41:15','2019-02-18 17:41:17',1);

/*Table structure for table `tx_repair_info` */

CREATE TABLE `tx_repair_info` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                  `repair_id` bigint(20) NOT NULL COMMENT '报修主表',
                                  `man_id` bigint(20) NOT NULL COMMENT '发言人',
                                  `action` varchar(50) DEFAULT NULL COMMENT '动作行为',
                                  `content` varchar(200) DEFAULT NULL COMMENT '内容',
                                  `create_time` datetime NOT NULL COMMENT '时间',
                                  `cp_id` bigint(20) DEFAULT NULL,
                                  PRIMARY KEY (`id`),
                                  KEY `FK_Reference_11tx` (`repair_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报修管理消息记录';

/*Data for the table `tx_repair_info` */

/*Table structure for table `tx_serving_tech` */

CREATE TABLE `tx_serving_tech` (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                   `type_name` varchar(50) NOT NULL COMMENT '类别名称',
                                   `content` varchar(1024) NOT NULL COMMENT '内容',
                                   `name` varchar(20) NOT NULL COMMENT '名称',
                                   `cp_id` bigint(20) DEFAULT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='客户服务术语';

/*Data for the table `tx_serving_tech` */

insert  into `tx_serving_tech`(`id`,`type_name`,`content`,`name`,`cp_id`) values
(1,'问候语','啊手动阀发射点发','问候语1',NULL),
(2,'问候语','阿斯顿发生发射点发色发射点发生放手发动署方式','测试1',NULL),
(3,'问候语','啊手动阀发射点发','问候语1',7),
(4,'问候语','阿斯顿发生发射点发色发射点发生放手发动署方式','测试1',7),
(5,'问候语','啊手动阀发射点发','问候语1',8),
(6,'问候语','阿斯顿发生发射点发色发射点发生放手发动署方式','测试1',8),
(7,'问候语','啊手动阀发射点发','问候语1',1),
(8,'问候语','阿斯顿发生发射点发色发射点发生放手发动署方式','测试1',1);

/*Table structure for table `tx_store` */

CREATE TABLE `tx_store` (
                            `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                            `name` varchar(50) NOT NULL COMMENT '名称',
                            `address` varchar(100) DEFAULT NULL COMMENT '地址',
                            `emp_name` varchar(20) DEFAULT NULL COMMENT '管理员名字',
                            `phone` varchar(20) DEFAULT NULL COMMENT '电话',
                            `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                            `cp_id` bigint(20) DEFAULT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='仓库管理';

/*Data for the table `tx_store` */

insert  into `tx_store`(`id`,`name`,`address`,`emp_name`,`phone`,`remark`,`cp_id`) values
(1,'中心仓库1','中吴大道1095','陈xx','18288882928','作为主要的大仓库',1);

/*Table structure for table `tx_supplier` */

CREATE TABLE `tx_supplier` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                               `name` varchar(50) NOT NULL COMMENT '名称',
                               `address` varchar(200) DEFAULT NULL COMMENT '地址',
                               `man_name` varchar(20) DEFAULT NULL COMMENT '联系人',
                               `bank_account` varchar(50) DEFAULT NULL COMMENT '银行账户',
                               `bank_name` varchar(50) DEFAULT NULL COMMENT '银行',
                               `remark` varchar(300) DEFAULT NULL COMMENT '备注',
                               `phone` varchar(255) DEFAULT NULL COMMENT '联系人电话',
                               `cp_id` bigint(20) DEFAULT NULL,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='供应商管理';

/*Data for the table `tx_supplier` */

insert  into `tx_supplier`(`id`,`name`,`address`,`man_name`,`bank_account`,`bank_name`,`remark`,`phone`,`cp_id`) values
(1,'瓷砖供应商','中海','陈总','2312231231231231313123','招商','陈总是vip供应商','13123123',1);

/*Table structure for table `tx_target` */

CREATE TABLE `tx_target` (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `dept_id` bigint(20) NOT NULL COMMENT '部门',
                             `year` varchar(4) NOT NULL COMMENT '目标年份',
                             `contract1` decimal(10,2) DEFAULT NULL COMMENT '1月合同目标',
                             `contract2` decimal(10,2) DEFAULT NULL COMMENT '2月合同目标',
                             `contract3` decimal(10,2) DEFAULT NULL COMMENT '3月合同目标',
                             `contract4` decimal(10,2) DEFAULT NULL COMMENT '4月合同目标',
                             `contract5` decimal(10,2) DEFAULT NULL COMMENT '5月合同目标',
                             `contract6` decimal(10,2) DEFAULT NULL COMMENT '6月合同目标',
                             `contract7` decimal(10,2) DEFAULT NULL COMMENT '7月合同目标',
                             `contract8` decimal(10,2) DEFAULT NULL COMMENT '8月合同目标',
                             `contract9` decimal(10,2) DEFAULT NULL COMMENT '9月合同目标',
                             `contract10` decimal(10,2) DEFAULT NULL COMMENT '10月合同目标',
                             `contract11` decimal(10,2) DEFAULT NULL COMMENT '11月合同目标',
                             `contract12` decimal(10,2) DEFAULT NULL COMMENT '12月合同目标',
                             `goal1` decimal(10,2) DEFAULT NULL COMMENT '1月收款目标',
                             `goal2` decimal(10,2) DEFAULT NULL COMMENT '2月收款目标',
                             `goal3` decimal(10,2) DEFAULT NULL COMMENT '3月收款目标',
                             `goal4` decimal(10,2) DEFAULT NULL COMMENT '4月收款目标',
                             `goal5` decimal(10,2) DEFAULT NULL COMMENT '5月收款目标',
                             `goal6` decimal(10,2) DEFAULT NULL COMMENT '6月收款目标',
                             `goal7` decimal(10,2) DEFAULT NULL COMMENT '7月收款目标',
                             `goal8` decimal(10,2) DEFAULT NULL COMMENT '8月收款目标',
                             `goal9` decimal(10,2) DEFAULT NULL COMMENT '9月收款目标',
                             `goal10` decimal(10,2) DEFAULT NULL COMMENT '10月收款目标',
                             `goal11` decimal(10,2) DEFAULT NULL COMMENT '11月收款目标',
                             `goal12` decimal(10,2) DEFAULT NULL COMMENT '12月收款目标',
                             `cp_id` bigint(20) DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='业绩目标';

/*Data for the table `tx_target` */

insert  into `tx_target`(`id`,`dept_id`,`year`,`contract1`,`contract2`,`contract3`,`contract4`,`contract5`,`contract6`,`contract7`,`contract8`,`contract9`,`contract10`,`contract11`,`contract12`,`goal1`,`goal2`,`goal3`,`goal4`,`goal5`,`goal6`,`goal7`,`goal8`,`goal9`,`goal10`,`goal11`,`goal12`,`cp_id`) values
(1,2,'2018',120000.00,110000.00,120000.00,120000.00,120000.00,110000.00,110000.00,100000.00,90000.00,140000.00,160000.00,110000.00,222200.00,110000.00,130000.00,150000.00,160000.00,120000.00,110000.00,110000.00,130000.00,130000.00,130000.00,130000.00,1),
(2,5,'2018',110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,110000.00,1),
(7,6,'2019',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(8,5,'2020',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(9,2,'2018',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(10,5,'2018',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(11,8,'2019',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(12,6,'2018',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(13,5,'2018',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(14,3,'2018',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(15,9,'2018',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1),
(16,17,'2019',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,6),
(18,15,'2019',11.11,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,6),
(19,15,'2019',11.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,6),
(20,15,'2019',0.00,0.00,0.00,0.00,0.00,0.00,2.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,6),
(21,15,'2018',2.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,6),
(22,15,'2019',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,6);

/*Table structure for table `tx_task` */

CREATE TABLE `tx_task` (
                           `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                           `launch_man` varchar(255) NOT NULL COMMENT '发起人',
                           `content` text COMMENT '内容',
                           `status` int(11) DEFAULT NULL COMMENT '状态',
                           `importance` varchar(10) DEFAULT NULL COMMENT '重要性',
                           `principal` varchar(255) NOT NULL COMMENT '负责人',
                           `cp_id` bigint(20) DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='任务';

/*Data for the table `tx_task` */

insert  into `tx_task`(`id`,`launch_man`,`content`,`status`,`importance`,`principal`,`cp_id`) values
(1,'测试','测试省',0,'一般','测试',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
