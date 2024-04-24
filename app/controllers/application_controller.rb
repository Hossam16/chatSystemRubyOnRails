class ApplicationController < ApiController
    include Response
    
    before_action :set_application, only: [:show, :update, :destroy]
  
    # GET /applications
    def index
        @applications = Application.all
        success_response @applications
    end
  
    # GET /applications/:id
    def show
        success_response @application
    end
  
    # POST /applications
    def create
      @application = Application.new(application_params)
      if @application.save
        success_response @application
      else
        faild_response @application.errors
      end
    end
  
    # PATCH/PUT /applications/:id
    def update
      if @application.update(application_params)
        success_response @application
      else
        faild_response @application.errors
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
  
