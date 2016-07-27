defmodule StreetPlan do
  require(Integer)
  @moduledoc """
  This module loads a StreetPlan and can return general detail about a street.
  """
  @type side :: :north | :south

  @spec is_valid?(String.t) :: boolean
  def is_valid?(houses) do
    cond do
      houses == "" -> false
      Regex.scan(~r/[A-Za-z]/, houses) |> Enum.count > 0 -> false
      String.split(houses, " ") |> Enum.uniq |> Enum.count !== String.split(houses, " ") |> Enum.count -> false
      true -> true
    end
  end

  @spec load_street!(String.t) :: [non_neg_integer]
  def load_street!(houses) do
    if is_valid?(houses) do
      String.split(houses, " ") |> Stream.map(& String.to_integer(&1)) |> Enum.sort
    else
      raise(ArgumentError, "Input was in an incorrect format.")
    end
  end

  @spec get_no_of_houses([integer]) :: non_neg_integer
  def get_no_of_houses(houses), do: Enum.count(houses)

  @spec get_no_of_houses_on_north_side([integer]) :: non_neg_integer
  def get_no_of_houses_on_north_side(houses), do: Enum.count(houses, & Integer.is_odd(&1))

  @spec get_no_of_houses_on_south_side([integer]) :: non_neg_integer
  def get_no_of_houses_on_south_side(houses), do: Enum.count(houses, & Integer.is_even(&1))

  @spec get_houses_on_north_side([integer]) :: [integer]
  def get_houses_on_north_side([]), do: []
  def get_houses_on_north_side(houses), do: Enum.filter(houses, & rem(&1, 2) == 1)

  @spec get_houses_on_south_side([integer]) :: [integer]
  def get_houses_on_south_side([]), do: []
  def get_houses_on_south_side(houses), do: Enum.filter(houses, & rem(&1, 2) == 0)

  @spec get_side(non_neg_integer) :: side
  def get_side(num) when rem(num, 2) == 1, do: :north
  def get_side(num) when rem(num, 2) == 0, do: :south
end
