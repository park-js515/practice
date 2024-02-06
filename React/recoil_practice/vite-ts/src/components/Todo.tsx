import { useRecoilState, useRecoilValue } from "recoil";
import { todoState } from "@src/recoil/atoms/todoState";
import { todoLengthState } from "@src/recoil/selectors/todoSelector";
import { useState } from "react";
import styles from "@src/styles/css/todo.module.css";

const Todo = () => {
  const [text, setText] = useState<string>("");
  const [todos, setTodos] = useRecoilState(todoState);
  const todoLength = useRecoilValue(todoLengthState);

  return (
    <div className={styles.component}>
      <form>
        <input
          className={styles.input}
          id="todoText"
          type="text"
          value={text}
          onChange={(event) => {
            setText(event.target.value);
          }}
        />
        <button
          className={styles.input_button}
          type="submit"
          onClick={(event) => {
            event.preventDefault();
            setTodos((current) => {
              return [...current, text];
            });
            setText("");
          }}
        >
          submit
        </button>
      </form>
      <div style={{ height: "30px" }}></div>
      <div>해야할 일의 수: {todoLength}</div>
      <hr />
      <ul>
        {todos.map((todo, index) => {
          return (
            <li key={todo} className={styles.li}>
              <span className={styles.todo}>{todo}</span>
              &nbsp; &nbsp;
              <button
                onClick={() => {
                  setTodos((current) => {
                    return current.filter((_, targetIndex) => {
                      return index !== targetIndex;
                    });
                  });
                }}
              >
                제거
              </button>
            </li>
          );
        })}
      </ul>
    </div>
  );
};

export default Todo;
