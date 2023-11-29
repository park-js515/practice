import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import Movie from "../components/Movie";

const Detail = () => {
  const { id } = useParams();
  const [loading, setLoading] = useState(true);
  const [info, setInfo] = useState({});

  const getMovie = async () => {
    const json = await (
      await fetch(`https://yts.mx/api/v2/movie_details.json?movie_id=${id}`)
    ).json();

    setInfo(json.data.movie);
		setLoading(false);
    console.log(info);
  };

  useEffect(() => {
		getMovie();
  }, []);

  return (
    <div>
      <h1>Detail</h1>
    </div>
  );
};

export default Detail;
