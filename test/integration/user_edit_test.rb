require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:paul)
    @admin_user = users(:admin)
    @number_of_articles = Article.count
  end

  test "If not logged in, should not have access to edit user passwords" do

    get "/users/" + @user.id.to_s + "/edit"
    assert_response 403

  end 

  test "If logged in, user should only have access their own account" do 

    user_logs_in(@admin_user.email, "adminpassword")
    get "/users/" + @user.id.to_s + "/edit"
    assert_response 403
    user_logs_out 

    user_logs_in(@user.email, "lamepassword")
    get "/users/" + @admin_user.id.to_s + "/edit"
    assert_response 403
    user_logs_out 

  end

  test "If logged in, user should have access to their own account" do 

    user_logs_in(@admin_user.email, "adminpassword")
    get "/users/" + @admin_user.id.to_s + "/edit"
    assert_response 200
    assert_template 'users/edit'

  end

end

