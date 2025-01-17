DROP DATABASE IF EXISTS e_life;
create database e_life;
use e_life;

/* ============================================================== */
/* Table: community                                                                                                                   */
/* ============================================================== */

CREATE TABLE community (
    `id` BIGINT AUTO_INCREMENT,
    `communityname` VARCHAR(50) NOT NULL,
    `communityinfo` VARCHAR(1024) NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `manager` VARCHAR(50) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `account` varchar(64) Not null,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/* ============================================================== */
/* Table: user                                                                                                                            */
/* ============================================================== */

CREATE TABLE user
(
    `username`  varchar(50) NOT NULL,
    `password` varchar(50) NOT NULL,
    `phone` varchar(20) NOT NULL,
    `email` varchar(50) NOT NULL,
    `role` smallint NOT NULL,
    `community_id` bigint,
    PRIMARY KEY(`username`),
    FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: merchant                                                                                                                   */
/*==============================================================*/

CREATE TABLE merchant
(
    `id`        bigint AUTO_INCREMENT,
    `username`  varchar(50) NOT NULL,
    `name`      varchar(100) NOT NULL,
    `phone`     varchar(20) NOT NULL,
    `address`   varchar(200) NOT NULL,
    `detail`    varchar(1024) NOT NULL,
    `type`      varchar(100) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: manager                                                                                                                   */
/*==============================================================*/

CREATE TABLE manager
(
    `username`  varchar(50) NOT NULL,
    `password` varchar(50) NOT NULL,
    `phone` varchar(20) NOT NULL,
    `email` varchar(50) NOT NULL,
    `role` smallint NOT NULL,
    `community_id` bigint,
    PRIMARY KEY(`username`),
    FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: friend                                                                                                                        */
/*==============================================================*/

CREATE TABLE friend
( 
  `id`       bigint AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `friend`   varchar(50) NOT NULL,
  `status` smallint not null,
  `content` varchar(200),
  PRIMARY KEY(`id`),
  FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`friend`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: urgent                                                                                                                       */
/*==============================================================*/

CREATE TABLE urgent
( 
 `id`          bigint AUTO_INCREMENT,
  `time`        timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `content`     varchar(1024) NOT NULL,
  `managername` varchar(50) NOT NULL,
  `status`      smallint NOT NULL,
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: urgentused                                                                                                                       */
/*==============================================================*/

CREATE TABLE urgentused
( 
 `id`          bigint AUTO_INCREMENT,
  `time`        timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `content`     varchar(1024) NOT NULL,
  `managername` varchar(50) NOT NULL,
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: news                                                                                                                         */
/*==============================================================*/

CREATE TABLE news
( 
  `id`          bigint AUTO_INCREMENT,
  `time`        timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `content`     varchar(1024) NOT NULL,
  `managername` varchar(50) NOT NULL,
	`title` varchar(20) NOT NULL,
   `status` SMALLINT,
	`photo` VARCHAR(500),
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: newsused                                                                                                                         */
/*==============================================================*/

CREATE TABLE newsused
( 
  `id`          bigint AUTO_INCREMENT,
  `time`        timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `content`     varchar(1024) NOT NULL,
  `managername` varchar(50) NOT NULL,
	`title` varchar(20) NOT NULL,
	`photo` VARCHAR(50),
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: activity                                                                                                                      */
/*==============================================================*/

CREATE TABLE activity
( 
  `id`          bigint AUTO_INCREMENT,
  `stime`       varchar(50) NOT NULL,
	`etime`        varchar(50) NOT NULL,
  `content`     varchar(1024) NOT NULL,
  `managername` varchar(50) NOT NULL,
  `title`       varchar(50) NOT NULL,
  `photo`       varchar(200),
  `status`      SMALLINT NOT NULL DEFAULT 0,
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: notice          物业通知                                                                                                              */
/*==============================================================*/

CREATE TABLE notice
(
    `id`          bigint AUTO_INCREMENT,
    `time`        varchar(20) NOT NULL,
    `content`     varchar(1024) NOT NULL,
    `managername` varchar(50) NOT NULL,
    `communityId` BIGINT,

    PRIMARY KEY(`id`),
     FOREIGN KEY (`managername`)
         REFERENCES manager (`username`)
         ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: noticeUser          物业通知关联的用户                                                                                                              */
/*==============================================================*/

CREATE TABLE noticeUser
(
    `id`          bigint NOT NULL,
    `username`    varchar(50) NOT NULL,

    `status`      smallint default 1,

     FOREIGN KEY (`username`)
         REFERENCES user (`username`)
         ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: pay                                                                                                                         */
/*==============================================================*/

CREATE TABLE pay
( 
  `id`          bigint AUTO_INCREMENT,
  `username`    varchar(20) NOT NULL,
  `bill`        DECIMAL(8,2),
  `status`      SMALLINT,
  `managername` varchar(50) NOT NULL,
  `community_id` bigint,
  `time` varchar(50) NOT NULL ,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: orders                                                                                                                         */
/*==============================================================*/

CREATE TABLE `orders` (
  `id` varchar(20) NOT NULL,
  `username` varchar(50) NOT NULL,
	`pid` BIGINT,
  `status` varchar(20) DEFAULT NULL COMMENT '订单状态\r\n            10：待付款\r\n            20：已付款',
  `bill` DECIMAL(8,2) DEFAULT NULL COMMENT '实际支付金额',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `paid_time` datetime DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`pid`)
        REFERENCES pay (`id`),
FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

/*==============================================================*/
/* Table: package                                                                                                                    */
/*==============================================================*/

CREATE TABLE package
( 
  `id`          bigint AUTO_INCREMENT,
  `time`        varchar(50) NOT NULL,
  `status`      smallint NOT NULL,
  `managername` varchar(50) NOT NULL,
  `username`    varchar(50) NOT NULL,
	`community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`managername`)
        REFERENCES manager (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: maintain                                                                                                                    */
/*==============================================================*/

CREATE TABLE maintain
( 
  `id`          bigint AUTO_INCREMENT,
  `time`        varchar(20) NOT NULL,
  `status`      smallint NOT NULL,
  `content`     varchar(1024) NOT NULL,
  `maintainname` varchar(100),
  `phone`    varchar(100),
  `managername` varchar(50),
  `username`    varchar(50) NOT NULL,
  `userphone`   varchar(100),
  PRIMARY KEY(`id`),
  FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: demand                                                                                                                    */
/*==============================================================*/

CREATE TABLE demand
( 
  `id`          bigint AUTO_INCREMENT,
  `title` varchar(100) Not NULL,
  `starttime`   varchar(20) NOT NULL,
  `endtime`   varchar(20) NOT NULL,
  `content`     varchar(1024) NOT NULL,
  `username`    varchar(50) NOT NULL,
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE participate
( 
  `id`          bigint AUTO_INCREMENT,
  `username`   varchar(50),
  `demand`    bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`demand`)
        REFERENCES demand (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


/*==============================================================*/
/* Table: discount                                                                                                                     */
/*==============================================================*/

CREATE TABLE discount
( 
  `id`          bigint AUTO_INCREMENT,
  `starttime`   varchar(20) NOT NULL,
  `endtime`     varchar(20) NOT NULL,
  `merchantid`  bigint NOT NULL,
  `number`      int NOT NULL,
  `photo`        varchar(200),
  `content`     varchar(1024) NOT NULL,
  `status`      smallint NOT NULL,
  `title`          varchar(200) NOT NULL,
  `community_id` bigint,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`merchantid`)
        REFERENCES merchant (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


/*==============================================================*/
/* Table: bargain                                                                                                                     */
/*==============================================================*/

CREATE TABLE bargain
( 
  `id`          bigint AUTO_INCREMENT,
  `starttime`   varchar(20) NOT NULL,
  `endtime`     varchar(20) NOT NULL,
  `title` varchar(100) Not NULL,
  `merchantid`  bigint NOT NULL,
  `goods`       varchar(1024) NOT NULL,
  `content`     varchar(1024) NOT NULL,
  `status`      smallint NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`merchantid`)
        REFERENCES merchant (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: participate                                                                                                                     */
/*==============================================================*/

CREATE TABLE Participator
( 
  `id`          bigint AUTO_INCREMENT,
  `aid`        bigint NOT NULL,
  `username` varchar(50) NOT NULL,
  `content`    VARCHAR(100),
	`status`     SMALLINT not null DEFAULT 0,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`aid`)
        REFERENCES activity (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/*==============================================================*/
/* Table: identify                                                                                                                     */
/*==============================================================*/

CREATE TABLE identify (
    `phone` VARCHAR(20) NOT NULL,
    `code` VARCHAR(10) NOT NULL,
    `time` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`phone`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE room
(
    `id`        bigint AUTO_INCREMENT,
    `username`  varchar(50) ,
		`type`      VARCHAR(1),
    `room`      varchar(6) NOT NULL,
    `parking`   varchar(4) NOT NULL DEFAULT 'A0B0',
    `pmoney`    DECIMAL(8,2),
    `mmoney`    DECIMAL(8,2),
     `community_id` bigint,
    PRIMARY KEY(`id`),
    FOREIGN KEY (`username`)
        REFERENCES user (`username`)
        ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE roomspace
(
    `id`        bigint AUTO_INCREMENT,
    `type`  varchar(1) NOT NULL,
`maxnum`      int NOT NULL,
`maxfloor`      int NOT NULL,
`maxroom`      int NOT NULL,    
`space`      int NOT NULL,
     `community_id` bigint,
PRIMARY KEY(`id`),
 FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE parkplan
(
    `id`        bigint AUTO_INCREMENT,
    `type`  varchar(1) NOT NULL,
    `monthpay`      DECIMAL(8,2) NOT NULL,
     `community_id` bigint,
PRIMARY KEY(`id`),
 FOREIGN KEY (`community_id`)
        REFERENCES community (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


/*=======================*/
/*change urgent STATUS*/
/*=======================*/
DROP PROCEDURE if EXISTS cStatus;
DELIMITER //
create PROCEDURE cStatus(in cid int)
begin
	DECLARE done INT DEFAULT 0;
	DECLARE id_temp int DEFAULT 0;
	DECLARE status_temp int DEFAULT 0;
	DECLARE temp CURSOR for select id,status from urgent where community_id=cid;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	OPEN temp;
	REPEAT
        FETCH temp INTO id_temp,status_temp;
        IF NOT done THEN
			IF status_temp=0 then
				update urgent set status =1 where id=id_temp;
			END IF;
		END if;
    UNTIL done END REPEAT;
    CLOSE temp;
end;
//
DELIMITER ;

/*=======================*/
/*move urgent table*/
/*=======================*/
DROP PROCEDURE if EXISTS moveurgent;
DELIMITER //
create PROCEDURE moveurgent(in nonused int)
begin
	DECLARE done INT DEFAULT 0;
	DECLARE id_temp int DEFAULT 0;
	DECLARE status_temp int DEFAULT 0;
	DECLARE time_temp timestamp;
	DECLARE content_temp VARCHAR(1024);
	DECLARE managername_temp VARCHAR(50);
	DECLARE cid_temp int DEFAULT 0;
	DECLARE temp CURSOR for select id,time,content,managername,status,community_id from urgent;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	OPEN temp;
	REPEAT
        FETCH temp INTO id_temp,time_temp,content_temp,managername_temp,status_temp,cid_temp;
        IF NOT done THEN
			IF status_temp=1 then
				INSERT into urgentused VALUES(id_temp,time_temp,content_temp,managername_temp,cid_temp);
				DELETE FROM urgent WHERE id = id_temp;
			END IF;
		END if;
    UNTIL done END REPEAT;
    CLOSE temp;
end;
//
DELIMITER ;

/*=======================*/
/*change news status*/
/*=======================*/
DROP PROCEDURE if EXISTS cnStatus;
DELIMITER //
create PROCEDURE cnStatus(in cid int)
begin
	DECLARE done INT DEFAULT 0;
	DECLARE id_temp int DEFAULT 0;
	DECLARE status_temp int DEFAULT 0;
	DECLARE num int DEFAULT 0;
	DECLARE temp CURSOR for select id,status from news where community_id=cid;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	SELECT COUNT(*)INTO num 
    FROM news
	WHERE `community_id` = cid AND `status` = 0;
	OPEN temp;
	REPEAT
        FETCH temp INTO id_temp,status_temp;
        IF NOT done THEN
			IF num = 5 then
				IF status_temp=0 then
					update news set status =1 where id=id_temp;
					set done=1;
				END IF;
			END if;
		END if;
    UNTIL done END REPEAT;
    CLOSE temp;
end;
//
DELIMITER ;

/*=======================*/
/*move news table*/
/*=======================*/
DROP PROCEDURE if EXISTS movenews;
DELIMITER //
create PROCEDURE movenews(in nonused int)
begin
	DECLARE done INT DEFAULT 0;
	DECLARE id_temp int DEFAULT 0;
	DECLARE status_temp int DEFAULT 0;
	DECLARE time_temp timestamp;
	DECLARE content_temp VARCHAR(1024);
	DECLARE title_temp VARCHAR(50);
	DEclare photo_temp varchar(100);
	DECLARE managername_temp VARCHAR(50);
	DECLARE cid_temp int DEFAULT 0;
	DECLARE temp CURSOR for select id,time,content,managername,title,status,photo,community_id from news;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
	OPEN temp;
	REPEAT
        FETCH temp INTO id_temp,time_temp,content_temp,managername_temp,title_temp,status_temp,photo_temp,cid_temp;
        IF NOT done THEN
			IF status_temp=1 then
				INSERT into newsused VALUES(id_temp,time_temp,content_temp,managername_temp,title_temp,photo_temp,cid_temp);
				DELETE FROM news 
				WHERE id = id_temp;
			END IF;
		END if;
    UNTIL done END REPEAT;
    CLOSE temp;
end;
//
DELIMITER ;
INSERT INTO e_life.community(id, communityname, communityinfo, address, manager, password, phone, email, account) VALUES
(1, '上海交通大学东区宿舍', '上海交通大学闵行校区东区宿舍?', 'lng:121.441731,lat:31.029642', 'manager', 'password', '15236936259', '123@qq.com', 'ahkaug8934@sandbox.com');
INSERT INTO e_life.manager(username, password, phone, email, role, community_id) VALUES
('admin', '123', '18621809689', '123456@qq.com', 1, 1),
('manager', 'password', '15236936259', '123@qq.com', 1, 1);
INSERT INTO e_life.user(username, password, phone, email, role, community_id) VALUES
('user', '123', '18621809689', '123456@qq.com', 0, 1)；