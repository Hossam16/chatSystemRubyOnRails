class Application < ApplicationRecord
  has_secure_token :access_token
  # Associations
  has_many :chats, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { in: 1..80 }
end