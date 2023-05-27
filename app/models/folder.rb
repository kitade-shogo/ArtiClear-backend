class Folder < ApplicationRecord
    belongs_to :user

    validates :name, presence: true, length: { maximum: 30, minimum: 1 }
end
