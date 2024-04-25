class MessageController < ApplicationController
    include Response
    include Elasticsearch::Model

    before_action :set_application
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
        success_response @message
      else
        faild_response @message
      end
    end
  
    # PATCH/PUT /applications/:application_token/chats/:chat_id/messages/:id
    def update
      if @message.update(message_params)
        success_response @message
      else
        faild_response @message
      end
    end
  
    # DELETE /applications/:application_token/chats/:chat_id/messages/:id
    def destroy
      @message.destroy
    end

    def search
      success_response  Message.__elasticsearch__.search('{"query": {"bool": {"filter": [{ "regexp": { "body": ".*'+ params[:keyword] +'.*"   }},{ "term": { "chat_id": "' + (@chat.id).to_s  + '" }}]}},"_source": {"includes": [ "body","number" ]}}')
    end
  
    private
      def set_application
        @application = Application.find_by!(access_token: params[:application_access_token])
      end

      def set_chat
        @chat = @application.chats.find_by!(number: params[:chat_number])
      end
  
      def set_message
        @message = @chat.messages.find_by!(number: params[:number])
      end
  
      def message_params
        params.permit(:body)
      end
  end