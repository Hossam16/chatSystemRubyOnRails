module Response
    def success_response(object)
      render :json => object, :except => [:id, :application_id, :chat_id], status: :ok
    end
    def faild_response(errors)
        render :json => errors, :except => [:id, :application_id, :chat_id], status: :unprocessable_entity
      end
  end