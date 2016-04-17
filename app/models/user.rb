class User < ActiveRecord::Base

  has_many :articles

  enum user_type: [ :non_admin, :admin, :owner ]

  validates :name, presence: true, uniqueness: false

  validates :email, presence: true, 
    uniqueness: true,
    format: {with: /\A(\w|\w[\w.]*\w)\@\w+\.\w+\Z/,
      message: "[%{value}] must be in the format username@something.type"}

  validates :user_type, presence: true;

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def User.digest(string)
  
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)

  end

end
