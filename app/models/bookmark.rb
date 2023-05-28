class Bookmark < ApplicationRecord
    belongs_to :user
    belongs_to :folder

    validates :url, presence: true, length: { minimum: 12, maximum: 2083 }, format: { with: URI::regexp(['http', 'https']), message: 'URLの形式が正しくありません' }
    validates :title, presence: true, length: { minimum: 1, maximum: 255 }
    validates :description, length: { maximum: 255 }
end
