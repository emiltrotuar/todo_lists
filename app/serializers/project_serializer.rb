class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :tasks

  def id
    object.id.to_s
  end

  def tasks
    object.tasks.map do |task|
      task.id = task._id.to_s
      task
    end
  end
end
