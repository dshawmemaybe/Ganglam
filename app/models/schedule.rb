class Schedule 
	include MongoMapper::EmbeddedDocument

	key :userid, String, :required => true

	many :courses
end
