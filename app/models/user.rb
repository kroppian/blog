class User < ActiveRecord::Base

  enum user_type: [ :non_admin, :admin, :owner ]

  validates :name, presence: true, uniqueness: false

  validates :email, presence: true, uniqueness: true

  validates :user_type, presence: true;

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def User.digest(string)
  
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)

  end

end
