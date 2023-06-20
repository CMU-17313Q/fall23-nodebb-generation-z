defmodule Tenantee.Data.RentTest do
  use Tenantee.DataCase
  alias Tenantee.Schema.Rent, as: Schema
  alias Tenantee.Entity.{Rent, Tenant}
  import Tenantee.Test.Factory.{Property, Tenant}
  import Tenantee.Jobs.Rent

  test "creates rent" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()

    assert {:ok, _rent} = Rent.create(tenant.id, property.id)
  end

  test "gets rent by id" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()
    {:ok, rent} = Rent.create(tenant.id, property.id)

    assert {:ok, ^rent} = Rent.get(rent.id)
  end

  test "gets total rents" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()
    {:ok, _rent} = Rent.create(tenant.id, property.id)

    assert 1 = Rent.total()
  end

  test "gets total unpaid rents" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()
    {:ok, _rent} = Rent.create(tenant.id, property.id)

    assert 1 = Rent.total_unpaid()
  end

  test "gets total overdue rents" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()
    {:ok, _rent} = Rent.create(tenant.id, property.id)

    assert 0 = Rent.total_overdue()
    assert 0 = Rent.total_overdue(tenant.id)
  end

  test "marks rent as paid" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()
    {:ok, rent} = Rent.create(tenant.id, property.id)

    assert {:ok, updated_rent} = Rent.pay(rent.id)
    assert updated_rent.paid
  end

  test "generates rents" do
    {:ok, tenant} = generate_tenant()
    {:ok, property} = generate_property()
    Tenant.add_to_property(tenant.id, property.id)
    generate_rents()

    assert 1 = Rent.total()
  end

  test "errors on getting rent by id" do
    assert {:error, "Rent not found"} = Rent.get(-1)
  end

  test "errors on paying rent" do
    assert {:error, "Rent not found"} = Rent.pay(-1)
  end

  test "errors on invalid price" do
    changeset =
      Schema.changeset(%Schema{}, %{
        amount: Money.new(0, :USD),
        due_date: Date.utc_today(),
        paid: false,
        tenant_id: 0
      })

    assert ["must be greater than 0"] = errors_on(changeset).amount
  end
end
