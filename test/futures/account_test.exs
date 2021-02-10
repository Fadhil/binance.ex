defmodule Binance.Futures.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Binance.Futures

  describe ".get_account" do
    test "returns balances in futures account" do
      use_cassette "get_account" do
        assert {:ok, %Binance.Futures.Account{}} = Binance.Futures.get_account()
      end
    end
  end
end
