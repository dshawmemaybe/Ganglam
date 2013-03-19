require 'paperclip'

class User
	include MongoMapper::Document
	include Paperclip::Glue
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

	attr_accessible :userid, :email, :password, :password_confirmation, :firstname, :lastname, :avatar, :schedule

	key :userid, String, :default => nil
	key :firstname, String
	key :lastname, String
	key :email, String
	key :reset_password_token, String
	key :reset_password_sent_at, Time
	key :remember_created_at, Time
	key :sign_in_count, Integer
	key :password, String
	key :group_ids, Array
	key :failed_attempts, Integer
	key :unlock_token, String
	key :locked_at, Time
	key :encrypted_password, String
	key :current_sign_in_at, Time
	key :last_sign_in_at, Time
	key :current_sign_in_ip, String
	key :last_sign_in_ip, String
	key :password_salt, String
	key :confirmation_token, String
	key :confirmed_at, Time
	key :confirmation_sent_at, Time
	one :schedule
	many :groups, :in => :group_ids

	has_attached_file :avatar, :styles => {:thumb => "35x35#"}, :s3_credentials => S3_CREDENTIAL

	key :avatar_file_name, String
end
