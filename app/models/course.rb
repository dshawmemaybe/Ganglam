class Course 
	include MongoMapper::EmbeddedDocument

	key :name, String, :required => true
	key :section, Integer, :required => true
	key :credits, Integer
	key :building, Array
	key :room, Array
	key :day, Array
	key :starttime, Array
	key :endtime, Array

	embedded_in :user
end
