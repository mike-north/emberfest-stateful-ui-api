defmodule Blog.CommentView do
  use Blog.Web, :view
  use JaSerializer.PhoenixView
  
  
  attributes [:body, :created_at, :updated_at]
  
  has_one :post, field: :post_id, type: "post", include: false

  def created_at(comment, _conn) do
    Ecto.DateTime.to_iso8601(comment.inserted_at) <> "Z"
  end

  def updated_at(comment, _conn) do
    Ecto.DateTime.to_iso8601(comment.updated_at) <> "Z"
  end

end
