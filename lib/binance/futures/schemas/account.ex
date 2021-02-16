defmodule Binance.Futures.Schemas.Account do
  defstruct [:assets]

  alias Binance.Futures.Schemas.Asset

  def new(assets) do
    assets =
      assets
      |> Enum.map(&Asset.new(&1))

    %__MODULE__{assets: assets}
  end
end
