class Chat < ApplicationRecord
    # Associations
    belongs_to :application, counter_cache: :chats_count, touch: true
    has_many :messages, dependent: :destroy
  
    # Validations
    validates :number,
              presence: true,
              numericality: { only_integer: true, greater_than_or_equal_to: 1 },
              uniqueness: { scope: :application_id }
  end