class ChatController < ApiController
    include Response

    before_action :set_application
    before_action :set_chat, only: [:show, :update, :destroy]
  
    # GET /applications/:application_token/chats
    def index
        @chats = @application.chats
        success_response @chats
    end
  
    # GET /applications/:application_token/chats/:id
    def show
        success_response @chat
    end
  
    # POST /applications/:application_token/chats
    def create
      @chat = @application.chats.build(chat_params)
      if @chat.save
        success_response @chat
      else
        faild_response @chat.errors
      end
    end
  
    # PATCH/PUT /applications/:application_token/chats/:id
    def update
      if @chat.update(chat_params)
        success_response @chat
      else
        faild_response @chat.errors
      end
    end
  
    # DELETE /applications/:application_token/chats/:id
    def destroy
      @chat.destroy
    end
  
    private
      def set_application
        @application = Application.find_by!(access_token: params[:application_access_token])
      end
  
      def set_chat
        @chat = @application.chats.find_by!(number: params[:number])
      end
  
      def chat_params
        params.permit(:number)
      end
  end