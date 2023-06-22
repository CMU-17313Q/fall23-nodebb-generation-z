defmodule Tenantee.Cldr do
  @moduledoc """
  This module is used to configure the Cldr library.
  """
  use Cldr,
    locales: ["en"],
    default_locale: "en",
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime, Money]

  def format_date(date) do
    case Tenantee.Cldr.Date.to_string(date) do
      {:ok, formatted_date} -> formatted_date
      _error -> "Invalid date"
    end
  end

  def format_price(price) do
    with {:ok, formatted_price} <- Tenantee.Cldr.Money.to_string(price, symbol: true) do
      formatted_price
    end
  end
end
