class User < ActiveRecord::Base
  has_one :schedule
  belongs_to :group
end