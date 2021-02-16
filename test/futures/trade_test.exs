defmodule Binance.Futures.TradeTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Binance.Futures.Trade

  describe ".place_order/5" do
    test "places an order on binance and returns a Futures.Order" do
      use_cassette "place_new_order" do
        side = "BUY"
        symbol = "AKROUSDT"
        price = 0.05188
        quantity = 100

        assert {:ok, %Binance.Futures.Schemas.Order{} = order} =
                 Binance.Futures.place_order(side, symbol, price, quantity)

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

  describe ".get_positions/0" do
    test "returns a list of currently held positions" do
      use_cassette "get_positions" do
        assert {:ok, [position | _tail]} = Binance.Futures.get_positions()

        assert %Binance.Futures.Schemas.Position{} = position
        assert position.entry_price == "0.72319"
        assert position.margin_type == "isolated"
        assert position.is_auto_add_margin == false
        assert position.leverage == "30"
        assert position.liquidation_price == "0.69546799"
        assert position.mark_price == "0.70642000"
        assert position.max_notional_value == "5000"
        assert position.position_amt == "150"
        assert position.symbol == "LRCUSDT"
        assert position.un_realized_profit == "-2.51550000"
        assert position.position_side == "BOTH"
      end
    end
  end
end
