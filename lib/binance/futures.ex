defmodule Binance.Futures do
  alias Binance.Futures.Account
  alias Binance.Futures.Trade

  defdelegate get_account, to: Account
  defdelegate get_balance(symbol), to: Account
  defdelegate get_positions, to: Trade
  defdelegate place_order(side, symbol, price, quantity, opts \\ []), to: Trade
end
