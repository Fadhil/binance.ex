defmodule Binance.Futures.Schemas.OrderBook do
  defstruct [:bids, :asks]

  alias Binance.Futures.Schemas.Bid
  alias Binance.Futures.Schemas.Ask

  def new(order_book) do
    bids =
      order_book
      |> Map.get("bids")
      |> Enum.map(&Bid.new(&1))

    asks =
      order_book
      |> Map.get("asks")
      |> Enum.map(&Ask.new(&1))

    %__MODULE__{bids: bids, asks: asks}
  end
end
