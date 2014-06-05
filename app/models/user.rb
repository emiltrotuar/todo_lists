class User
  include Mongoid::Document

  embeds_many :projects
end
