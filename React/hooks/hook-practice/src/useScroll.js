import { useEffect, useState } from "react";

export const useScroll = () => {
	const [state, setState] = useState({
		x: 0,
		y: 0,
	})

	useEffect(() => {
		const onScroll = () => {
			// console.log("y: ", window.scrollY, "x: ", window.scrollX);
			setState({
				x: window.scrollX,
				y: window.scrollY
			})
		}

		window.addEventListener("scroll", onScroll);

		return () => {
			window.removeEventListener("scroll", onScroll);
		}
	}, [])
	return state;
}