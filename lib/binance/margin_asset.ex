defmodule Binance.MarginAsset do
  @moduledoc """
  Struct for representing the result returned by GET /sapi/v1/margin/allAssets
  """

  defstruct [
    :asset_full_name,
    :asset_name,
    :is_borrowable,
    :is_morgageable,
    :user_min_borrow,
    :user_min_repay
  ]

  use ExConstructor
end
