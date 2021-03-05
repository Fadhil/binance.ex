defmodule Binance.Futures.Schemas.Bid do
  defstruct [:price, :quantity]

  def new([price, quantity] = _bid) do
    %__MODULE__{
      price: price,
      quantity: quantity
    }
  end
end
