defmodule HelloWeb.PageView do
  use HelloWeb, :view

  def tweets(conn) do
    case conn.assigns[:tweets] do
      nil -> []
      tweets -> tweets
    end
  end

  def qiitas(conn) do
    case conn.assigns[:qiitas] do
      nil -> []
      qiitas -> qiitas
    end
  end
end
