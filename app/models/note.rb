class Note
  include Mongoid::Document
  
  attr_accessible :content
  belongs_to :user
end
