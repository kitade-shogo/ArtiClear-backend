class UserSerializer 
  include JSONAPI::Serializer
  attributes :uid
  
  has_many :folders
end