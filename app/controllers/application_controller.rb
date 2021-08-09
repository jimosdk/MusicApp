class ApplicationController < ActionController::Base
    helper_method :current_user,:admin?

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
        unless @user 
            flash.now[:errors] = ["User not found"]
            render :new
        end
        if @user && !@user.activated
            flash.now[:errors] = ["Authentication mail has been sent ,please follow the link provided in the mail to complete the authentication process"]
            render :new 
        end
    end

    def require_admin
        render plain: "Admin Priviledges required for this action",status: :forbidden unless admin?
    end

    def admin?
        current_user.admin
    end
end
