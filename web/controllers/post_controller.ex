defmodule Blog.PostController do
  use Blog.Web, :controller

  defp normalize_data(%{"sys" => %{ "contentType" => %{ "sys" => %{"linkType" => "ContentType", "id" => "2wKn6yEnZewu2SCCkus4as"}}}} = data) do
    Map.merge(data, %{
      id: data["sys"]["id"]
    })
  end

  defp normalize_data(data) do
    %{
      id: "123"
    }
  end

  def index(conn, _params) do
    data = Contentful.Delivery.entries(
      Application.get_env(:blog, :contentful_space_id),
      Application.get_env(:blog, :contentful_access_token),
      %{"content_type" => "2wKn6yEnZewu2SCCkus4as"}
    )
    |> Enum.map(fn x ->
      normalize_data(x)
    end)

    conn
    |> render "index.json-api", data: data
    
  end

  def indexx(conn, _params) do
    
    conn
    |> json Contentful.Delivery.entries(
      Application.get_env(:blog, :contentful_space_id),
      Application.get_env(:blog, :contentful_access_token),
      %{"content_type" => "2wKn6yEnZewu2SCCkus4as"}
    )

  end
end
