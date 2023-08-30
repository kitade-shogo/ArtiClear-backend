class FolderSerializer
  include JSONAPI::Serializer
  attributes :name

  belongs_to :user
end
