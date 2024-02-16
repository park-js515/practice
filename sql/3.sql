USE testdb;

-- 3.1 행 집합을 다른 행 위에 추가하기(UNION ALL: 중복 항목이 있으면 이를 포함한다.)
SELECT ename AS ename_and_dname, deptno
	FROM EMP
	WHERE deptno = 10
	UNION ALL 
SELECT '----------', NULL 
	FROM t1
	UNION ALL
SELECT dname, deptno
	FROM dept;
	
-- 숫자와 데이터 유형이 일치해야 UNION ALL을 수행할 수 있다.

-- UNION(중복 필터링)
SELECT deptno 
	FROM emp
	UNION
SELECT deptno
	FROM dept;
	
-- UNION ALL + DISTINCT
SELECT DISTINCT deptno
	FROM (
	SELECT deptno FROM emp UNION ALL 
	SELECT deptno FROM dept) x;

-- 3.2 연관된 여러 행 결합하기
SELECT e.ename, d.dname
	FROM emp e, dept d
WHERE e.deptno = d.deptno
	AND e.deptno = 10;

SELECT e.ename, d.loc,
	e.deptno AS emp_deptno,
	d.deptno AS dept_deptno
FROM emp e, dept d
WHERE e.deptno = 10;

SELECT e.ename, d.loc,
	e.deptno AS emp_deptno,
	d.deptno AS dept_deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno 
	AND e.deptno = 10;

SELECT e.ename, d.loc
	FROM emp e INNER JOIN dept d
	ON (e.deptno = d.deptno)
WHERE e.deptno = 10;

-- 3.3 두 테이블의 공통 행 찾기
-- DROP VIEW V;
CREATE VIEW V
AS
SELECT ename, job, sal
	FROM emp
WHERE job = 'CLERK';

SELECT * FROM V;

SELECT e.empno, e.ename, e.job, e.sal, e.deptno
FROM emp AS e, V
WHERE e.ename = V.ename 
AND e.job = V.job
AND e.sal = V.sal;

-- join으로
SELECT e.empno, e.ename, e.job, e.sal, e.deptno
FROM emp AS e INNER JOIN V
	ON (e.ename = V.ename AND e.job = V.job AND e.sal = V.sal);

-- 한 테이블에서 다른 테이블에 존재하지 않는 값 검색하기
SELECT deptno
	FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT deptno
	FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno FROM emp);

SELECT DISTINCT deptno
	FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

-- not in 을 사용할 때는 null을 유의하라.
CREATE TABLE new_dept (deptno integer);
INSERT INTO new_dept
VALUES 
(10),
(50),
(NULL);

-- 아무것도 반환되지 않음.
SELECT * FROM dept
WHERE deptno NOT IN (SELECT deptno FROM new_dept);

-- 출력
SELECT deptno
FROM dept
WHERE deptno IN (10, 50, null);

-- 출력
SELECT deptno
FROM dept
WHERE (deptno = 10 OR deptno = 50 OR deptno = NULL);

-- 미출력
SELECT deptno
FROM DEPT
WHERE deptno NOT IN (10, 50, NULL);
-- 미출력
SELECT deptno
FROM DEPT
WHERE NOT(deptno = 10 OR deptno= 50 OR deptno = NULL);

-- not exists 활용
SELECT d.deptno
FROM dept d
WHERE NOT EXISTS (
	SELECT 1
-- 	SELECT e.deptno
	FROM emp e
	WHERE d.deptno = e.deptno
);

SELECT d.deptno
FROM dept d
WHERE NOT EXISTS (
	SELECT 1
	-- 	SELECT e.deptno
	FROM new_dept nd
	WHERE d.deptno = nd.deptno
);

-- 3.5 다른 테이블 행과 일치하지 않는 행 검색하기
SELECT d.*
FROM dept d LEFT OUTER JOIN emp e
	ON (d.deptno = e.deptno)
WHERE e.deptno IS NULL;

SELECT e.ename, e.deptno AS emp_deptno, d.*
FROM dept d LEFT OUTER JOIN emp e
	ON (d.deptno = e.deptno);