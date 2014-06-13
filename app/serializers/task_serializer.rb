class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :project

  def id
    object.id.to_s
  end

  def project
    object.project_id.to_s
  end
end
