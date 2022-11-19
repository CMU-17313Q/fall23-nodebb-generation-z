defmodule Tenantee.Property do
  @moduledoc """
  This module contains all the necessary functions to manage properties.
  """

  alias Tenantee.Repo
  alias Tenantee.Property.Schema
  alias Tenantee.Tenant
  alias Tenantee.Tenant.Schema, as: TenantSchema
  import Ecto.Query

  @doc """
  Creates a new property.
  """
  def create_property(attrs) do
    with {:ok, property} <-
           %Schema{}
           |> Schema.changeset(attrs)
           |> Repo.insert() do
      {:ok, Repo.preload(property, :tenants)}
    end
  end

  @doc """
  Gets a single property.
  """
  def get_property(id) do
    Repo.get(Schema, id)
    |> Repo.preload([:tenants])
  end

  @doc """
  Gets a list of all the properties.
  """
  def get_all_properties do
    Repo.all(Schema)
    |> Repo.preload([:tenants])
  end

  @doc """
  Updates an existing property.
  """
  def update_property(id, attrs) do
    with {:ok, property} <-
           get_property(id)
           |> Schema.changeset(attrs)
           |> Repo.update() do
      {:ok, Repo.preload(property, :tenants)}
    end
  end

  @doc """
  Deletes an existing property.
  """
  def delete_property(id) do
    from(p in Schema, where: p.id == ^id)
    |> Repo.delete_all()
  end

  @doc """
  Adds an existing tenant to a property.
  """
  def add_tenant(property_id, tenant_id) do
    with %Schema{} = property <- get_property(property_id),
         %TenantSchema{} = tenant <- Tenant.get_tenant_by_id(tenant_id) do
      Schema.add_tenant(property, tenant)
      |> Repo.update()
    end
  end

  @doc """
  Removes a tenant from the property.
  """
  def remove_tenant(property_id, tenant_id) do
    with %Schema{} = property <- get_property(property_id),
         %TenantSchema{} = tenant <- Tenant.get_tenant_by_id(tenant_id) do
      Schema.remove_tenant(property, tenant)
      |> Repo.update()
    end
  end
end
