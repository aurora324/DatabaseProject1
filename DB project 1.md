# Database project 1
***
>12210360 黄奕凡
>12210723 王禀钦
## 第一部分：小组信息以及贡献

### 机器配置参考
* 。。。
* 。。。
### 编程语言
* Java
## 第二部分：E-R图
### 1. ER图
### 2. 关系模式
## 第三部分：数据库设计
### 1. 原始数据
*1.1 user.csv*
* `mid`：用户的唯一标识号。
* `name`：用户创建的名称。
* `sex`：包括但不限于生物性别。
* `birthday`：用户的生日。
* `level`：用户等级。
* `sign`：用户签名。
* `following`：包含该用户关注的所有其他用户的唯一标识号（mid）的列表。
* `identity`：取值为 {"user", "superuser"}，用户的角色。

*1.2 videos.csv*
* `BV`：视频的唯一标识字符串。
* `title`：视频名称。
* `owner mid`：up主的唯一标识号（mid）。
* `commit time`：视频上传时间。
* `review time`：视频审查时间。
* `public time`：视频公开时间。
* `duration`：视频时长。
* `description`：视频简介。
* `reviewer`：视频审查者的唯一标识号（mid）。
* `like`：喜欢此视频的用户唯一标识号（mid）的列表。
* `coin`：给视频投币的用户唯一标识号（mid）的列表。
* `favorite`：收藏此视频的用户唯一标识号（mid）的列表。
* `view`：观看此视频的用户及其上次观看的时长的列表。

*1.3 danmu.csv*
* `BV`：发送弹幕的视频的 BV。
* `mid`：发送弹幕的用户的 mid。
* `time`：弹幕出现在视频的时间。
* `content`：弹幕的内容。
  
### 2. 设计数据库
#### 2.1 原始分析
我们从原始数据中获得的关键信息如下：
* 每个user只有一个mid与之对应
* sex的填写包括“男”“女”“未知”
  
原本的表格中存在的问题：
1. user.csv中每个`user`的`following`里面有多个`mid`，相当于这个属性可拆分，违反了第一范式每个列具有原子性，不可再分的原则。
2. user.csv中`following`是由多个`mid`编号组成的列表，依赖于`user`的主键`mid`，但由于`following`也在表`user`之中，所有就造成了属性中的部分数据需要通过本表主键找到，违反了第二范式。
3. 如果一个`user`关注了更多的用户，其对应的`following`应该有所增加，但原表中的list不易于扩展新的`mid`，也增加了出错的概率。
   
上述三个问题同样适用于属性`like`、`coin`、`favorite`、`view`

根据上述关键信息以及问题分析，为了让数据库表格遵循数据库三范式要求，并且具有更好的可拓展性，我们对表格进行如下设计。

#### 2.2 表格结构介绍

**User 表:**
* `mid` (主键，NOT NULL)
* `name` (NOT NULL)
* `sex` (varchar(5), “男”“女”“未知”)
* `birthday` (DATE)
* `level` (INT, NOT NULL)
* `sign` (TEXT)
* `identity` (VARCHAR, 'user' or 'superuser')
  
**Follow 表:**
* `follow_id` (主键)
* `follower_mid` (外键，引用 User 表的 mid，表示关注者)
* `following_mid` (外键，引用 User 表的 mid，表示被关注者)

UNIQUE(`follower_mid`, `following_mid`)

**Video 表:**
* `BV` (主键)
* `title` (NOT NULL)
* `owner_mid` (外键，引用 User 表的 mid, NOT NULL)
* `commit_time` (TIMESTAMP, NOT NULL)
* `review_time` (TIMESTAMP, NOT NULL)
* `public_time` (NOT NULL)
* `duration` 
* `description`
* `reviewer_mid` (外键，引用 User 表的 mid)
  
**Like 表:**
* `like_id` (主键)
* `video_BV` (外键，引用 Video 表的 BV)
* `user_mid` (外键，引用 User 表的 mid)
  
**Coin 表:**
* `coin_id` (主键)
* `video_BV` (外键，引用 Video 表的 BV)
* `user_mid` (外键，引用 User 表的 mid)

**Favorite 表:**
* `favorite_id` (主键)
* `video_BV` (外键，引用 Video 表的 BV)
* `user_mid` (外键，引用 User 表的 mid)

**View 表:**
* `view_id` (主键)
* `video_BV` (外键，引用 Video 表的 BV)
* `user_mid` (外键，引用 User 表的 mid)
* `last_watch_time_duration`

**Danmu 表:**
* `danmu_id` (主键)
* `BV` (外键，引用 Video 表的 BV)
* `user_mid` (外键，引用 User 表的 mid)
* `time`
* `content`

#### 2.3 数据库图
由`DataGrip`生成的结构图如下：

(pic)

我们的表设计满足以下的设计需求:
* 满足三大范式
* 每个表都有主键
* 每个表都有外键/有表的外键指向
* 没有成环
* 每个表都有`NOTNULL`列
* 对数据使用了正确的类型
* 容易扩展

#### 2.4 可拓展性
我们设计的表具有较强的可拓展性：
1. 当新的用户注册时，只需插入一条新数据在`user`里。
2. 当新的视频发布时，只需插入一条新数据在`video`里。
3. 当`user`关注了新的用户时，只需在`follow`表格插入新的`follower_mid`（关注者）与`following_mid`（被关注者）即可。
4. 当`video`被新的`user`点赞时，只需在`like`表格插入新的`video_BV`与`user_mid`即可。
5. 当`video`被新的`user`投币时，只需在`coin`表格插入新的`video_BV`与`user_mid`即可。
6. 当`video`被新的`user`收藏时，只需在`favorite`表格插入新的`video_BV`与`user_mid`即可。
7. 当`video`被新的`user`观看时，只需在`view`表格插入新的`video_BV`，`user_mid`与`last_watch_time_duration`即可。
8. 当有user在video里发弹幕时，只需在`danmu`表格插入新的`BV`, `user_mid`, `time`和`content`即可。

## 第四部分：数据导入
### 1. 原始数据导入
编写Java文件实现数据导入
代码见 ^^^.java
#### 1.1 步骤
#### 1.2 前提条件和注意事项
#### 1.3 每个表中的数据量
### 2. 数据整合与建表
#### 2.1 建表
详见 DDL.sql
#### 2.2 通过数据库语言整合表
部分表使用导入数据库的原始数据，通过执行 SQL 命令筛选出来，再通过 DataGrip 直接导入
#### 2.3 通过Python处理导入
### 3. 导入性能测试
#### 3.1 Java 脚本不同数据量单线程导入数据库性能
#### 3.2 Java脚本不同线程jdbc，DBCP，HikariCP性能对比
#### 3.3 Python脚本导入数据库
#### 3.4 命令行运行脚本多线程导入测试
#### 3.5 与其他数据库（Mysql）导入数据对比

### 4. 确认所有数据导入完毕

## 第五部分：比较 DBMS 与文件 I/O




待办事项:
1. 在上面每个属性后面填写数据类型、和外键情况
2. 各种属性的数据大小，存在的多种情况
3. 原表中违反范式等。。的点，设计完表中为什么符合
4. 导入数据如何分开list内的内容