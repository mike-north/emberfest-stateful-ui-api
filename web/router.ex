defmodule Blog.Router do
  use Blog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/", Blog do
    pipe_through :api # Use the default browser stack
    resources "/comments", CommentController, except: [:new, :edit, :create]
    resources "/posts", PostController, only: [:index, :show] do
      resources "/comment", CommentController, only: [:create, :update]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Blog do
  #   pipe_through :api
  # end
end
