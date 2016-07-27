File.read!(Path.join([__DIR__, "..", "Street1.txt"]))
|> IO.inspect
|> StreetPlan.load_street!
|> RoutePrinter.mark_route(:approachOne)
|> RoutePrinter.print_route
