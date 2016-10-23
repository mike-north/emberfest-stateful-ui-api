defmodule Blog.PostController do
  use Blog.Web, :controller

  defp normalize_data(%{"sys" => %{ "contentType" => %{ "sys" => %{"linkType" => "ContentType", "id" => "2wKn6yEnZewu2SCCkus4as"}}}} = data) do
    Map.merge(data, %{
      id: data["sys"]["id"]
    })
  end

  defp normalize_data(%{"sys" => %{"id" => id}} = data) do
    Map.merge(data, %{
      id: id
    })
  end

  defp normalize_data(data) do
    IO.inspect data["fields"]["sys"]
    %{
      id: "123"
    }
  end

  defp index_base(conn, args) do
    data = Contentful.Delivery.entries(
      Application.get_env(:blog, :contentful_space_id),
      Application.get_env(:blog, :contentful_access_token),
      Map.merge(%{"content_type" => "2wKn6yEnZewu2SCCkus4as"}, args))
    |> Enum.map(fn x ->
      normalize_data(x)
    end)

    conn
    |> render "index.json-api", data: data
    
  end
  
  def index(conn, %{"search" => search}) do
    conn
    |> index_base(%{
        "content_type" => "2wKn6yEnZewu2SCCkus4as",
        "fields.title[match]" => search})
  end

  def index(conn, params) do
    conn
    |> index_base(%{})
  end

  def show(conn, %{"id" => id}) do
    data = Contentful.Delivery.entry(
      Application.get_env(:blog, :contentful_space_id),
      Application.get_env(:blog, :contentful_access_token),
      id)
      |> normalize_data

    conn
    |> render "show.json-api", data: data
  end
end
