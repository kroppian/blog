module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def is_admin?
    # TODO why did user_type return a string?? I thought it was an enum...
    (not current_user.nil? ) && (["admin", "owner"].include? User.find_by(id: session[:user_id]).user_type )
  end

  def current_user_id? ( id_in_question )
    (not current_user.nil? )  && (User.find_by(id: session[:user_id]).id.to_i ==  id_in_question.to_i)
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
