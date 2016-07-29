defmodule RoutePrinter do
  @moduledoc """
  Marks delivery locations for a streetplan according to the approach
  Prints a delivery route in the form of a textual display
  """

  @type side :: :north | :south
  @type approach :: :approachOne | :approachTwo

  @doc """
  Returns a map structure representing the north side if the street and marked
  locations for deliveries, similar to the southern side as well as the middle
  of the road with any crossings where applicable.
  """
  @spec mark_route([integer], approach) :: map()
  def mark_route(houses, approach) do
    start_side = StreetPlan.get_side(List.first(houses))
    northern_houses = StreetPlan.get_houses_on_north_side(houses)
    southern_houses = StreetPlan.get_houses_on_south_side(houses)

    length_of_northern_side = diff_between(0, List.last(northern_houses))
    length_of_southern_side = diff_between(0, List.last(southern_houses))

    road_length = Enum.max([ length_of_northern_side, length_of_southern_side ])

    north = Map.new(0..road_length, & {&1, "-"})
    road = Map.new(0..road_length, & {&1, " "})
    south = Map.new(0..road_length, & {&1, "-"})

    north = List.foldl(northern_houses, north, &mark_delivery_location/2)
    south = List.foldl(southern_houses, south, &mark_delivery_location/2)

    has_houses_on_both_sides = StreetPlan.get_no_of_houses_on_north_side(houses) > 0 && StreetPlan.get_no_of_houses_on_south_side(houses) > 0

    road = cond do
      has_houses_on_both_sides && approach == :approachOne -> mark_single_crossing(road, road_length)
      has_houses_on_both_sides && approach == :approachTwo -> mark_all_crossings(start_side, road, houses)
      true -> road
    end

    %{
      :north => get_roadside_plan_sorted(north),
      :road => get_roadside_plan_sorted(road),
      :south => get_roadside_plan_sorted(south)
    }
  end

  @doc """
  Outputs to console, the representation of a streetplan with marked delivery
  destinations.
  """
  @spec print_route(map()) :: integer
  def print_route(marked_street_plan) do
    IO.puts marked_street_plan.north
    IO.puts marked_street_plan.road
    IO.puts marked_street_plan.south
  end

  @spec mark_delivery_location(pos_integer, map()) :: map()
  defp mark_delivery_location(hs_no, acc), do: Map.put(acc, hs_no, "x")

  @spec mark_crossing(pos_integer, map()) :: map()
  defp mark_crossing(hs_no, acc), do: Map.put(acc, hs_no, "|")

  @spec mark_single_crossing(map(), pos_integer) :: map()
  defp mark_single_crossing(road, last_north_house), do: mark_crossing(last_north_house, road)

  @spec mark_all_crossings(side, map(), [integer]) :: map()
  defp mark_all_crossings(_, road, []), do: road
  defp mark_all_crossings(curr_side, road, [hs_no | rest_of_houses]) do
    if StreetPlan.get_side(hs_no) !== curr_side do
      mark_all_crossings(StreetPlan.get_side(hs_no), mark_crossing(hs_no, road), rest_of_houses)
    else
      mark_all_crossings(curr_side, road, rest_of_houses)
    end
  end

  @spec get_roadside_plan_sorted(map()) :: list(pos_integer)
  defp get_roadside_plan_sorted(road_map) do
    Map.to_list(road_map)
    |> Enum.sort_by(& elem(&1, 0))
    |> Enum.map(& elem(&1, 1))
  end

  @spec diff_between(pos_integer, pos_integer) :: pos_integer
  defp diff_between(nil, _), do: 0
  defp diff_between(_, nil), do: 0
  defp diff_between(num1, num2) when num2 == num1, do: 0
  defp diff_between(num1, num2) when num2 < num1, do: diff_between(num2, num1)
  defp diff_between(num1, num2), do: num2 - num1
end
