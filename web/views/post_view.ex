defmodule Blog.PostView do
  use JaSerializer.PhoenixView

  attributes [:title, :body, :author_name, :author_photo_url, :created_at, :updated_at, :featured_image_url]

  def title(post) do
    post["fields"]["title"]
  end
  def body(post) do
    post["fields"]["body"]
  end

  def author_name(post) do
    hd(post["fields"]["author"])["fields"]["name"]
  end

  def created_at(post) do
    post["sys"]["updatedAt"]
  end

  def updated_at(post) do
    post["sys"]["updatedAt"]
  end

  def author_photo_url(post) do
    hd(post["fields"]["author"])["fields"]["profilePhoto"]["fields"]["file"]["url"]
  end

  def featured_image_url(%{"fields" => %{"featuredImage" => %{"fields" => %{"file" => %{"url" => imageurl}}}}} = post) do
    imageurl
  end

  def featured_image_url(_) do
    nil
  end
end
