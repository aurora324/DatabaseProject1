-- User 表
CREATE TABLE Users (
  mid VARCHAR(25) PRIMARY KEY,
  name VARCHAR(20) NOT NULL,--最长16
  sex VARCHAR(5),
  birthday DATE,
  level INT,
  sign TEXT,
  identity VARCHAR(10) NOT NULL,

  CONSTRAINT check_level_range CHECK (level >= 0 AND level <= 6)
);

CREATE TABLE Follow (
  follow_id SERIAL PRIMARY KEY,
  follower_mid VARCHAR(25) NOT NULL ,
  following_mid VARCHAR(25) NOT NULL,
  FOREIGN KEY (follower_mid) REFERENCES Users(mid),
  FOREIGN KEY (following_mid) REFERENCES Users(mid)
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

-- Like 表
CREATE TABLE Favorite (
  favorite_id SERIAL PRIMARY KEY,
  video_BV VARCHAR(20)NOT NULL ,
  user_mid VARCHAR(25) NOT NULL ,
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- Coin 表
CREATE TABLE Coin (
  coin_id SERIAL PRIMARY KEY,
  video_BV VARCHAR(20) NOT NULL ,
  user_mid VARCHAR(25) NOT NULL ,
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- Favorite 表
CREATE TABLE Favorite (
  favorite_id SERIAL PRIMARY KEY,
  video_BV VARCHAR(20) NOT NULL ,
  user_mid VARCHAR(25) NOT NULL ,
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- View 表
CREATE TABLE View (
  view_id SERIAL PRIMARY KEY,
  video_BV VARCHAR(20),
  user_mid VARCHAR(25),
  last_watch_time_duration INTEGER,
  FOREIGN KEY (video_BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);

-- Danmu 表
CREATE TABLE Danmu (
  danmu_id SERIAL PRIMARY KEY,
  BV VARCHAR(20),
  user_mid VARCHAR(25),
  time TIMESTAMP,
  content TEXT,
  FOREIGN KEY (BV) REFERENCES Video(BV),
  FOREIGN KEY (user_mid) REFERENCES Users(mid)
);
