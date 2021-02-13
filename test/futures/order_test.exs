defmodule Binance.Futures.OrderTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Binance.Futures.Order

  describe ".place_order/5" do
    test "places an order on binance and returns a Futures.Order" do
      use_cassette "place_new_order" do
        side = "BUY"
        symbol = "AKROUSDT"
        price = 0.05188
        quantity = 100

        assert {:ok, %Binance.Futures.Order{} = order} = Binance.Futures.place_order(side, symbol, price, quantity)
        assert order.avg_price == "0.00000"
        refute is_nil(order.client_order_id)
        assert is_nil(order.activate_price)
        assert order.executed_qty == "0"
        assert not is_nil(order.order_id)
        assert order.side == "BUY"
        assert order.orig_qty == "100"
        assert order.reduce_only == false
        assert order.status == "NEW"
        assert order.symbol == "AKROUSDT"
        assert order.time_in_force == "GTC"
        assert order.type == "LIMIT"
      end
    end
  end
end
