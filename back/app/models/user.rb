class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    has_many :posts, dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                     foreign_key: "followed_id",
                                     dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :hearts, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many :bookmarks_posts, through: :bookmarks, source: :post
    mount_uploader :avatar, AvatarUploader
    validates :name,  presence: true, length: { maximum: 10 }
    validates :introduction,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password  
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
   
    private

     # メールアドレスをすべて小文字にする
     def downcase_email
       self.email = email.downcase
     end
end

