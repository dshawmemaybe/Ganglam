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
      @search = params[:searchbar]

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @search }
    end
    end

end