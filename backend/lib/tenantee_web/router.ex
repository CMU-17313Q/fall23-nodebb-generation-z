defmodule TenanteeWeb.Router do
  use TenanteeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TenanteeWeb do
    pipe_through :api

    get "/health-check", HealthCheckController, :index

    scope "/properties" do
      post "/", PropertyController, :add
      get "/", PropertyController, :list
      get "/:id", PropertyController, :get
    end
  end
end
