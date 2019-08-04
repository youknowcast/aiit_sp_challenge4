defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    tweets = fetch_twitter()
    qiita_titles = fetch_qiita()
    render(conn, "index.html", 
            tweets: tweets, qiitas: qiita_titles)
  end

  # Twitter API
  def fetch_twitter() do
    #Httpoison使ってAPIをcall
    url = "https://api.twitter.com/1.1/search/tweets.json"
    bearer = Dotenv.get("TWITTER_API_BEARER_TOKEN")
    headers = [{"Authorization", "Bearer #{bearer}"}]
    params = [ q: "Elixir", count: 10]
    res = HTTPoison.get!(url, headers, params: params)
    case res.status_code do
      200 ->
        #戻り値のbody(json)を解析
        jq = Poison.Parser.parse!(res.body)
        jq["statuses"] |> Enum.map(&(&1["text"]))
      _ -> []
    end
  end

  # Qiita API
  def fetch_qiita() do
    url = "https://qiita.com/api/v2/items"
    params = [
      query: "title:Elixir OR title:elixir OR title:Phoenix OR title:Ecto",
      page: 1,
      per_page: 10
    ]
    res = HTTPoison.get!(url, [], params: params)
    case res.status_code do
      200 ->
        #戻り値のbody(json)を解析
        jq = Poison.Parser.parse!(res.body)
        jq |> Enum.map(&(&1["title"]))
      _ -> []
    end
  end
end
