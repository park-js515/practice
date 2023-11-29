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