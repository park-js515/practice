USE testdb;

-- 모두 선택
SELECT * 
	FROM emp;
SELECT EMPNO, ENAME, JOB, SAL, MGR, HIREDATE, COMM, DEPTNO
	FROM emp;

-- 하위 집합 (where의 사용)
SELECT * FROM emp WHERE deptno = 10;

-- 여러 조건
SELECT * FROM emp WHERE deptno = 10
	OR comm IS NOT NULL
	OR sal <= 200 AND deptno = 20;
	
-- 괄호의 사용
SELECT * FROM emp WHERE (deptno = 10 OR comm IS NOT NULL OR sal <= 2000) AND deptno = 20;

SELECT ename, deptno, sal FROM emp;

-- as의 활용
SELECT sal AS salary, comm AS commision FROM emp;

-- 실패하는 경우
-- SELECT sal AS salary, comm AS commision FROM emp
-- 	WHERE salary < 5000;

SELECT * FROM (SELECT sal AS salary, comm AS commision FROM emp) temp -- x로 지정하든 상관없다.
	WHERE salary < 5000;
	
SELECT ename, job FROM emp WHERE deptno = 10;

-- CONCAT을 통해 연결한다.
SELECT CONCAT(ename, 'WORKS AS A', job) AS msg FROM emp 
	WHERE deptno = 10;
	
-- case 문
SELECT ename, sal,
	CASE WHEN sal <= 2000 THEN 'UNDEPAID'
		WHEN sal >= 4000 THEN 'OVERPAID'
		ELSE 'OK'
	END AS status
FROM emp;

-- 출력제한
SELECT * FROM emp LIMIT 5;

-- 무작위
SELECT ename, job FROM emp;
SELECT ename, job FROM emp ORDER BY rand() LIMIT 5;

-- null 값 찾기
SELECT * FROM emp WHERE comm IS NULL;

-- null 실젯값 변환
SELECT COALESCE(comm, 0) AS comm FROM emp;

SELECT CASE WHEN comm IS NULL THEN comm ELSE 0 END AS C FROM emp;

-- 패턴 찾기
SELECT ename, job FROM emp WHERE deptno IN (10, 20);

SELECT ename, job FROM emp WHERE deptno IN (10, 20)
	AND (ename LIKE '%I%' OR job LIKE '%ER');