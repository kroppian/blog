class SessionsController < ApplicationController

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      redirect_to :articles
    else
      flash[:danger] = 'Wrong username/password foo!'
      render 'new'
      flash = {}
    end
  end

  def new
    
  end

  def destroy

  end

end
