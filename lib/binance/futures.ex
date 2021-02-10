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
end
