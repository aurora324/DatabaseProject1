CREATE TABLE user (
  mid SERIAL PRIMARY KEY,--unique
  name VARCHAR(30) NOT NULL, --<=16
  sex VARCHAR(2),
  birthday DATE,
  level INTEGER,
  sign TEXT,
  identity VARCHAR(10)--user or superuser
);

CREATE TABLE video (
  BV VARCHAR(20) PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  owner_mid INTEGER REFERENCES "user"(mid), --foreign key
  commit_time TIMESTAMP,
  review_time TIMESTAMP,
  public_time TIMESTAMP,
  duration INTERVAL,
  description TEXT,
  reviewer_mid INTEGER REFERENCES "user"(mid),--foreign key
  likes INTEGER[],
  coins INTEGER[],
  favorites INTEGER[],
  views JSONB
);

CREATE TABLE danmu (
  BV VARCHAR(20) REFERENCES video(BV),--foreign key
  mid INTEGER REFERENCES "user"(mid),--foreign key
  time TIMESTAMP,
  content TEXT
);
