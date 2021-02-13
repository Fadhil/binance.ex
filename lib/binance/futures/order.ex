defmodule Binance.Futures.Order do
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
    :stop_price,        # please ignore when order type is TRAILING_STOP_MARKET
    :close_position,    # if Close-All
    :symbol,
    :time_in_force,
    :type,
    :orig_type,
    :activate_price,    # activation price, only return with TRAILING_STOP_MARKET order
    :price_rate,        # callback rate, only return with TRAILING_STOP_MARKET order
    :update_time,
    :working_type,
    :price_protect

  ]

  use ExConstructor
end
