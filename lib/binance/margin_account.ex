defmodule Binance.MarginAccount do
  @moduledoc """
  Struc for representing a resul row as returned by GET /sapi/v1/margin/account
  """

  defstruct [
    :borrow_enabled,
    :margin_level,
    :total_asset_of_btc,
    :total_liability_of_btc,
    :total_net_asset_of_btc,
    :trade_enabled,
    :transfer_enabled,
    :user_assets
  ]

  use ExConstructor

  def new(map_or_kwlist, opts \\ []) do
    require IEx; IEx.pry()
    user_assets =
      map_or_kwlist
      |> Map.get("userAssets")
      |> Enum.map(&Binance.MarginAsset.new(&1))

    new_map =
      map_or_kwlist
      |> Map.put(:user_assets, user_assets)

    ExConstructor.populate_struct(
      %__MODULE__{},
      new_map,
      Keyword.merge(@exconstructor_default_options, opts)
    )
  end
end
