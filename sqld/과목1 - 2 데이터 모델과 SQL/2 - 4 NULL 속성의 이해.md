> NULL의 기본개념

- https://yunamom.tistory.com/195
- NULL값의 연산은 언제나 NULL이다.
- 집계함수는 NULL 값을 제외하고 처리한다.
- NULL값으로 가능한 연산은 IS NULL, IS NOT NULL 밖에 없다.
- Oracle
  - `NVL(expr1, expr2)`
  - NULL expr1을 expr2로 대체한다.
- MySQL
  - `Coalesce(expr1, expr2)`
  - NULL expr1을 expr2로 대체한다.
