defmodule RoutePrinterTest do
  use ExUnit.Case

  setup do
    {:ok, full_street: [1, 2, 4, 5, 6, 7, 9, 11, 13, 16, 18, 19, 20, 21, 23, 27, 28, 30, 32, 34, 36],
          one_side_north: [1, 3, 5],
          one_side_south: [4, 8, 16, 18],
          south_side_shorter_than_north: [1, 2, 4, 7, 9, 13, 19],
          south_side_longer_than_north: [1, 2, 3, 5, 7, 9, 12, 16, 18, 21, 22, 24, 26]}
  end

  test "Delivery Approach One route marks a single crossing", state do
    delivery_plan = RoutePrinter.mark_route(state[:full_street], :approachOne)

    northern_houses = StreetPlan.get_houses_on_north_side(state[:full_street])
    southern_houses = StreetPlan.get_houses_on_south_side(state[:full_street])

    assert Enum.all?(northern_houses, fn x -> Enum.at(delivery_plan.north, x) == "x" end)
    assert Enum.all?(delivery_plan.north |> Enum.reject(& &1 == "x"), & &1 == "-")
    assert Enum.any?(delivery_plan.road, & &1 == "|")
    assert Enum.all?(southern_houses, fn x -> Enum.at(delivery_plan.south, x) == "x" end)
  end

  test "Delivery Approach Two route marks multiple crossings", state do
    delivery_plan = RoutePrinter.mark_route(state[:full_street], :approachTwo)

    northern_houses = StreetPlan.get_houses_on_north_side(state[:full_street])
    southern_houses = StreetPlan.get_houses_on_south_side(state[:full_street])

    assert Enum.all?(northern_houses, fn x -> Enum.at(delivery_plan.north, x) == "x" end)
    assert Enum.all?(delivery_plan.north |> Enum.reject(& &1 == "x"), & &1 == "-")
    assert Enum.count(delivery_plan.road, & &1 == "|") > 0
    assert Enum.all?(southern_houses, fn x -> Enum.at(delivery_plan.south, x) == "x" end)
  end

  test "Delivery Approach One route has no crossings", state do
    delivery_plan = RoutePrinter.mark_route(state[:one_side_north], :approachOne)

    northern_houses = StreetPlan.get_houses_on_north_side(state[:one_side_north])
    southern_houses = StreetPlan.get_houses_on_south_side(state[:one_side_north])

    assert Enum.all?(northern_houses, fn x -> Enum.at(delivery_plan.north, x) == "x" end)
    assert Enum.all?(delivery_plan.north |> Enum.reject(& &1 == "x"), & &1 == "-")
    refute Enum.any?(delivery_plan.road, & &1 == "|")
    assert Enum.all?(southern_houses, fn x -> Enum.at(delivery_plan.south, x) == "x" end)
  end

  test "Delivery Approach One route has crossing immediately after last house on the north side with lower house numbers on south side", state do
    delivery_plan = RoutePrinter.mark_route(state[:south_side_shorter_than_north], :approachOne)

    northern_houses = StreetPlan.get_houses_on_north_side(state[:south_side_shorter_than_north])
    southern_houses = StreetPlan.get_houses_on_south_side(state[:south_side_shorter_than_north])

    assert Enum.all?(northern_houses, fn x -> Enum.at(delivery_plan.north, x) == "x" end)
    assert Enum.all?(delivery_plan.north |> Enum.reject(& &1 == "x"), & &1 == "-")
    assert Enum.at(delivery_plan.road, List.last(northern_houses)) == "|"
    assert Enum.all?(southern_houses, fn x -> Enum.at(delivery_plan.south, x) == "x" end)
  end

  test "Delivery Approach One route has crossing at end of north side with higher house numbers on south side", state do
    delivery_plan = RoutePrinter.mark_route(state[:south_side_longer_than_north], :approachOne)

    northern_houses = StreetPlan.get_houses_on_north_side(state[:south_side_longer_than_north])
    southern_houses = StreetPlan.get_houses_on_south_side(state[:south_side_longer_than_north])

    assert Enum.all?(northern_houses, fn x -> Enum.at(delivery_plan.north, x) == "x" end)
    assert Enum.all?(delivery_plan.north |> Enum.reject(& &1 == "x"), & &1 == "-")
    assert Enum.at(delivery_plan.road, List.last(southern_houses)) == "|"
    assert Enum.all?(southern_houses, fn x -> Enum.at(delivery_plan.south, x) == "x" end)
  end

end
