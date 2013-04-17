class SearchController < ActionController::Base
  layout :user_layout

 
    def user_layout
     if current_user
        "application"
      else 
       "invite"

      end
    end 

    def index 
      
    end

end