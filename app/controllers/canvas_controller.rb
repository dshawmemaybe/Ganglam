require 'event'
require 'stop'
class CanvasController < ActionController::Base
  layout :user_layout
  $count = 0
  $defaultColors = ["#3a87ad","#F5A51B","#F51B1B","#B01BF5","#9E9E9E"]

  def intersecting(group,day,min)
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

    return findtime(events,day,min)
  end

  def findtime(events,day,min)
    count = 0
    secheck = {}
    secheck["s"] = 1
    newevents = []
    if (timedist("8:00",events[0].time) >= min.to_i)
    newevents.push({:title => "", 
            :start => Chronic.parse("this week's " + parseDate(day) + " at " + "8:00"), 
            :end => Chronic.parse("this week's " + parseDate(day) + " at " + events[0].time), 
            :allDay => false,
            :color => "#00AA72",
            :className => "freetime",
            :id => "freetime" + count.to_s})
    count += 1
    end
    newstart = ""
    for i in 1..(events.length - 1) 
      if (events[i].flag == "s")
        secheck["s"] += 1
        if (secheck["s"] == 1)
          if (timedist(newstart,events[i].time) >= min.to_i)
          newevents.push({:title => "", 
            :start => Chronic.parse("this week's " + parseDate(day) + " at " + newstart), 
            :end => Chronic.parse("this week's " + parseDate(day) + " at " + events[i].time), 
            :allDay => false,
            :color => "#00AA72",
            :className => "freetime",
            :id => "freetime" + count.to_s})
          count += 1
          end
        end 
      else
        secheck["s"] -= 1
      end

      if (secheck["s"] == 0)
        newstart = events[i].time
      end
    end   
    if (timedist(events[events.length - 1].time,"24:00") >= min.to_i)
    newevents.push({:title => "", 
            :start => Chronic.parse("this week's " + parseDate(day) + " at " + events[events.length - 1].time), 
            :end => Chronic.parse("this week's " + parseDate(day) + " at " + "24:00"), 
            :allDay => false,
            :color => "#00AA72",
            :className => "freetime",
            :id => "freetime" + count.to_s})
    end
     return newevents
  end

  def timedist(time1, time2)
    pre1 = time1.split(":")[0].to_i
    post1 = time1.split(":")[1].to_i
    pre2 = time2.split(":")[0].to_i
    post2 = time2.split(":")[1].to_i

    return ((pre2 - pre1) * 60) + (post2 - post1)
  end

  def tokenizeTime(time)
    timecopy = time
    if (timecopy.include?("am"))
      timecopy.sub!(/am/,"")
    elsif (timecopy.include?("pm"))

      timecopy.sub!(/pm/,"") 
      if (time.split(":")[0].to_i != 12)
        prefix = time.split(":")[0].to_i + 12
        timecopy.sub!(/^[0-9]*:/,prefix.to_s + ":")
      else
      end
    elsif (timecopy.include?("AM"))
      timecopy.sub!(/:00 AM/,"");
    else 
      timecopy.sub!(/:00 PM/,"");
      prefix = time.split(":")[0].to_i + 12
        timecopy.sub!(/^[0-9]*:/,prefix.to_s + ":")
    end
  
  return timecopy
  end

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
 
  def parseDateNum(day)
    if (day == "1")
      return "monday"
    elsif (day == "2")
      return "tuesday"
    elsif (day == "3")
      return "wednesday"
    elsif (day == "4")
      return "thursday"
    else 
      return "friday"   
    end
  end

  def unparseday(day)
    if (day == "monday")
      return "M"
    elsif (day == "tuesday")
      return "Tu"
    elsif (day == "wednesday")
      return "W"
    elsif (day == "thursday")
      return "Th"
    else 
      return "F"   
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
    if (params[:privates] == "true")
       @events = []
      @selecteduser = User.where(:email => params[:email].to_s).first
      @selecteduser.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
          if (c.credits == nil || c.credits < 1)
            editable = true
           else
           editable = false
           end 
          @events.push({:title => "", 
            :start => Chronic.parse("this week's " + parseDate(x) + " at " + c.starttime[i]).to_s.sub(/-0400/, ""), 
            :end => Chronic.parse("this week's " + parseDate(x) + " at " + c.endtime[i]).to_s.sub(/-0400/, ""), 
            :allDay => false,
            :editable => false,
            :color => "#000000",
            :name => @selecteduser.firstname + " " + @selecteduser.lastname})
        }
      }
    }
    else 
    if (params[:redrop] == "true")
      desiredcourse = Course.new
      current_user.schedule.courses.each { |c|
        if (c.name == params[:event])
          desiredcourse = c
         end 
      } 
      desiredcourse.endtime.clear
      desiredcourse.endtime.push(params[:newend])
      desiredcourse.starttime.clear
      desiredcourse.starttime.push(params[:newstart])
      desiredcourse.day.clear
      desiredcourse.day.push(unparseday(parseDateNum(params[:newday])))
      current_user.save

    else  
    if (params[:resize] == "true")
      desiredcourse = Course.new
      current_user.schedule.courses.each { |c|
        if (c.name == params[:event])
          desiredcourse = c
         end 
      } 
      desiredcourse.endtime.clear
      desiredcourse.endtime.push(params[:newend])
      current_user.save
    else
    if (params[:addevent] == "true")
      @events = []
    @selecteduser = current_user
          @events.push({:title => params[:eventtitle], 
            :start => Chronic.parse("this week's " + parseDateNum(params[:eventday]) + " at " + params[:eventstart]),
            :end => Chronic.parse("this week's " + parseDateNum(params[:eventday]) + " at " + params[:eventend]),
            :allDay => false,
            :editable => true,
            :name => @selecteduser.firstname + " " + @selecteduser.lastname })

         newcourse = Course.new
         newcourse.name = params[:eventtitle]
         newcourse.day.push(unparseday(parseDateNum(params[:eventday])))
         newcourse.starttime.push(params[:eventstart])
         newcourse.endtime.push(params[:eventend])
         @selecteduser.schedule.courses.push(newcourse)
         @selecteduser.save
    else  
    if (params[:freetime] == "true")
      @events = intersecting(@group, params[:day], params[:min])
     else 

    if (params[:overlay] == "true")
      $count = 0
      users = Group.where(:groupid => @group).first.user_ids
      @events = []
      users.each_with_index {|user, color|
      User.where(:email => user).first.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
          if (c.credits == nil || c.credits < 1)
            editable = true
           else
           editable = false
           end 
          @events.push({:title => c.name, 
            :start => Chronic.parse("this week's " + parseDate(x) + " at " + c.starttime[i]).to_s.sub(/-0400/, ""), 
            :end => Chronic.parse("this week's " + parseDate(x) + " at " + c.endtime[i]).to_s.sub(/-0400/, ""), 
            :allDay => false,
            :editable => editable,
            :color => $defaultColors[color],
            :name => User.where(:email => user).first.firstname + " " + User.where(:email => user).first.lastname})
        }
      }
    }
  }
    else
    if ((params[:next] == nil || params[:next] == "false") && (params[:group] == nil || params[:group] == "")) 
    @events = []
    @selecteduser = current_user
    current_user.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
          if (c.credits == nil || c.credits < 1)
            editable = true
           else
           editable = false
           end 
          @events.push({:title => c.name, 
            :start => Chronic.parse("this week's " + parseDate(x) + " at " + c.starttime[i]).to_s.sub(/-0400/, ""), 
            :end => Chronic.parse("this week's " + parseDate(x) + " at " + c.endtime[i]).to_s.sub(/-0400/, ""), 
            :allDay => false,
            :editable => editable,
            :name => @selecteduser.firstname + " " + @selecteduser.lastname})
        }
      }
    }
    else 
      if (params[:next] == "true")
      $count += 1
      elsif (params[:next] == "back")
      $count -= 1
      else
      $count = 0
      end

    if (params[:next] != nil && params[:next] )
      users = Group.where(:groupid => @group).first.user_ids
    end  
      if ($count >= users.length)
          $count = 0
      elsif ($count < 0)
          $count = users.length - 1
      end
      @events = []
      @selecteduser = User.where(:email => users[$count.to_i].to_s).first
      @selecteduser.schedule.courses.each { |c|
      c.day.each_with_index { |d,i|
        separateDays(d).each { |x|
          if (c.credits == nil || c.credits < 1)
            editable = true
           else
           editable = false
           end 
          @events.push({:title => c.name, 
            :start => Chronic.parse("this week's " + parseDate(x) + " at " + c.starttime[i]).to_s.sub(/-0400/, ""), 
            :end => Chronic.parse("this week's " + parseDate(x) + " at " + c.endtime[i]).to_s.sub(/-0400/, ""), 
            :allDay => false,
            :editable => editable,
            :name => @selecteduser.firstname + " " + @selecteduser.lastname})
        }
      }
    }
    end
  end
end
end
end
end
end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end

  end
end