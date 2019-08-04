defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    IO.puts fetch_twitter()
    render(conn, "index.html")
  end

  # Twitter API
  def fetch_twitter() do
    #Httpoison使ってAPIをcall
    {status, res} = HTTPoison.get("https://ghibliapi.herokuapp.com/films")
    case status do
      :ok ->
        #戻り値のbody(json)を解析
        Poison.Parser.parse!(res.body)
          |> Enum.map(&(&1["title"]))
      :error -> :error
    end
  end

  # Qiita API

  # Google Custom Search
end
