class User < ActiveRecord::Base

  validates :name, presence: true, uniqueness: false

  validates :email, presence: true, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def User.digest(string)
  
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)

  end

end
