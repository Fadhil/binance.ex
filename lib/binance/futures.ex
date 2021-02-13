defmodule Binance.Futures do
  alias Binance.Rest.FuturesHTTPClient

  def get_account do
    api_key = Application.get_env(:binance, :api_key)
    secret_key = Application.get_env(:binance, :secret_key)

    case FuturesHTTPClient.get_futures("/fapi/v2/balance", %{}, secret_key, api_key) do
      {:ok, data} ->
        account = Binance.Futures.Account.new(data)
        {:ok, account}

      err ->
        err
    end
  end

  def get_balance(symbol) do
    {:ok, account} = get_account()

    asset =
      account.assets
      |> Enum.filter(&(&1.asset == symbol))

    case asset do
      [asset] ->
        {:ok, asset}
      [] ->
        {:error, "Not Found"}
    end
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
        timeInForce: Keyword.get(opts, :time_in_force, "GTC"),
        type: Keyword.get(opts, :type, "LIMIT")
      }

    case FuturesHTTPClient.post_futures("/fapi/v1/order", arguments) do
      {:ok, %{"code" => code, "msg" => msg}} ->
        {:error, {:binance_error, %{code: code, msg: msg}}}

      {:ok, data} ->
        {:ok, Binance.Futures.Order.new(data)}
    end
  end
end
