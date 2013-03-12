class Schedule 
	include MongoMapper::EmbeddedDocument

	key :userid, String, :required => true

	embedded_in :user
	many :courses
end
