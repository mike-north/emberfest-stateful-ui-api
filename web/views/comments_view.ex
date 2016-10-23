defmodule Blog.CommentView do
  use Blog.Web, :view
  use JaSerializer.PhoenixView
  
  
  attributes [:body, :inserted_at, :updated_at]
  
  has_one :post, field: :post_id, type: "post", include: false


end
