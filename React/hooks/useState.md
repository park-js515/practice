### 1. 
- 아래와 같이 하면 안된다.

```js
const [number, setNumber] = useState(0);

const increase = () => {
  setNumber(number + 1);
}

const decrease = () => {
  setNumber(number - 1);
}
```

- 아래와 같이 사용하자

```js
const [number, setNumber] = useState(0);

const increase = () => {
  setNumber((number) => number + 1);
}

const decrease = () => {
  setNumber((number) => number - 1);
}
```

### 2.
- 개체에 존재하지 않는 속성을 가져오려고 한다면?
  - 에러 발생
- 옵셔널 체이닝 혹은 빈 배열, 객체를 사용해서 에러 방지  

### 3.
- 배열이나 객체를 업데이트할 때는 spread 연산자를 활용해서 새 배열 혹은 객체를 만들어 리턴해주어야 한다.  

```js
// 참고

let A = {
  age: 26,
  sex: "male",
};

let newA = { ...A, age: 25 }; // age가 바뀐다.

console.log(newA);
```

### 4.
- 업데이트하는 항목이 여러 개가 있다고, 이를 처리하는 여러 개의 함수를 만들지 말고, 새로운 속성 하나를 추가해서 해결해보자. -> 영상을 보자.  

### 5.  
- 업데이트된 배열이나 객체는 새로운 것이기에 사용에 있어 주의를 해야 한다.
  - 업데이트 된 것과 기존에 state 등에 있는 것은 다르기에 이를 처리하는 방법을 알아야 한다.
  - 인덱스나 새로운 속성을 사용하는 것이 바람직하다.