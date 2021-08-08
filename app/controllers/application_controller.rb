class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        return nil unless session[:session_token]
        User.find_by(session_token: session[:session_token])
    end

    def log_in!
        session[:session_token] = @user.reset_session_token!
    end

    def log_out!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def require_current_user
        redirect_to new_session_url unless current_user
    end

    def require_no_current_user
        redirect_to user_url(current_user) if current_user
    end

    def require_activation
        @user = User.find_by_credentials(params[:session][:email],
                                        params[:session][:password])
        unless @user.activated
            flash.now[:errors] = ["Authentication mail has been sent ,please follow the link provided in the mail to complete the authentication process"]
            render :new 
        end
    end
end
