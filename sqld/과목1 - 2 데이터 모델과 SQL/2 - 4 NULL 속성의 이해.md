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

> NULL의 특징

- NULL 값은 아직 정의되지 않은 값으로 0 또는 공백과 다르다. 0은 숫자이고, 공백은 하나의 문자이다.
- 테이블을 생성할 때 NOT NULL 또는 PRIMARY KEY로 정의되지 않은 모든 데이터 유형은 NULL 값을 포함할 수 있다.
- NULL 값을 포함한 연산의 경우 거의 모든 경우 NULL이다. (TRUE OR NULL = TRUE)
  - 모르는 데이터에 숫자를 더하거나 빼도 결과는 모르는 데이터인 것은 같다.
- 결과 값을 NULL이 아닌 다른 값을 얻고자 할 때, NVL/ISNULL 함수를 사용한다.
  - NULL 값의 대상이 숫자 유형 데이터인 경우는 주로 0(Zero)으로, 문자 유형 데이터인 경우 공백보다는 'x'와 같이 해당 시스템에서 의미 없는 문자로 바꾸는 경우가 많다.
