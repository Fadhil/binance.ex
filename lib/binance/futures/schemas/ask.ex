defmodule Binance.Futures.Schemas.Ask do
  defstruct [:price, :quantity]

  def new([price, quantity] = _ask) do
    %__MODULE__{
      price: price,
      quantity: quantity
    }
  end
end
