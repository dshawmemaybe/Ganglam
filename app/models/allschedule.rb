class Allschedule 
	include MongoMapper::Document

	key :userid, String, :required => true

	many :courses
end
