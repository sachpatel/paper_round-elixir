
streets = File.read!(Path.join([__DIR__, "..", "Street2.txt"]))
          |> String.split("\r\n", trim: true)
#|> Enum.map(fn x ->  String.split(x, ",", trim: true) end)
#|> IO.inspect

IO.puts ""

for str <- streets do  #process_street(str)
  IO.puts "For Street: #{str}\nUsing approach: :approachOne"

  StreetPlan.load_street!(str)
  |> RoutePrinter.mark_route(:approachOne)
  |> RoutePrinter.print_route

  IO.puts ""
end

IO.puts ""

for str <- streets do
  IO.puts "For Street: #{str}\nUsing approach: :approachTwo"

  StreetPlan.load_street!(str)
  |> RoutePrinter.mark_route(:approachTwo)
  |> RoutePrinter.print_route

  IO.puts ""
end
