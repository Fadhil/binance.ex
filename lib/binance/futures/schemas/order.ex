defmodule Binance.Futures.Schemas.Order do
  defstruct [
    :client_order_id,
    :cum_qty,
    :cum_quote,
    :executed_qty,
    :order_id,
    :avg_price,
    :orig_qty,
    :price,
    :reduce_only,
    :side,
    :position_side,
    :status,
    # please ignore when order type is TRAILING_STOP_MARKET
    :stop_price,
    # if Close-All
    :close_position,
    :symbol,
    :time_in_force,
    :type,
    :orig_type,
    # activation price, only return with TRAILING_STOP_MARKET order
    :activate_price,
    # callback rate, only return with TRAILING_STOP_MARKET order
    :price_rate,
    :update_time,
    :working_type,
    :price_protect
  ]

  use ExConstructor
end
