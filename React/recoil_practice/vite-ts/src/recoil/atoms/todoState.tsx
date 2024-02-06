import { atom } from "recoil";
import { recoilPersist } from "recoil-persist";

const { persistAtom } = recoilPersist({
  key: "recoil-persist",
  storage: localStorage,
});

export const todoState = atom<string[]>({
  key: "todoState",
  default: [],
  effects_UNSTABLE: [persistAtom],
});
