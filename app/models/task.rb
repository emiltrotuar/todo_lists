class Task
  include Mongoid::Document
  include Mongoid::Orderable

  field :name,     type: String
  field :position, type: Integer
  field :done,     type: Boolean, default: false

  belongs_to :project
  orderable base: 0
  default_scope ->{ order_by(:position.asc) }
end
