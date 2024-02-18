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
	
-- 3.6 다른 조인을 방해하지 않고 쿼리에 조인 추가하기
-- CREATE TABLE emp_bonus(
-- empno INT(4),
-- received Date,
-- type int(1));
-- INSERT INTO emp_bonus
-- VALUES
-- (7369, STR_TO_DATE('14-3-2005', '%d-%m-%Y'), 1),
-- (7900, STR_TO_DATE('14-3-2005', '%d-%m-%Y'), 2),
-- (7788, STR_TO_DATE('14-3-2005', '%d-%m-%Y'), 3);

SELECT * FROM emp_bonus;

SELECT e.ename, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT e.ename, d.loc, eb.received
FROM emp e, dept d, emp_bonus eb
WHERE e.deptno = d.deptno AND e.empno = eb.empno;

-- 외부조인을 통해서 원래 쿼리의 데이터 손실 없이 추가 정보를 얻을 수 있다.
SELECT e.ename, d.loc, eb.received
FROM emp e JOIN dept d
	ON (e.deptno = d.deptno)
	LEFT JOIN emp_bonus eb
	ON (e.empno = eb.empno)
ORDER BY 2;

SELECT e.ename, d.loc,
	(SELECT eb.received FROM emp_bonus eb
	WHERE eb.empno = e.empno) AS received
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY 2;

-- SELECT * FROM emp_bonus eb, emp e
-- WHERE eb.empno = e.empno;

-- 두 테이블에 같은 데이턱 있는지 확인
-- DROP VIEW V;
CREATE VIEW V
AS
SELECT * FROM emp WHERE deptno != 10
UNION ALL
SELECT * FROM emp WHERE ename = 'WARD';

SELECT * FROM V;

SELECT
	*
FROM
	(
	SELECT
		e.empno,
		e.ename,
		e.job,
		e.mgr,
		e.hiredate,
		e.sal,
		e.comm,
		e.deptno,
		count(*) AS cnt
	FROM
		emp e
	GROUP BY
		empno,
		ename,
		job,
		mgr,
		hiredate,
		sal,
		comm,
		deptno
         ) e
WHERE
	NOT EXISTS (
	SELECT
		NULL
	FROM
		(
		SELECT
			v.empno,
			v.ename,
			v.job,
			v.mgr,
			v.hiredate,
			v.sal,
			v.comm,
			v.deptno,
			count(*) AS cnt
		FROM
			v
		GROUP BY
			empno,
			ename,
			job,
			mgr,
			hiredate,
			sal,
			comm,
			deptno
         ) v
	WHERE
		v.empno = e.empno
		AND v.ename = e.ename
		AND v.job = e.job
		AND COALESCE(v.mgr, 0) = COALESCE(e.mgr, 0)
			AND v.hiredate = e.hiredate
			AND v.sal = e.sal
			AND v.deptno = e.deptno
			AND v.cnt = e.cnt
			AND COALESCE(v.comm, 0) = COALESCE(e.comm, 0)
  )
UNION ALL
    SELECT
	*
FROM
	(
	SELECT
		v.empno,
		v.ename,
		v.job,
		v.mgr,
		v.hiredate,
		v.sal,
		v.comm,
		v.deptno,
		count(*) AS cnt
	FROM
		v
	GROUP BY
		empno,
		ename,
		job,
		mgr,
		hiredate,
		sal,
		comm,
		deptno
          ) v
WHERE
	NOT EXISTS (
	SELECT
		NULL
	FROM
		(
		SELECT
			e.empno,
			e.ename,
			e.job,
			e.mgr,
			e.hiredate,
			e.sal,
			e.comm,
			e.deptno,
			count(*) AS cnt
		FROM
			emp e
		GROUP BY
			empno,
			ename,
			job,
			mgr,
			hiredate,
			sal,
			comm,
			deptno
          ) e
	WHERE
		v.empno = e.empno
		AND v.ename = e.ename
		AND v.job = e.job
		AND COALESCE(v.mgr, 0) = COALESCE(e.mgr, 0)
			AND v.hiredate = e.hiredate
			AND v.sal = e.sal
			AND v.deptno = e.deptno
			AND v.cnt = e.cnt
			AND COALESCE(v.comm, 0) = COALESCE(e.comm, 0)
);

-- 테이블을 비교할 때 간단히 첫 번째 단계로, 데이터 비교에 카디널리티를 포함하는 대신, 오로지 카디널리티로만 비교할 수 있다.
SELECT count(*)
	FROM emp
	UNION
SELECT count(*)
	FROM dept;
