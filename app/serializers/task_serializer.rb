class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :project
  # attributes :id, :name

  def id
    object.id.to_s
  end

  def project
    object.project_id.to_s
  end
end
