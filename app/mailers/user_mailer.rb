class UserMailer < ApplicationMailer
    default from: "MusicApp@example.com"

    def authentication_mail(user)
        @user = user
        @url = "http://localhost:3000/users/activate?activation_token=#{@user.activation_token}"
        mail(to: @user.email,subject: "email authentication mail")
    end
end
