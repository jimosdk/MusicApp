# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  activated        :boolean          default(FALSE), not null
#  activation_token :string           not null
#  admin            :boolean          default(FALSE)
#  email            :string           not null
#  name             :string           not null
#  password_digest  :string           not null
#  session_token    :string           not null
#
# Indexes
#
#  index_users_on_activation_token  (activation_token) UNIQUE
#  index_users_on_email             (email) UNIQUE
#  index_users_on_session_token     (session_token) UNIQUE
#
class User < ApplicationRecord

    attr_reader :password

    validates :session_token,:activation_token,:email,presence: true,uniqueness: true
    validates :password_digest,presence:true
    validates :name,presence:true
    validates :password,length: {minimum:6,allow_nil:true}
    after_initialize :ensure_session_token
    after_initialize :ensure_activation_token

    has_many :notes,
        dependent: :destroy

    def self.find_by_credentials(email,password)
        user = User.find_by(email:email)
        user && user.is_password?(password) ? user : nil
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def ensure_session_token
        self.session_token = User.generate_session_token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def ensure_activation_token
        self.activation_token = User.generate_session_token
    end
end
