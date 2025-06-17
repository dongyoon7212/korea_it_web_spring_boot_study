-- DDL (데이터 정의어)
-- CREATE DATABASE	DB 생성
-- CREATE TABLE	테이블 생성
-- ALTER TABLE	테이블 수정 (컬럼 추가, 수정 등)
-- DROP TABLE	테이블 삭제

CREATE TABLE todo_tb (
    todo_id INT PRIMARY KEY AUTO_INCREMENT,
    todo_content VARCHAR(45) NOT NULL,
    create_dt DATETIME NOT NULL,
    update_dt DATETIME NOT NULL
);

-- primary => 기본키 즉 해당 테이블의 각 행에서 유일하게 식별하는 값

CREATE TABLE user_tb (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL,
    create_dt DATETIME NOT NULL,
    update_dt DATETIME NOT NULL
);

-- 칼럼 추가
ALTER TABLE todo_tb
ADD COLUMN user_id INT NOT NULL;

-- 제약조건 추가 (외래키)
ALTER TABLE todo_tb
ADD CONSTRAINT fk_todo_user -- 새 제약 조건(Constraint)을 추가. 이름은 fk_todo_user
FOREIGN KEY (user_id) -- 외래키로 지정할 컬럼은 user_id
REFERENCES user_tb(user_id); -- 이 컬럼은 반드시 user_tb의 user_id를 참조해야 함
-- todo_tb.user_id 값은 무조건 user_tb.user_id 중에 하나여야 함
-- user_tb에 없는 ID로는 todo_tb에 데이터를 넣을 수 없음 → 데이터 무결성 보장

-- FOREIGN KEY (FK) => 다른 테이블의 기본키를 참조하는 컬럼

-- user2_tb 임시로 만들고 DROP TABLE
DROP TABLE user2_tb;

-- DML (데이터 조작어)
-- INSERT INTO	데이터 추가
-- SELECT	데이터 조회
-- UPDATE	데이터 수정
-- DELETE	데이터 삭제

INSERT INTO
	user_tb (user_id, username, age, email, create_dt)
VALUES
	(0, "홍길동", 18, "gildong@gmail.com", now()),
    (0, "김길동", 32, "example@gmail.com", now()),
    (0, "김길수", 44, "eamil@naver.com", now());

INSERT INTO
	user_tb
VALUES
	(0, "신짱구", 5, "shin@naver.com", now(), null),
    (0, "신형만", 37, "shin2@gmail.com", now(), null);

INSERT INTO
	todo_tb (todo_content, create_dt, update_dt, user_id)
VALUES
	("운동하기", now(), null, 1),
    ("공부하기", now(), null, 1),
    ("은행가기", now(), null, 2);

-- 조회
SELECT
	todo_content,
    user_id
FROM
	todo_tb;

-- 조건 => WHERE
SELECT
	*
FROM
	user_tb
WHERE
	username LIKE '%동';
    
SELECT
	*
FROM
	todo_tb
ORDER BY
	create_dt ASC;
    
SELECT
	*
FROM
	todo_tb
WHERE
	user_id = 1
    AND todo_content LIKE "%하기";
    
SELECT
	*
FROM
	todo_tb
WHERE
	user_id = 1 OR user_id = 2;

-- join
SELECT
	t.todo_content,
    u.username,
    u.age
FROM
	todo_tb t
JOIN
	user_tb u ON t.user_id = u.user_id;
    
SELECT
	*
FROM
	user_tb u
INNER JOIN
	todo_tb t ON u.user_id = t.user_id;
    
UPDATE
	todo_tb
SET
	todo_content = "자바 공부하기", update_dt = now()
WHERE
	todo_id = 1;
    
INSERT INTO
	todo_tb
VALUES
	(0, "마트가기", now(), null, 4),
    (0, "코테공부하기", now(), null, 4),
    (0, "블로그쓰기", now(), null, 4);

-- 삭제하기
DELETE FROM
	todo_tb
WHERE
	todo_id = 4;
    
DELETE FROM
	user_tb
WHERE
	user_id = 4;
    
ALTER TABLE todo_tb
DROP FOREIGN KEY fk_todo_user;

ALTER TABLE todo_tb
ADD CONSTRAINT fk_todo_user
FOREIGN KEY (user_id)
REFERENCES user_tb(user_id)
ON DELETE CASCADE;

-- DCL (데이터 제어어) => 데이터베이스 접근 권한과 보안을 제어
-- GRANT 권한 부여
-- REVOKE 권한 회수

-- GRANT SELECT, INSERT ON todo.todo_tb TO 'root'@'localhost';
-- GRANT ALL PRIVILEGES ON todo.* TO 'user'@'localhost';
-- REVOKE INSERT ON todo.todo_tb FROM 'user'@'localhost';
SHOW GRANTS FOR 'root'@'localhost';

-- TCL (트랜젝션 제어어)
-- 트랜젝션(Transaction)?
-- "하나의 논리적인 작업 단위"
-- 여러 SQL 문장을 하나의 묶음으로 처리해서 모두 성공하거나, 모두 실패하게 만드는 제어 기술
-- A라는 계좌에서 B로 계좌이체 할때
-- A 1000 차감
-- B 1000 증가
-- 이 중 하나라도 실패하면 전체 작업을 되돌리야(ROLLBACK) 돈이 사라지거나 두 번 추가되지 않음
-- START TRANSACTION 트랜젝션 시작
-- COMMIT 지금까지의 변경 내용을 확정 저장 => 이후 롤백 불가능
-- ROLLBACK 현재 트랜젝션에서의 변경 내용을 취소 => 마지막 COMMIT 전까지
-- SAVEPOINT 중간 체크포인트 설정 => 이 시점으로 ROLLBACK 가능
-- ROLLBACK TO SAVEPOINT(이름) 지정된 체크포인트까찌 ROLLBACK

INSERT INTO
	account_tb
VALUES
	(0, 10000, 1),
    (0, 10000, 2);
    
START TRANSACTION;

UPDATE
	account_tb
SET
	balance = balance - 1000
WHERE
	user_id = 1;
    
SAVEPOINT sp1;

UPDATE
	account_tb
SET
	balance = balance + 1000
WHERE
	user_id = 2;

ROLLBACK TO sp1;

SET AUTOCOMMIT = 0;

TRUNCATE account_tb;

    
    
    
    

