defmodule TenanteeWeb.TenantView do
  use TenanteeWeb, :view
  alias TenanteeWeb.RentView
  alias Tenantee.Rent

  def render("show.json", %{tenants: tenants}) do
    %{
      tenants:
        Enum.map(tenants, fn tenant ->
          render("show.json", %{tenant: tenant}) |> Map.get(:tenant)
        end)
    }
  end

  def render("show.json", %{tenant: tenant}) do
    %{
      tenant: %{
        id: tenant.id,
        name: tenant.first_name <> " " <> tenant.last_name,
        phone: tenant.phone,
        email: tenant.email,
        unpaid_rents:
          render(RentView, "show.json", %{
            rents: Rent.get_unpaid_rents_by_tenant_id(tenant.id)
          })
          |> Map.get(:rents)
      }
    }
  end

  def render("show_rent.json", %{rent: rent}) do
    %{
      rent: %{
        property: %{
          id: rent.property.id,
          name: rent.property.name
        },
        paid: rent.paid,
        due_date: rent.due_date
      }
    }
  end

  def render("show_rent.json", %{rents: rents}) do
    %{
      rents:
        Enum.map(rents, fn rent ->
          render("show_rent.json", %{rent: rent}) |> Map.get(:rent)
        end)
    }
  end

  def render("delete.json", %{}) do
    %{
      message: "Tenant deleted"
    }
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
