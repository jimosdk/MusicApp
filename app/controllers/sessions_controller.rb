class SessionsController < ApplicationController
    before_action :require_no_current_user , only: [:new,:create]
    before_action :require_current_user,only: [:destroy]

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:session][:email],
                                        params[:session][:password])
        if @user 
            log_in!
            redirect_to user_url(@user)
        else   
            flash.now[:errors] = ['User not found']
            render :new
        end
    end

    def destroy
        log_out!
        redirect_to new_session_url
    end
end