class Task < ActiveRecord::Base
  attr_accessible :content, :complete, :date, :position
  belongs_to :project
  validates :project_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  default_scope order: 'tasks.position ASC'
end
