require("pry-byebug")
require_relative("models/properties")

Property.delete_all()

property1 = Property.new( {"address" => "111 Princes Street", "value" => "27000", "bedrooms" => "5", "year" => "1980"} )
property2 = Property.new( {"address" => "22 Oliver Gardens", "value" => "100000", "bedrooms" => "1", "year" => "1955"} )
property3 = Property.new( {"address" => "33 Penny Lane", "value" => "3000", "bedrooms" => "3", "year" => "1923"} )
property4 = Property.new( {"address" => "56 Helena Way", "value" => "4400", "bedrooms" => "6", "year" => "1934"} )

property1.save()
property2.save()
property3.save()
property4.save()

property2.address = "9 Cherry Grove"
property2.update()

property1.delete()


binding.pry
nil