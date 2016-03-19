class SessionsController < ApplicationController

  def create

    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to :articles
    else
      flash.now[:danger] = 'You fool! Incorrect email and password!'
      render 'new'
      flash = {}
    end
  end

  def new
    
  end

  def destroy

    log_out
    redirect_to root_url

  end

end
