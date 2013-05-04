require 'event'
class CanvasController < ActionController::Base
  layout :user_layout
  $count = 0
  def separateDays(days)
    return days.split(/(?=[A-Z])/)
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
 
    def user_layout
     if current_user
        "application"
      else 
       "invite"

      end
    end 

  def index
    
    @group = params[:group]

    if ((params[:next] == nil || params[:next] == "false") && (params[:group] == nil || params[:group] == "")) 
    @events = []
    current_user.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
          @events.push({:title => c.name, 
            :start => Chronic.parse("this week's " + parseDate(x) + " at " + c.starttime[i]).to_s.sub(/-0400/, ""), 
            :end => Chronic.parse("this week's " + parseDate(x) + " at " + c.endtime[i]).to_s.sub(/-0400/, ""), 
            :allDay => false})
        }
      }
    }
    else 
      if (params[:next])
      $count += 1
      end

    if (params[:next] != nil && params[:next] )
      users = Group.where(:groupid => @group).first.user_ids
    end  
      if ($count >= users.length)
          $count = 0
      end
      @events = []
      @selecteduser = User.where(:email => users[$count.to_i].to_s).first
      @selecteduser.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
          @events.push({:title => c.name, 
            :start => Chronic.parse("this week's " + parseDate(x) + " at " + c.starttime[i]).to_s.sub(/-0400/, ""), 
            :end => Chronic.parse("this week's " + parseDate(x) + " at " + c.endtime[i]).to_s.sub(/-0400/, ""), 
            :allDay => false})
        }
      }
    }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end

  end
end