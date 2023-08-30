class User < ApplicationRecord
  has_many :folders, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
end
