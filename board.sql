DROP TABLE board.contents;
DROP TABLE board.users;
/*ALTER TABLE board.contents DROP INDEX IX_contents_no;*/

CREATE TABLE board.users(
	 seq_user_no INT NOT NULL AUTO_INCREMENT
	,user_id VARCHAR(20) UNIQUE NOT NULL
	,user_name VARCHAR(20)
	,user_password VARCHAR(20)
	
	,PRIMARY KEY (seq_user_no)
);

CREATE TABLE board.contents(
	 content_no INT NOT NULL AUTO_INCREMENT
	,content_title VARCHAR(50) NOT NULL
	,content_content VARCHAR(4000)
	,content_hit INT
	,content_regDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
	,content_user_no INT NOT NULL
	
	,PRIMARY KEY (content_no)
);


/*CREATE INDEX IX_contents_no ON board.contents(content_no);*/

ALTER TABLE board.contents
	ADD CONSTRAINT FK_content_user_no
	FOREIGN KEY (content_user_no)
	REFERENCES board.users(seq_user_no);

SELECT *
FROM board.users;

SELECT *
FROM board.contents;

/*EXPLAIN
SELECT * FROM board.`contents`;*/

INSERT INTO board.users
	set
		user_id = 'guest1'
		,user_name = '유저1'
		,user_password = '11';
		
INSERT INTO board.users
	set
		user_id = 'guest2'
		,user_name = '유저2'
		,user_password = '22';
		
INSERT INTO board.users
	set
		user_id = 'admin'
		,user_name = '관리자'
		,user_password = '123';		
		

INSERT INTO board.contents
	set
		content_title = '제목1'
		,content_content = '내용1'
		,content_hit = 1
		,content_user_no = 1;
		

INSERT INTO board.contents
	set
		content_title = '제목2'
		,content_content = '내용2'
		,content_hit = 1
		,content_user_no = 1;
		
INSERT INTO board.contents
	set
		content_title = '제목3'
		,content_content = '내용3'
		,content_hit = 1
		,content_user_no = 1;
		
INSERT INTO board.contents
	set
		content_title = '제목4'
		,content_content = '내용4'
		,content_hit = 1
		,content_user_no = 1;
		

SELECT *
FROM board.users;

SELECT *
FROM board.contents;

SELECT
	content_no
	,content_title
	,content_content
	,content_hit
	,date_Format(content_regDate, '%X-%c-%d') AS 'date'
	,content_user_no
FROM board.contents;

/*리스트*/
SELECT
	 ct.content_no
	,ct.content_title
	,ct.content_content
	,ct.content_hit
	,date_Format(content_regDate, '%X-%c-%d') AS 'date'
	,us.user_name
FROM
	board.contents ct
INNER JOIN
	board.users us
ON
	ct.content_user_no = us.seq_user_no
ORDER BY
	ct.content_no DESC;
	
	
/*검색*/
SELECT
	 ct.content_no
	,ct.content_title
	,ct.content_content
	,ct.content_hit
	,date_Format(content_regDate, '%X-%c-%d') AS 'date'
	,us.user_name
FROM
	board.contents ct
INNER JOIN
	board.users us
ON
	ct.content_user_no = us.seq_user_no
WHERE
	ct.content_content LIKE '%내용1%' OR ct.content_title LIKE '%제목1%' OR us.user_name LIKE '%심영%'
ORDER BY
	ct.content_no DESC;
	

/*조회수(hit)*/
UPDATE board.contents
SET content_hit = content_hit + 1
WHERE content_no = 2;


SELECT *
FROM board.contents;

SELECT *
FROM users;