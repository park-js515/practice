### 1.

- useEffect 사용 시 바뀐 요소가 없을 때도 실행되는 것을 막고 싶다면, useMemo를 사용하는 것을 고려해라.
- 또는 객체가 아니라 객체 내 요소들을 변경사항으로 넣어라.
- <a href="https://velog.io/@jellyjw/React-useMemo%EC%99%80-useEffect-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0
  ">https://velog.io/@jellyjw/React-useMemo%EC%99%80-useEffect-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0
  </a>

### 2.
- cleanUp 함수가 존재하는 이유는 여러가지가 있지만, 즉각적인 행동의 취소도 있다.
  - API를 통해 데이터를 받다가 뒤로가기 버튼을 통해 해당 페이지를 나왔다면, 취소되어야 한다.
    - 이에 대해서 return을 통해서 취소를 시킬 수 있다.
    - 관련된 것으로 `AbortController`를 보자.
    - https://developer.mozilla.org/en-US/docs/Web/API/AbortController