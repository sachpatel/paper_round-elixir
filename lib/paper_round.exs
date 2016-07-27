#[1, 2, 4, 7, 9, 13, 16, 19]

File.read!(Path.join([__DIR__, "..", "Street1.txt"]))
|> IO.inspect
|> StreetPlan.load_street!
|> RoutePrinter.mark_route(:approachOne)
|> RoutePrinter.print_route
