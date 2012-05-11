require "open-uri"

class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :hates, :dependent => :nullify
  
  has_attached_file :avatar, :url => "/user_avatar/:hash.:extension",
                             :hash_secret => "Hehfj43kf4fFdTPsfght",
                             :styles => { :small => "100x100>" }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  def add_authentication(omniauth)
    auth = Authentication.new(:provider => omniauth['provider'], :uid => omniauth['uid'])
    auth.update_token(omniauth)
    
    self.authentications << auth

    apply_omniauth(omniauth) if self.new_record?
  end
  
  def apply_omniauth(omniauth)
    send("apply_omniauth_#{omniauth['provider']}", omniauth)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def post(message)
    authentications.each do |a|
      a.post(message)
    end
  end

private
  def apply_omniauth_facebook(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?    
  end
  
  def apply_omniauth_twitter(omniauth)
    self.name = omniauth['info']['name']
    self.nickname = omniauth['info']['nickname']
    
    avatar_from_url omniauth['info']['image']
  end
  
  def avatar_from_url(url)
    self.avatar = open(url)
  end
end
