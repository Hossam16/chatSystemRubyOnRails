class Message < ApplicationRecord
  # Associations
  belongs_to :chat, counter_cache: :messages_count, touch: true

  # Validations
  validates :body, presence: true

  # Callback to set the message number before saving
  before_validation :set_message_number, on: :create

  private
  def set_message_number
    # Get the last message number for the chat and increment it by 1
    last_number = self.chat.messages.maximum(:number) || 0
    self.number = last_number + 1
  end
end