-- 查询数据
SELECT * FROM students;
-- 查看表的详细情况
DESC students;
-- 创建表
CREATE TABLE students (
id INT,
student_name VARCHAR(20),
sex CHAR(1),
age INT,
achievement DOUBLE(5,2),
team_id INT,
graduation_date DATE,
-- 把team_id列 设为外键 参照外表teams的id列 当外键的值删除 本表中对应的列筛除 当外键的值改变 本表中对应的列值改变。
FOREIGN KEY(team_id) REFERENCES teams(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- 插入数据
INSERT INTO students VALUES (1,'xiaoming',0,7,100,1,'2022-7-1');
INSERT INTO students VALUES (2,'xiahai',1,8,98,1,'2011-8-1');
INSERT INTO students VALUES (3,'mimi',0,11,54,1,'2005-9-4');
INSERT INTO students VALUES (4,'mlddng',0,5,77,2,'2018-7-1');
INSERT INTO students VALUES (5,'lala',1,22,87,2,'2000-10-1');
INSERT INTO students VALUES (6,'qiqi',1,16,NULL,2,'2010-10-1');
INSERT INTO students VALUES (7,'mimi',0,11,70,3,'2005-9-4');
INSERT INTO students VALUES (8,'mimi',0,15,70,4,'2005-9-4');
INSERT INTO students VALUES (9,'xixi',0,15,70,NULL,'2005-9-4');
-- 删除数据
DELETE FROM students WHERE id=3;
-- 修改数据
UPDATE students SET NAME='小明',sex=1 WHERE id=3;
-- 修改表(添加字段)
ALTER TABLE students ADD achievement DOUBLE(5,2);
-- 修改表（修改字段名称）
ALTER TABLE students CHANGE NAME student_name VARCHAR(20);
-- 修改表（删除字段）
ALTER TABLE students DROP achievement;
-- 删除表
DROP TABLE students;


-- select 不操作数据库，只是查询。AS可以省略，用空格代替
SELECT age+18 AS '18年以后',student_name FROM students;

-- 按条件查询(<>是不等于)
SELECT student_name,age FROM students WHERE id=1;
SELECT student_name,age FROM students WHERE age>10;
SELECT student_name,age FROM students WHERE age>3 AND age<15;
SELECT student_name,age FROM students WHERE age BETWEEN 3 AND 15;
SELECT student_name,age FROM students WHERE age<>11;
SELECT student_name,age FROM students WHERE achievement IS NULL;
SELECT student_name,age FROM students WHERE age=11 OR age=22;
SELECT student_name,age FROM students WHERE age IN (7,11,16);
-- x%表示x开头的，%x表示x结尾的，%x%表示包含x的。在搜索中可以用这种
SELECT student_name,age FROM students WHERE student_name LIKE '%i' ;


-- 排序。默认升序，ASC升序，DESC降序。
SELECT student_name,achievement FROM students ORDER BY achievement;
SELECT student_name,achievement FROM students ORDER BY achievement ASC;
SELECT student_name,achievement FROM students ORDER BY achievement DESC;
SELECT student_name,achievement FROM students WHERE achievement>60 ORDER BY achievement DESC;
SELECT student_name,achievement,age FROM students ORDER BY age,achievement;

-- 常用函数
-- 查询后，LOWER为小写，UPPER为大写
SELECT student_name,LOWER(student_name) FROM students;
SELECT student_name,UPPER(student_name) '转换成大写' FROM students;
-- SUNSTR（5,2）截取第5位和第2位
SELECT student_name,SUBSTR(student_name,5,2) FROM students;
-- 查询student_name第四位是‘i’的
SELECT student_name FROM students WHERE SUBSTR(student_name,4,1) = 'i';
-- 查询后显示名字的长度
SELECT student_name, LENGTH(student_name) FROM students;
-- 如果为空就写为0
SELECT student_name,IFNULL(achievement,0) FROM students;	


-- 聚合函数
-- 计算总成绩
SELECT SUM(achievement) FROM students;
-- 求平均成绩
SELECT AVG(achievement) FROM students;
-- 求最大年龄
SELECT MAX(age) FROM students;
-- 求最小你年龄
SELECT MIN(age) FROM students;
-- 查询学生数量
SELECT COUNT(*) FROM students;
-- 有成绩的学员综合
SELECT COUNT(achievement) FROM students;
-- 查询有成绩的男同学
SELECT COUNT(achievement) FROM students WHERE sex=1;
-- 去除重复数据
SELECT DISTINCT student_name FROM students;
-- 统计去除重复后的总数
SELECT COUNT(DISTINCT student_name) FROM students;
-- 查询不同性别的人数
SELECT sex,COUNT(*) FROM students GROUP BY sex;
-- 按小组计算总成绩
SELECT team_id,SUM(achievement) FROM students GROUP BY team_id;
-- 总成绩大于100的小组,where是对数据条数的筛选，having是对分组的筛选
SELECT team_id,SUM(achievement) FROM students GROUP BY team_id HAVING SUM(achievement)<100;



-- limit关键字,控制显示条数
-- 找到前5个学生
SELECT * FROM students LIMIT 5;
-- 查询从第2个元素开始（取4个）
SELECT * FROM students LIMIT 1,4
-- 学员表中成绩前五的学生
SELECT * FROM students ORDER BY achievement DESC LIMIT 5;


-- 查询语句顺序
SELECT
	team_id,SUM(achievement)
FROM
	students
WHERE
	sex = 0
GROUP BY
	team_id
HAVING
	SUM(achievement)>30
ORDER BY
	SUM(achievement) DESC
LIMIT 2;


-- 约束
/* 	非空约束:保证字段的值不能为空。NOT NULL
	默认约束:保证字段即使字段不插入数据，也会有一个默认值。DEFAULT
	主键约束:保证数据不为空，且唯一PRIMARY KEY ；自动增加：ATUO_INCREMENT 
	外键约束:限制两个表的关系，一个表的外键必须为另一个表的主键，可以为空。
*/
CREATE TABLE teams(
	-- 主键约束 primary key 不能为空、不能重复。 auto_increment 自动增加
	id INT PRIMARY KEY AUTO_INCREMENT,
	/*NOT NULL 非空约束
	team_name varchar(20) not null*/
	-- DEFAULT 默认值 默认约束
	team_name VARCHAR(20) DEFAULT '无名队'
	
);

INSERT INTO teams (id,team_name) VALUE (1,'老虎队');
INSERT INTO teams (team_name) VALUE ('熊猫队');
SELECT * FROM teams;
SELECT * FROM students;
DELETE FROM teams WHERE id>2;
-- 重新设置AUTO_INCREMENT开始的值，不然在删除后，会接着之前的继续增加
ALTER TABLE teams AUTO_INCREMENT=3;
DROP TABLE teams;
DROP TABLE students;


-- 多对多关系

-- 创建学生表和教师表
CREATE TABLE teachers(
	id INT PRIMARY KEY AUTO_INCREMENT,
	teacher_name VARCHAR(20)
)
CREATE TABLE membes(
	id INT PRIMARY KEY AUTO_INCREMENT,
	membe_name VARCHAR(20)
)
SELECT * FROM teachers;
SELECT * FROM students;
SELECT * FROM teams;
SELECT * FROM teacher_to_student;

INSERT INTO teachers (teacher_name) VALUE ('李老师');

-- 创建关系表
CREATE TABLE teacher_to_student (
id INT PRIMARY KEY AUTO_INCREMENT,
teacher_id INT,
student_id INT,
FOREIGN KEY(teacher_id) REFERENCES teachers(id),
FOREIGN KEY(student_id) REFERENCES students(id)
);

INSERT INTO teacher_to_student (teacher_id,student_id) VALUE (2,5);


-- 多表查询
SELECT * FROM students,teams WHERE students.`team_id`=teams.`id`;
SELECT students.`student_name`,teams.`team_name` FROM students,teams WHERE students.`team_id`=teams.`id`;
-- 给表起别名(查询内容同上，简化写法，不推荐使用)
SELECT s.`student_name`,t.`team_name` FROM students s,teams t WHERE s.`team_id`=t.`id`;

-- 内连接：获取两个表交集的所有内容。inner join ,on是条件
SELECT s.`student_name`,t.`team_name`
	FROM students s 
	INNER JOIN teams t
	ON s.`team_id` = t.`id`
-- 左外连接：左表全部+右表对应内容。left join，on是条件
SELECT s.`student_name`,t.`team_name`
	FROM students s 
	LEFT JOIN teams t
	ON s.`team_id` = t.`id`
-- 右外连接：右表全部内容+左表部分内容。right join，on是条件
SELECT s.`student_name`,t.`team_name`
	FROM students s 
	RIGHT JOIN teams t
	ON s.`team_id` = t.`id`

-- 三个表关联
SELECT s.`student_name`,t.`teacher_name` FROM teacher_to_student ts
	INNER JOIN teachers t ON ts.`teacher_id` = t.`id`
	INNER JOIN students s ON ts.`student_id` = s.`id`;

-- 子查询
SELECT student_name,achievement FROM students WHERE achievement > (
SELECT AVG(achievement) FROM students
);



