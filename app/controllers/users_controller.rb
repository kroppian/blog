class UsersController < ApplicationController

  before_action :check_autho, except: [:about]

  def edit 
    @user = User.find(params[:id])
  end

  def about
    @owner = User.owner.first
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :articles  
    else
      render 'edit'
    end
  end

  private 
    
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :about)
    end

    def check_autho
      if not current_user_id?(params[:id])
        render_forbidden
        return
      end
    end

end
