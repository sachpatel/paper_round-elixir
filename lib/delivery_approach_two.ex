defmodule DeliveryApproachTwo do
  require Integer

  @spec get_crossings([pos_integer]) :: non_neg_integer
  def get_crossings(houses) do
    cond do
      StreetPlan.get_no_of_houses_on_south_side(houses) == 0 -> 0
      true -> count_crossings(houses, 0, hd(houses) |> StreetPlan.get_side)
    end
  end

  @spec get_route([pos_integer]) :: [pos_integer]
  def get_route(houses), do: houses

  @spec count_crossings([integer], non_neg_integer, StreetPlan.side) :: non_neg_integer
  defp count_crossings([], current_crossing_count, _), do: current_crossing_count
  defp count_crossings([hs_no | rest_of_houses], current_crossing_count, curr_side) do
    if StreetPlan.get_side(hs_no) !== curr_side do
      count_crossings(rest_of_houses, current_crossing_count + 1, StreetPlan.get_side(hs_no))
    else
      count_crossings(rest_of_houses, current_crossing_count, curr_side)
    end
  end
end
