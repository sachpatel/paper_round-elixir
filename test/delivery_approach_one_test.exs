defmodule DeliveryApproachOneTest do
  use ExUnit.Case

  setup do
    {:ok, full_street: [1, 2, 3, 4, 5, 6, 7], one_side_north: [1, 3, 5], one_side_south: [4, 8, 16, 18]}
  end

  test "Delivery Approach One route has no crossings (northern side)", state do
    assert DeliveryApproachOne.get_crossings(state[:one_side_north]) == 0
  end

  test "Delivery Approach One route has no crossings (southern side)", state do
    assert DeliveryApproachOne.get_crossings(state[:one_side_south]) == 1
  end

  test "Delivery Approach One route has only one delivery with no crossings" do
    assert DeliveryApproachOne.get_crossings([3]) == 0
  end

  test "Delivery Approach One route has only one delivery with one crossing" do
    assert DeliveryApproachOne.get_crossings([4]) == 1
  end

  test "Delivery Approach One route has a crossing", state do
    assert DeliveryApproachOne.get_crossings(state[:full_street]) == 1
  end

  test "Delivery Approach One route has houses on north side (ascending) followed by houses on south side (descending)", state do
    assert DeliveryApproachOne.get_route(state[:full_street]) == [1, 3, 5, 7, 6, 4, 2]
  end
end
