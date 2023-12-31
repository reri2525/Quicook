# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def account_activation
        user = User.first
        user.activation_token = User.new_token
        user.activation_digest = User.digest(user.activation_token)
        UserMailer.account_activation(user)
    end
end
