class User < ApplicationRecord
    validates :uid, presence: true, uniqueness: true
    has_many :folders, dependent: :destroy
end
