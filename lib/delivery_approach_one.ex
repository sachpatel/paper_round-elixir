defmodule DeliveryApproachOne do
  require Integer

  @spec get_crossings([pos_integer]) :: non_neg_integer
  def get_crossings(houses) do
    cond do
      StreetPlan.get_no_of_houses_on_south_side(houses) == 0 -> 0
      true -> 1
    end
  end

  @spec get_route([pos_integer]) :: [pos_integer]
  def get_route(houses) do
      south_side = StreetPlan.get_houses_on_south_side(houses) |> Enum.reverse
      StreetPlan.get_houses_on_north_side(houses) ++ south_side
  end
end
