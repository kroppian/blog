class UsersController < ApplicationController

  def about
    @owner = User.find_by(name: "admin")
  end

end
