class User < ActiveRecord::Base
  include Gravtastic
  is_gravtastic!
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def username
    m = /(.[^\@]+)/.match(email)
    m[1] unless m.nil?
  end
end
