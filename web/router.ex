defmodule ChatSample.Router do
  use ChatSample.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "jpeg", "png"]
  end

  scope "/", ChatSample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/rooms", RoomController, only: ~w(show)a
  end

  # Other scopes may use custom stacks.
  scope "/api", ChatSample do
    pipe_through :api

    resources "/images", ImageController, only: ~w(create show)a
  end
end
