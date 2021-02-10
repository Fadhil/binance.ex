defmodule Binance.Futures.Account do
  defstruct [:assets]

  def new(assets) do
    assets =
      assets
      |> Enum.map(&Binance.Futures.Asset.new(&1))

    %__MODULE__{assets: assets}
  end
end
