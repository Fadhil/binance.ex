defmodule Binance.Rest.FuturesHTTPClient do
  @futures_endpoint Application.get_env(:binance, :futures_endpoint)

  def get_futures(url, headers \\ []) do
    HTTPoison.get("#{@futures_endpoint}#{url}", headers)
    |> parse_response
  end

  def get_futures(url, params, secret_key, api_key) do
    case prepare_request(url, params, secret_key, api_key) do
      {:error, _} = error ->
        error

      {:ok, url, headers} ->
        get_futures(url, headers)
    end
  end

  defp prepare_request(url, params, secret_key, api_key) do
    case validate_credentials(secret_key, api_key) do
      {:error, _} = error ->
        error

      _ ->
        headers = [{"X-MBX-APIKEY", api_key}]
        receive_window = 5000
        ts = DateTime.utc_now() |> DateTime.to_unix(:millisecond)

        params =
          Map.merge(params, %{
            timestamp: ts,
            recvWindow: receive_window
          })

        argument_string = URI.encode_query(params)

        signature =
          :crypto.hmac(
            :sha256,
            secret_key,
            argument_string
          )
          |> Base.encode16()

        {:ok, "#{url}?#{argument_string}&signature=#{signature}", headers}
    end
  end

  defp validate_credentials(nil, nil),
    do: {:error, {:config_missing, "Secret and API key missing"}}

  defp validate_credentials(nil, _api_key),
    do: {:error, {:config_missing, "Secret key missing"}}

  defp validate_credentials(_secret_key, nil),
    do: {:error, {:config_missing, "API key missing"}}

  defp validate_credentials(_secret_key, _api_key),
    do: :ok

  defp parse_response({:ok, response}) do
    response.body
    |> Poison.decode()
    |> parse_response_body
  end

  defp parse_response({:error, err}) do
    {:error, {:http_error, err}}
  end

  defp parse_response_body({:ok, data}) do
    case data do
      %{"code" => _c, "msg" => _m} = error -> {:error, error}
      _ -> {:ok, data}
    end
  end

  defp parse_response_body({:error, err}) do
    {:error, {:poison_decode_error, err}}
  end
end
