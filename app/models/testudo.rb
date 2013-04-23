class Testudo
  include MongoMapper::Document
  
  key :classid, String
  key :classname, String
  key :credits, Integer
  key :description, String
  key :section, Integer
  key :instructor, String
  key :sectiondays, Array
  key :starttimes, Array
  key :endtimes, Array
  key :building, Array
  key :classroom, Array
end