class Headquarter
  include MongoMapper::Document

  key :hqname, String
  key :groupscolname, String
  key :userscolname, String
end
