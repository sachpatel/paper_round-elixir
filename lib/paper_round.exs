
streets = File.read!(Path.join([__DIR__, "..", "Street2.txt"]))
          |> String.split("\r\n", trim: true)

for str <- streets do
  IO.puts ""

  IO.puts "For Street: #{str}\nUsing approach: :approachOne"

  StreetPlan.load_street!(str)
  |> RoutePrinter.mark_route(:approachOne)
  |> RoutePrinter.print_route

  IO.puts ""

  IO.puts "Using approach: :approachTwo"

  StreetPlan.load_street!(str)
  |> RoutePrinter.mark_route(:approachTwo)
  |> RoutePrinter.print_route
end

IO.puts ""
