class ApplicationController < ApiController
    before_action :set_application, only: [:show, :update, :destroy]
  
    # GET /applications
    def index
      @applications = Application.all
      render json: @applications
    end
  
    # GET /applications/:id
    def show
      render json: @application
    end
  
    # POST /applications
    def create
      @application = Application.new(application_params)
      if @application.save
        render json: @application, status: :created
      else
        render json: @application.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /applications/:id
    def update
      if @application.update(application_params)
        render json: @application
      else
        render json: @application.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /applications/:id
    def destroy
      @application.destroy
    end
  
    private
      def set_application
        @application = Application.find_by!(access_token: params[:access_token])
      end
  
      def application_params
        params.permit(:name)
      end
end
  
