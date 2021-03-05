defmodule Binance.Futures do
  alias Binance.Futures.Account
  alias Binance.Futures.Trade

  defdelegate get_account, to: Account
  defdelegate get_balance(symbol), to: Account

  defdelegate get_all_open_orders, to: Trade
  defdelegate get_positions, to: Trade
  defdelegate get_position_mode, to: Trade
  defdelegate get_order_book(symbol, opts \\ []), to: Trade
  defdelegate place_order(side, symbol, price, quantity, opts \\ []), to: Trade
end
