class SessionsController < ApplicationController

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to :articles
    else
      flash.now[:danger] = 'You fool! Incorrect user name and password!'
      render 'new'
      flash = {}
    end
  end

  def new
    
  end

  def destroy

  end

end
