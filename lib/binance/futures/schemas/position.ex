defmodule Binance.Futures.Schemas.Position do
  defstruct [
    :entry_price,
    :margin_type,
    :is_auto_add_margin,
    :leverage,
    :liquidation_price,
    :mark_price,
    :max_notional_value,
    :position_amt,
    :symbol,
    :un_realized_profit,
    :position_side
  ]

  use ExConstructor

  def new(map_or_kwlist) do
    position =
      map_or_kwlist
      |> Map.put("isAutoAddMargin", boolean_from_string(map_or_kwlist["isAutoAddMargin"]))

    ExConstructor.populate_struct(%__MODULE__{}, position)
  end

  def boolean_from_string("true"), do: true
  def boolean_from_string("false"), do: false
end
