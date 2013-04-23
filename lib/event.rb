class Event
	attr_accessor :name, :days, :starts, :ends

	def initialize(name, days, starts, ends)
		@name = name
		@days = days
		@starts = starts
		@ends = ends
	end	

	def to_s
		return name.to_s + ", " + days.to_s + ", " + starts.to_s + ", " + ends.to_s
	end

	def parseDate(day)
		if (day == "M")
			return "monday"
		elsif (day == "Tu")
			return "tuesday"
		elsif (day == "W")
			return "wednesday"
		elsif (day == "Th")
			return "thursday"
		else 
			return "friday"		
		end
	end

end