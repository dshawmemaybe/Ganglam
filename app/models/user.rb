class User
	include MongoMapper::Document

	key :userid, String
	key :firstname, String
	key :lastname, String
	key :email, String
	key :password, String
	key :group_ids, Array
	
	one :schedule
	many :groups, :in => :group_ids
end
