require 'watir-webdriver'
module ApplicationHelper
	def retrieve_html()
		url = "https://ntst.umd.edu/soc/courses.html?term=201308&prefix=CMSC"
	b = Watir::Browser.new :firefox
	b.driver.manage.window.maximize
	b.goto url 
	btn = b.button :value, "Show All Sections"
	btn.click

	return b.html
end
end
