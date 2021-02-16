defmodule Binance.Futures.Account do
  alias Binance.Rest.FuturesHTTPClient
  alias Binance.Futures.Account

  def get_account do
    api_key = Application.get_env(:binance, :api_key)
    secret_key = Application.get_env(:binance, :secret_key)

    case FuturesHTTPClient.get_futures("/fapi/v2/balance", %{}, secret_key, api_key) do
      {:ok, data} ->
        account = Account.new(data)
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
end
