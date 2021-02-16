defmodule Binance.Futures.Schemas.Account do
  defstruct [:assets]

  def new(assets) do
    assets =
      assets
      |> Enum.map(&Binance.Futures.Schemas.Asset.new(&1))

    %__MODULE__{assets: assets}
  end
end
