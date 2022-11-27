defmodule Tenantee.Utils.Currency do
  @moduledoc """
  This module provides utility functions for working with currencies.
  """

  @doc """
  Checks if the given currency is valid.
  """
  def valid?(currency) do
    if Money.Currency.exists?(currency) do
      :ok
    else
      {:error, "Invalid currency"}
    end
  end
end
