# React 16.8v 부터는 Hook 을 조건문, 반복문, 중첩함수 내에서 호출할 수 없습니다.  
- 훅은 최상위에서만 선언되어야 한다.
- 오직 React 함수 내에서만 Hook을 호출해야 한다.  

### useClick

1. `useRef`

- 기본적으로 우리의 component의 어떤 부분을 선택할 수 있는 방법(ex. document.getElementByID)
- `.current`는 현재 원하는 DOM을 가리킨다.

```js
// App.js
import { useEffect, useState, useRef } from "react";

function App() {
  const potato = useRef();
  // setTimeout(() => potato.current?.focus(), 5000); // 옵셔널 체이닝: 마운트가 너무 빨리되면 에러가 생기기에

  useEffect(() => {
    setTimeout(() => {
      potato.current.focus();
    }, 5000);
  }); // 마운트가 끝난 후 포커스하기

  return (
    <div>
      <div>Hi</div>
      <input ref={potato} placeholder="la" />
    </div>
  );
}

export default App;
```

```js
// App.js

import { useEffect, useState, useRef } from "react";

const useClick = (onClick) => {
  const element = useRef();
  useEffect(() => {
    if (typeof onClick !== "function") {
      return; // 조건문이 훅 앞에 있으면 오류가 발생..
    }
    if (element.current) {
      // mount
      element.current.addEventListener("click", onClick);
    }
    return () => {
      if (element.current) {
        // componentWillUnmount
        element.current.removeEventListener("click", onClick);
      }
    };
  }, []);
  return typeof onClick !== "function" ? undefined : element;
};

function App() {
  const sayHello = () => console.log("say Hello");
  const title = useClick(sayHello);
  return (
    <div>
      <h1 ref={title}>Hi</h1>
    </div>
  );
}

export default App;
```

### useConfirm

```js
export const useConfirm = (message = "", callback, rejection) => {
  if (typeof callback !== "function" || typeof rejection !== "function") {
    return;
  }

  const confirmAction = () => {
    if (window.confirm(message)) {
      callback();
    } else {
      rejection();
    }
  };

  return confirmAction;
};
```

### usePreventLeave

```js
export const usePreventLeave = () => {
  const listener = (event) => {
    event.preventDefault();
    event.returnValue = "";
  };
  const enablePrevent = () => window.addEventListener("beforeunload", listener);
  const disablePrevent = () => window.removeEventListener("beforeunload", listener);

  return { enablePrevent, disablePrevent };
};
```


###
