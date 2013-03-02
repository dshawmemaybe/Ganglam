class HomeController < ApplicationController

  def index
  	@doc = "lol"
  end

  def scape
	b = Watir::Browser.new :chrome
	b.goto("https://www.sis.umd.edu/testudo/studentSched")
	b.button(:value => "Login with University Directory Login").wait_while_present
	b.button(:value => "Submit").wait_while_present
	@doc = b.html.force_encoding("ISO-8859-1")
	b.close
	redirect_to :back
end

	def get_doc
		return @doc
	end	
end
