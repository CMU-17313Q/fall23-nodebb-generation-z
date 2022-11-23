defmodule Tenantee.Rent do
  @moduledoc """
  This module contains all the necessary functions to manage rents.
  """

  alias Tenantee.Repo
  alias Tenantee.Rent.Schema
  import Ecto.Query

  @doc """
  Returns a list of unpaid rents by property.
  """
  def get_unpaid_rents(property_id) do
    Repo.all(
      from r in Schema,
        where: r.property_id == ^property_id and r.paid == false
    )
    |> Enum.map(&Repo.preload(&1, :tenant))
  end

  @doc """
  Returns wheter a tenant has unpaid rents.
  """
  def get_unpaid_rents_by_tenant_id(tenant_id) do
    Repo.all(
      from r in Schema,
        where: r.tenant_id == ^tenant_id and r.paid == false
    )
    |> Enum.map(&Repo.preload(&1, :property))
  end
end
