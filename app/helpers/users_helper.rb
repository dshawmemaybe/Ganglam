module UsersHelper
  def add_schedule_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, "schedule", :partial => 'schedule', :object => Schedule.new
    end
  end

def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
