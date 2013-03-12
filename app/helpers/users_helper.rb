module UsersHelper
  def add_schedule_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, "schedule", :partial => 'schedule', :object => Schedule.new
    end
  end

end
