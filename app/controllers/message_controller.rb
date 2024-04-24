class MessageController < ApplicationController
    include Response

    before_action :set_chat
    before_action :set_message, only: [:show, :update, :destroy]
  
    # GET /applications/:application_token/chats/:chat_id/messages
    def index
      @messages = @chat.messages
      success_response @messages
    end
  
    # GET /applications/:application_token/chats/:chat_id/messages/:id
    def show
        success_response @message
    end
  
    # POST /applications/:application_token/chats/:chat_id/messages
    def create
      @message = @chat.messages.build(message_params)
      if @message.save
        success_response @message, status: :created
      else
        faild_response @message.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /applications/:application_token/chats/:chat_id/messages/:id
    def update
      if @message.update(message_params)
        success_response @message
      else
        faild_response @message.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /applications/:application_token/chats/:chat_id/messages/:id
    def destroy
      @message.destroy
    end
  
    private
      def set_chat
        @chat = Chat.find_by!(number: params[:chat_number])
      end
  
      def set_message
        @message = @chat.messages.find_by!(number: params[:number])
      end
  
      def message_params
        params.permit(:body)
      end
  end