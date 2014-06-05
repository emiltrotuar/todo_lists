class Project
  include Mongoid::Document

  field :name, type: String

  embeds_many :tasks
end
