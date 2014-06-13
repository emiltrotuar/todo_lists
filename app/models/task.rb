class Task
  include Mongoid::Document

  field :name, type: String

  belongs_to :project
end
