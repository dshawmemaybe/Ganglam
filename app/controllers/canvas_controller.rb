require 'event'
class CanvasController < ActionController::Base
  layout :user_layout

 
    def user_layout
     if current_user
        "application"
      else 
       "invite"

      end
    end 

  def canvas
    @tests = [1,2,3,4]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tests }
    end
  end
end