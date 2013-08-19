class Task < ActiveRecord::Base
  attr_accessible :content, :complete, :date
  belongs_to :project

  validates :project_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
