USE testdb;

-- 2.1 지정한 순서대로 쿼리 결과 반환
SELECT ENAME, JOB, SAL FROM	emp WHERE DEPTNO = 10 ORDER BY SAL ASC;

SELECT ENAME, JOB, SAL FROM	emp WHERE DEPTNO = 10 ORDER BY SAL DESC;

-- 이 방법도 가능하다.
SELECT ENAME, JOB, SAL FROM	emp WHERE DEPTNO = 10 ORDER BY 3 DESC;

-- 2.2 다중 필드로 정렬하기
SELECT EMPNO, DEPTNO, SAL, ENAME, JOB FROM emp ORDER BY DEPTNO, SAL DESC;

-- 2.3 부분 문자열로 정렬 (오류 있음. 적절히 이해할 것)
SELECT ENAME, JOB, SUBSTR(JOB, LENGTH(JOB) - 1) FROM emp ORDER BY SUBSTR(JOB, LENGTH(JOB) - 1);
SELECT ENAME, JOB, SUBSTR(JOB, 1, 2) FROM emp ORDER BY SUBSTR(JOB, 1, 2);

-- 2.4 혼합 영숫자 데이터 정렬하기, --mysql은 translate 지원X
CREATE VIEW V
AS
	SELECT CONCAT(ENAME, ' ', DEPTNO) AS DATA
	FROM EMP;
SELECT * FROM V;

-- 2.5 정렬할 때 NULL 처리하기
SELECT ename, sal, comm FROM emp ORDER BY 3;
SELECT ename, sal, comm FROM emp ORDER BY 3 DESC;

SELECT ename, sal, comm 
	FROM (
	SELECT ename, sal, comm,
	CASE WHEN comm IS NULL THEN 0 ELSE 1 END AS is_null FROM emp) x
	ORDER BY is_null DESC, comm;
	
SELECT ename, sal, comm 
	FROM (
	SELECT ename, sal, comm,
	CASE WHEN comm IS NULL THEN 0 ELSE 1 END AS is_null FROM emp) x
	ORDER BY is_null DESC, comm DESC;

SELECT ename, sal, comm 
	FROM (
	SELECT ename, sal, comm,
	CASE WHEN comm IS NULL THEN 0 ELSE 1 END AS is_null FROM emp) x
	ORDER BY is_null, comm;
	
SELECT ename, sal, comm 
	FROM (
	SELECT ename, sal, comm,
	CASE WHEN comm IS NULL THEN 0 ELSE 1 END AS is_null FROM emp) x
	ORDER BY is_null, comm desc;
	
-- 2.6 데이터 종속 키 기준으로 정렬하기
SELECT ename, sal, job, comm 
FROM emp 
ORDER BY 
	CASE WHEN job = 'SALESMAN' THEN comm ELSE sal END;

SELECT ename, sal, job, comm, 
CASE WHEN job = 'SALESMAN' THEN comm ELSE sal END AS ordered 
FROM emp ORDER BY 5;