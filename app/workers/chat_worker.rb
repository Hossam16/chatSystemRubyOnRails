class ChatWorker
  include Sidekiq::Worker
  sidekiq_options queue: :chat

  def perform(access_token, number)
    application = Application.find_by!(access_token: access_token)
    application.chats.create!(number: number, message_count: 0)
  end

  def perform
    applications = Application.all
    applications.each do |application|
      application.update_column(:chats_count, application.chats.count)
    end
  end
end