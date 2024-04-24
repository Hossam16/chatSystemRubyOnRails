class ChatController < ApiController
    before_action :set_application
    before_action :set_chat, only: [:show, :update, :destroy]
  
    # GET /applications/:application_token/chats
    def index
      @chats = @application.chats
      render json: @chats
    end
  
    # GET /applications/:application_token/chats/:id
    def show
      render json: @chat
    end
  
    # POST /applications/:application_token/chats
    def create
      @chat = @application.chats.build(chat_params)
      if @chat.save
        render json: @chat, status: :created
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /applications/:application_token/chats/:id
    def update
      if @chat.update(chat_params)
        render json: @chat
      else
        render json: @chat.errors, status: :unprocessable_entity
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
        @chat = @application.find_by!(number: params[:number])
      end
  
      def chat_params
        params.permit(:number)
      end
  end