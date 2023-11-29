import { useEffect } from "react";

export const useBeforeLeave = (onBefore) => {
  const handle = (event) => {
		const {clientY} = event; // 위치를 나타낸다.

		if (clientY <= 0) { // 위로 이동했을 때만 호출된다.
			onBefore();	
		}
	};

  useEffect(() => {
    if (typeof onBefore !== "function") {
      return;
    }

    document.addEventListener("mouseleave", handle);
    return () => document.removeEventListener("mouseleave", handle);
  }, []);
};
