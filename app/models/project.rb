class Project < ActiveRecord::Base
  attr_accessible :id, :name
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 75 }
  default_scope order: 'projects.position ASC'
  acts_as_list scope: :user
end
