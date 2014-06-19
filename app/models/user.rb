class User
  include Mongoid::Document

  has_many :projects
end
