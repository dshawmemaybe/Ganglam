require 'paperclip'

class User
	include MongoMapper::Document
	include Paperclip::Glue

	key :userid, String
	key :firstname, String
	key :lastname, String
	key :email, String
	key :password, String
	key :group_ids, Array
	
	one :schedule
	many :groups, :in => :group_ids

	has_attached_file :avatar, :styles => {:thumb => "35x35#"}

	key :avatar_file_name, String
end
