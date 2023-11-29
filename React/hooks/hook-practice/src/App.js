import useAxios from "./useAxios";

function App() {
  const { loading, error, data, refetch } = useAxios({
    url: "https://yts-proxy.nomadcoders1.now.sh/list_movies.json?sort_by=rating",
  });
  return (
    <div className="App" style={{ height: "1000vh" }}>
      <h1>{data && data.status}</h1>
      <h2>{loading && "Loading..."}</h2>
      <button onClick={refetch}>Refetch</button>
    </div>
  );
}

export default App;
