defmodule Binance.MarginAsset do
  @moduledoc """
  Struct for representing the result returned by GET /sapi/v1/margin/allAssets
  """

  defstruct [
    :asset,
    :borrowed,
    :free,
    :interest,
    :locked,
    :net_asset
  ]

  use ExConstructor
end
