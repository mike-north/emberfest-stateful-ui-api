defmodule Blog.PostView do
  use JaSerializer.PhoenixView
  import Ecto.Query, only: [from: 2]

  attributes [:title, :body, :author_name, :author_photo_url, :created_at, :updated_at, :featured_image_url, :category_name]

  has_many :comments,
    type: "comment",
    field: "comments"

  def title(post) do
    post["fields"]["title"]
  end
  
  def body(post) do
    post["fields"]["body"]
  end
  
  def author_name(%{"fields" => %{"author" => [%{"fields" => %{"name" => _name}}]}} = post) do
    hd(post["fields"]["author"])["fields"]["name"]
  end

  def created_at(post) do
    post["sys"]["createdAt"] <> "Z"
  end

  def updated_at(%{"sys" => %{"updatedAt" => updated_at}}) do
    updated_at <> "Z"
  end

  def author_photo_url(%{"fields" => %{"author" => [%{"fields" => %{"profilePhoto" => %{"fields" => %{"file" => %{"url" => url}}}}}]}} = post) do
    url
  end

  def featured_image_url(%{"fields" => %{"featuredImage" => %{"fields" => %{"file" => %{"url" => imageurl}}}}} = post) do
    imageurl
  end

  def featured_image_url(_) do
    nil
  end

  def category_name(%{"fields" => %{"category" => [%{"fields" => %{"title" => title}}]}} = post) do
    title
  end

  def category_name(_) do
    nil
  end

  def comments(post, _conn) do
    Blog.Repo.all(from c in Blog.Comment, where: c.post_id == ^post.id)
  end
end
