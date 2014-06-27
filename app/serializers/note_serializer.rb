class NoteSerializer < ActiveModel::Serializer
  attributes :id, :content

  def id
    object.id.to_s
  end
end
