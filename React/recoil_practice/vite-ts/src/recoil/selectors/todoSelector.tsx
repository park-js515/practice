import { selector } from "recoil";
import { todoState } from "../atoms/todoState";

export const todoLengthState = selector({
  key: "todoLengthState",
  get: ({ get }) => {
    const todos = get(todoState);

    return todos.length;
  },
});
