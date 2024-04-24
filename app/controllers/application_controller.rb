class ApplicationController < ApiController

    include Render

    # GET /application
    def index
        @applications = Application.all
        render json: @applications
    end

    # POST /application
    def create
        @application = Application.new(application_params)
        @application.save
        render_json @application
    end

    # PATCH/PUT /application/:id
    def update
        @application = Application.find_by!(access_token: params[:access_token])
        @application.update(application_params)
        render_json @application
    end

    # GET /application/:id
    def show
        @application = Application.find_by!(access_token: params[:access_token])
        render_json @application
    end

    private
    def application_params
        params.permit(:name)
    end
end
