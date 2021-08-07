class UsersController < ApplicationController
    before_action :require_no_current_user,only:[:new,:create]
    before_action :require_current_user,only:[:show]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in!
            redirect_to user_url(@user)
        else  
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = current_user
        render :show
    end


    private

    def user_params
        params.require(:user).permit(:name,:email,:password)
    end
end