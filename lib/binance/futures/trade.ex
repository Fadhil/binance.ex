defmodule Binance.Futures.Trade do
  alias Binance.Rest.FuturesHTTPClient

  def get_positions do
    api_key = Application.get_env(:binance, :api_key)
    secret_key = Application.get_env(:binance, :secret_key)

    case FuturesHTTPClient.get_futures("/fapi/v2/positionRisk", %{}, secret_key, api_key) do
      {:ok, data} ->
        positions =
          data
          |> Enum.filter(&non_zero_positions/1)
          |> Enum.map(&Binance.Futures.Schemas.Position.new(&1))

        {:ok, positions}

      err ->
        err
    end
  end

  def get_position_mode do
    api_key = Application.get_env(:binance, :api_key)
    secret_key = Application.get_env(:binance, :secret_key)

    case FuturesHTTPClient.get_futures("/fapi/v1/positionSide/dual", %{}, secret_key, api_key) do
      {:ok, data} ->
        {:ok, %{dual_side_position_mode: data["dualSidePosition"]}}

      err ->
        err
    end

  end

  defp non_zero_positions(%{"positionAmt" => amount}) do
    {amount_in_float, _} = Float.parse(amount)
    amount_in_float != 0.0
  end

  @doc """
  Places an order on Binance Futures with the futures account.

  Returns an Order.

  ## Parameters

    - side: Trade position ("BUY" or "SELL"). String
    - symbol: Symbol of the market to trade in (e.g. "BTCUSDT"). String
    - price: Price of the asset to place the order at (e.g. ) Number
    - quantity: Quantity of asset to buy. Number
    - opts: Optional arguments for order
        - type: Type of order. One of [LIMIT, MARKET, STOP/TAKE_PROFIT,
                STOP_MARKET/TAKE_PROFIT_MARKET]. Defaults to LIMIT
        - time_in_force:  one of:
                            GTC - Good Till Cancel
                            IOC - Immediate or Cancel
                            FOK - Fill or Kill
                            GTX - Good Till Crossing (Post Only)

                            Defaults to GTC

  """
  def place_order(side, symbol, price, quantity, opts \\ []) do
    arguments = %{
      side: side,
      symbol: symbol,
      price: price,
      quantity: quantity,
      positionSide: Keyword.get(opts, :position_side, "BOTH"),
      timeInForce: Keyword.get(opts, :time_in_force, "GTC"),
      type: Keyword.get(opts, :type, "LIMIT")
    }

    case FuturesHTTPClient.post_futures("/fapi/v1/order", arguments) do
      {:ok, %{"code" => code, "msg" => msg}} ->
        {:error, {:binance_error, %{code: code, msg: msg}}}

      {:ok, data} ->
        {:ok, Binance.Futures.Schemas.Order.new(data)}
    end
  end
end
