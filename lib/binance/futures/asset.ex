defmodule Binance.Futures.Asset do
  defstruct [
    :account_alias,
    :asset,
    :balance,
    :cross_wallet_balance,
    :cross_un_pnl,
    :available_balance,
    :max_withdraw_amount
  ]

  use ExConstructor
end
