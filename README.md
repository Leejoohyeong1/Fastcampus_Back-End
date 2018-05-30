# Fastcampus_Back-End

PS :) connectedDiary에서 사용한 백앤드 Table 입니다

DataBase Tables
```sql 
CREATE TABLE `DiaryList` (
  `No` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `Token` varchar(255) NOT NULL COMMENT '토큰',
  `authority` int(1) NOT NULL COMMENT '권한',
  `Contents` text DEFAULT NULL COMMENT '내용',
  `Date_created` date DEFAULT NULL,
  PRIMARY KEY (`No`),
  KEY `Token` (`Token`),
  CONSTRAINT `diarylist_ibfk_1` FOREIGN KEY (`Token`) REFERENCES `Userinfo` (`Login_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


CREATE TABLE `Groupinfo` (
  `No` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `mytoken` varchar(255) NOT NULL COMMENT '자신',
  `friendtoken` varchar(255) NOT NULL COMMENT '친구',
  `time` date DEFAULT NULL COMMENT '추가한 시가\n',
  PRIMARY KEY (`No`),
  UNIQUE KEY `mytoken` (`mytoken`,`friendtoken`),
  KEY `friendtoken` (`friendtoken`),
  CONSTRAINT `groupinfo_ibfk_1` FOREIGN KEY (`mytoken`) REFERENCES `Userinfo` (`Login_uid`),
  CONSTRAINT `groupinfo_ibfk_2` FOREIGN KEY (`friendtoken`) REFERENCES `Userinfo` (`Login_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


CREATE TABLE `Userinfo` (
  `Userindex` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `UserEmail` varchar(255) DEFAULT NULL COMMENT 'email',
  `UserPwd` varchar(255) DEFAULT NULL COMMENT '비밀번호',
  `Name` varchar(255) DEFAULT NULL COMMENT '유저이름',
  `PushToken` varchar(255) DEFAULT NULL COMMENT 'FCM_Token',
  `Login_uid` varchar(255) DEFAULT NULL COMMENT 'uid_Token',
  PRIMARY KEY (`Userindex`),
  UNIQUE KEY `PushToken` (`PushToken`),
  UNIQUE KEY `Login_uid` (`Login_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

```
