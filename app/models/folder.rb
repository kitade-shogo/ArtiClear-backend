class Folder < ApplicationRecord
    belongs_to :user
    has_many :bookmarks, dependent: :destroy

    validates :name, presence: true, length: { maximum: 30, minimum: 1 }
end
