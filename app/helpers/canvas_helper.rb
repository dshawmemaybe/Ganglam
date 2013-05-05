module CanvasHelper
def intersecting(group,day)
	users = Group.where(:groupid => group).first.user_ids
      events = []
      users.each_with_index {|user|
      User.where(:email => user).first.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
        	if (x.to_s == day.to_s)
        		events.push(Stop.new(tokenizeTime(c.starttime[i].to_s.sub(/-0400/, "")),"s"));
				events.push(Stop.new(tokenizeTime(c.endtime[i].to_s.sub(/-0400/, "")),"e"));
			end
        }
      }
    }
  }
    events.sort! { |a,b|
    	if (a.time.split(":")[0].to_i > b.time.split(":")[0].to_i)
    		1
    	elsif (a.time.split(":")[0].to_i < b.time.split(":")[0].to_i)
    		-1	
    	else
    		if (a.time.split(":")[1].to_i > b.time.split(":")[1].to_i)
    			1
    		elsif (a.time.split(":")[1].to_i < b.time.split(":")[1].to_i)
    			-1	
    		else
    			 if (a.flag == "s")
    			 	-1
    			 elsif (b.flag == "s")
    			 	1
    			 else
    			 	-1
    			 end
    			 			
    		end
    	end
    }

    return findtime(events,day)
  end

  def findtime(events,day)
  	secheck = {}
  	secheck["s"] = 1
  	newevents = []
  	newevents.push({:title => "Free Time", 
            :start => Chronic.parse("this week's " + parseDate(day) + " at " + "8:00"), 
            :end => Chronic.parse("this week's " + parseDate(day) + " at " + events[0].time), 
            :allDay => false,
            :color => "#00AA72"})

  	newstart = ""
  	for i in 1..(events.length - 1) 
  		if (events[i].flag == "s")
  			secheck["s"] += 1
  			if (secheck["s"] == 1)
  				newevents.push({:title => "Free Time", 
            :start => Chronic.parse("this week's " + parseDate(day) + " at " + newstart), 
            :end => Chronic.parse("this week's " + parseDate(day) + " at " + events[i].time), 
            :allDay => false,
            :color => "#00AA72"})
  			end	
  		else
  			secheck["s"] -= 1
  		end

  		if (secheck["s"] == 0)
  			newstart = events[i].time
  		end
  	end		

  	newevents.push({:title => "Free Time", 
            :start => Chronic.parse("this week's " + parseDate(day) + " at " + events[events.length - 1].time), 
            :end => Chronic.parse("this week's " + parseDate(day) + " at " + "24:00"), 
            :allDay => false,
            :color => "#00AA72"})

     return newevents
  end

  def tokenizeTime(time)
  	timecopy = time
  	if (timecopy.include?("am"))
  		timecopy.sub!(/am/,"")
  	else

  		timecopy.sub!(/pm/,"") 
  		if (time.split(":")[0].to_i != 12)
  			prefix = time.split(":")[0].to_i + 12
  			timecopy.sub!(/^[0-9]*:/,prefix.to_s + ":")
  		else
  		end
  	end
	
	return timecopy
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