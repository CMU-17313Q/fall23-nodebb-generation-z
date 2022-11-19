defmodule TenanteeWeb.PropertyView do
  use TenanteeWeb, :view
  alias TenanteeWeb.TenantView

  def render("show.json", %{properties: properties}) do
    %{
      properties:
        Enum.map(properties, fn property ->
          render("show.json", %{property: property}) |> Map.get(:property)
        end)
    }
  end

  def render("show.json", %{property: property}) do
    %{
      property: %{
        id: property.id,
        name: property.name,
        description: property.description,
        location: property.location,
        price: %{
          amount: property.price.amount,
          currency: property.price.currency
        },
        inserted_at: property.inserted_at,
        updated_at: property.updated_at,
        tenants:
          render(TenantView, "show.json", %{tenants: property.tenants}) |> Map.get(:tenants)
      }
    }
  end

  def render("delete.json", %{}) do
    %{
      message: "Property deleted"
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
