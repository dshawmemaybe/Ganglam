module CanvasHelper
def table()
    
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

	def separateDays(days)
		return days.split(/(?=[A-Z])/)
	end
end