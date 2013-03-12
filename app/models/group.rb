class Group
	include MongoMapper::Document

	key :groupid, String
	key :user_ids, Array
	key :public, Boolean

	many :users, :in => :user_ids
	
end
