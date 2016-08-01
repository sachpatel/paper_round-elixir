defmodule DeliveryApproachTwoTest do
  use ExUnit.Case

  setup do
    {:ok, full_street: [1, 2, 3, 4, 5, 6, 7], one_side_north: [1, 3, 5], one_side_south: [2, 6, 14, 16], one_crossing: [1, 3, 6, 8, 12]}
  end

  test "Delivery Approach Two route has no crossings (northern side only)", state do
    assert DeliveryApproachTwo.get_crossings(state[:one_side_north]) == 0
  end

  test "Delivery Approach Two route has no crossings (southern side only)", state do
    assert DeliveryApproachTwo.get_crossings(state[:one_side_south]) == 0
  end

  test "Delivery Approach Two route has only one delivery with no crossings (north side)" do
    assert DeliveryApproachTwo.get_crossings([3]) == 0
  end

  test "Delivery Approach Two route has only one delivery with no crossings (south side)" do
    assert DeliveryApproachTwo.get_crossings([4]) == 0
  end

  test "Delivery Approach Two route has a crossing", state do
    assert DeliveryApproachTwo.get_crossings(state[:one_crossing]) == 1
  end

  test "Delivery Approach Two route has multiple crossings", state do
    assert DeliveryApproachTwo.get_crossings(state[:full_street]) == 6
  end

  test "Delivery Approach Two route has houses on north side (ascending) followed by houses on south side (descending)" do
    assert DeliveryApproachTwo.get_route([1, 2, 4, 6, 7, 8, 9, 11, 12, 14, 16]) == [1, 2, 4, 6, 7, 8, 9, 11, 12, 14, 16]
  end
end
