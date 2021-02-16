defmodule Binance.Futures.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Binance.Futures.Account

  describe ".get_account/0" do
    test "returns balances in futures account" do
      use_cassette "get_account" do
        assert {:ok, %Binance.Futures.Schemas.Account{}} = Binance.Futures.get_account()
      end
    end
  end

  describe ".get_balance/1" do
    test "returns the balance for an asset in the futures account" do
      use_cassette "get_balance" do
        assert {:ok, %Binance.Futures.Schemas.Asset{} = asset} =
                 Binance.Futures.get_balance("USDT")

        assert asset.balance == "101.90720270"
      end
    end

    test "returns error if the requested asset is not present in the futures account" do
      use_cassette "get_balance" do
        assert {:error, "Not Found"} = Binance.Futures.get_balance("XYZ")
      end
    end
  end
end
