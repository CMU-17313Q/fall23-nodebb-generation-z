defmodule TenanteeWeb.Components.Property do
  @moduledoc """
  Provides UI components for the Property context.
  """
  alias Tenantee.Cldr
  use Phoenix.Component
  import TenanteeWeb.CoreComponents

  @doc """
  Renders a property card.
  """
  attr :property, :map, required: true

  def card(assigns) do
    ~H"""
    <div class="flex flex-col gap-4 shadow-lg border border-gray-200 rounded-lg p-4">
      <div class="flex flex-row justify-between">
        <h1 class="text-2xl font-bold text-gray-800 flex items-center gap-2">
          <.icon name="hero-home" class="w-8 h-8" />
          <%= @property.name %>
        </h1>
        <.button
          class="bg-red-500 text-white hover:bg-red-600"
          phx-click={open_confirm_modal(@property.id)}
        >
          <.icon name="hero-trash" class="w-4 h-4" /> Delete
        </.button>
      </div>
      <hr class="border border-gray-200 w-full" />
      <p class="text-gray-600">
        <span class="font-bold">Address:</span>
        <%= @property.address %>
      </p>
      <p class="text-gray-600">
        <span class="font-bold">Price:</span>
        <%= format_price(@property.price) %>
      </p>
      <p class="text-gray-600">
        <span class="font-bold">Description:</span>
        <%= if @property.description == "" do %>
          No description provided.
        <% else %>
          <%= @property.description %>
        <% end %>
      </p>
      <a href={"/properties/#{@property.id}"}>
        <.button>
          <.icon name="hero-pencil" class="w-4 h-4" /> Edit
        </.button>
      </a>
    </div>
    """
  end

  defp format_price(price) do
    with {:ok, formatted_price} <- Cldr.Money.to_string(price, symbol: true) do
      formatted_price
    end
  end
end
