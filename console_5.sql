-- User 表
CREATE TABLE Users (
  mid VARCHAR(25) PRIMARY KEY,
  name TEXT NOT NULL,--最长16
  sex VARCHAR(5),
  birthday VARCHAR(10),
  level INT,
  sign TEXT,
  identity VARCHAR(10) NOT NULL,

  CONSTRAINT check_level_range CHECK (level >= 0 AND level <= 6)
);

-- --无名的人导进去了
-- select mid,name from Users where mid='1968094';
-- --总 37881
-- select count(*) from Users;
-- --名字最长的人有24个字符：ScriptManager.clearTimer
-- SELECT * FROM users ORDER BY LENGTH(name) DESC LIMIT 1;

CREATE TABLE Follow (
  follow_id SERIAL PRIMARY KEY,
  follower_mid VARCHAR(25) NOT NULL,
  following_mid VARCHAR(25) NOT NULL,
  FOREIGN KEY (follower_mid) REFERENCES Users(mid),
  FOREIGN KEY (following_mid) REFERENCES Users(mid),
  UNIQUE(follower_mid, following_mid)
);
-- Video 表
CREATE TABLE Video (
  BV VARCHAR(20) PRIMARY KEY, --10
  title VARCHAR(100),--80
  owner_mid VARCHAR(25) NOT NULL,
  commit_time TIMESTAMP,
  review_time TIMESTAMP,
  public_time TIMESTAMP,
  duration INTEGER,
  description TEXT,
  reviewer_mid VARCHAR(25),
  FOREIGN KEY (owner_mid) REFERENCES Users(mid),
  FOREIGN KEY (reviewer_mid) REFERENCES Users(mid)
);

-- thumbs_up 表
CREATE TABLE thumbs_up (
  video_BV VARCHAR(20)NOT NULL ,
  user_mid VARCHAR(25) NOT NULL ,
  primary key (video_BV,user_mid),
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- Coin 表
CREATE TABLE Coin (
  video_BV VARCHAR(20) NOT NULL ,
  user_mid VARCHAR(25) NOT NULL ,
  primary key (video_BV,user_mid),
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- Favorite 表
CREATE TABLE Favorite (
  video_BV VARCHAR(20) NOT NULL ,
  user_mid VARCHAR(25) NOT NULL ,
  primary key (video_BV,user_mid),
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- View 表
CREATE TABLE View (
  video_BV VARCHAR(20),
  user_mid VARCHAR(25),
  last_watch_time_duration INTEGER,
  primary key (video_BV,user_mid),
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- Danmu 表
CREATE TABLE Danmu (
  danmu_id SERIAL PRIMARY KEY,
  BV VARCHAR(20),
  user_mid VARCHAR(25),
  time VARCHAR(10),
  content TEXT,
  FOREIGN KEY (BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);
-- insert into danmu (BV,user_mid,time,content) values ('BV11B4y1u7oY','1624790','455.918','我感觉自己的心理疾病80%是家人壁出来的');