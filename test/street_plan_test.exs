defmodule StreetPlanTest do
  use ExUnit.Case
  doctest StreetPlan

  test "Input street is invalid if empty" do
    refute StreetPlan.is_valid?("")
  end

  test "Input street is invalid if contains letters" do
    refute StreetPlan.is_valid?("1 2 4 6 7a 8")
  end

  test "Input street is invalid if contains duplicates" do
    refute StreetPlan.is_valid?("1 2 4 6 7 7 8")
  end

  test "Input street is valid" do
    assert StreetPlan.is_valid?("1 2 4 6 7 9 8")
  end

  test "Load street input" do
    assert StreetPlan.load_street!("1 2 3 4 5 6 7 8") == [1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "Load street with incorrect input raises error" do
    assert_raise(ArgumentError, "Input was in an incorrect format.", fn -> StreetPlan.load_street!("1 2 3 4 5 5 6 7 8") end)
  end

  test "Return correct number of delivery locations" do
    assert StreetPlan.get_no_of_houses([1, 2, 3, 4, 5, 6, 7, 8]) == 8
  end

  test "Return correct number of delivery locations on north side" do
    assert StreetPlan.get_no_of_houses_on_north_side([1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13]) == 7
  end

  test "Return correct number of delivery locations on south side" do
    assert StreetPlan.get_no_of_houses_on_south_side([1, 3, 4, 5, 7, 8]) == 2
  end
end
