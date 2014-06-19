class Project
  include Mongoid::Document
  include Mongoid::Orderable

  field :name, type: String
  field :position, type: Integer

  has_many :tasks
  orderable base: 0
  default_scope ->{ order_by(:position.asc) }
end
