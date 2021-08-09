class UsersController < ApplicationController
    before_action :require_no_current_user,only:[:new,:create]
    before_action :require_current_user,only:[:show]
    before_action :require_admin,only: [:index,:admin]

    def index
        render :index
    end

    def admin 
        user = User.find_by(id: params[:id])
        unless user.admin
             user.toggle(:admin) 
             user.save
        end
        redirect_to users_url
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            msg = UserMailer.authentication_mail(@user)
            msg.deliver_now
            flash.now[:errors] = ["Authentication mail has been sent ,please follow the link provided in the mail to complete the authentication process"]
            render :new
        else  
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = current_user
        render :show
    end

    def activate
        @user = User.find_by(activation_token: params[:activation_token])
        unless @user.activated
            @user.toggle(:activated)
            @user.save
            log_in!
            redirect_to bands_url
        end
    end

    private

    def user_params
        params.require(:user).permit(:name,:email,:password)
    end
end