defmodule Tenantee.Rent.Worker do
  @moduledoc """
  A worker that creates a new rent instance
  every month for each property and their tenants.
  """
  use Oban.Worker, queue: :rents
  alias Tenantee.Property
  alias Tenantee.Rent

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    Property.get_all_properties()
    |> Enum.each(fn property ->
      property.tenants
      |> Enum.each(fn tenant ->
        Rent.add_rent(
          property,
          tenant,
          DateTime.utc_now() |> DateTime.add(property.due_date_modifier, :second)
        )
      end)
    end)
  end
end
