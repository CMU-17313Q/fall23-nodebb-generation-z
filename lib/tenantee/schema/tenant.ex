defmodule Tenantee.Schema.Tenant do
  @moduledoc """
  Tenant Ecto Schema.
  """
  alias Tenantee.Schema.{Property, Expense, Rent, CommunicationChannel}

  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  A tenant. Someone who rents a property.
  By default, a tenant has no properties and no communication channels.
  First name and last name are required.

  Addionally, a tenant can have expenses related to a property.
  """

  @type t :: %__MODULE__{
          id: integer(),
          first_name: String.t(),
          last_name: String.t(),
          properties: [Property.t()],
          communication_channels: [CommunicationChannel.t()],
          expenses: [Expense.t()],
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "tenants" do
    field :first_name, :string
    field :last_name, :string

    has_many(:rents, Rent)
    many_to_many(:properties, Property, join_through: "leases", on_replace: :delete)
    has_many(:communication_channels, CommunicationChannel, on_replace: :delete)
    has_many(:expenses, Expense, on_delete: :nothing)

    timestamps()
  end

  def changeset(tenant, attrs \\ %{}) do
    tenant
    |> edit_changeset(attrs)
    |> put_assoc(:properties, [])
    |> put_assoc(:communication_channels, [])
  end

  def edit_changeset(tenant, attrs \\ %{}) do
    tenant
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def set_properties(%__MODULE__{} = tenant, properties) do
    tenant
    |> change()
    |> put_assoc(:properties, properties)
  end

  def set_communication_channels(%__MODULE__{} = tenant, communication_channels) do
    tenant
    |> change()
    |> put_assoc(:communication_channels, communication_channels)
  end
end
