class BookmarkSerializer
  include JSONAPI::Serializer
  attributes :url, :title, :description, :created_at

  belongs_to :user
  belongs_to :folder
end
