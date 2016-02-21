require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:paul)
    @admin_user = users(:admin)
    @number_of_articles = Article.count
  end

  test "Failed login attempt" do
    get login_path
    assert_template 'sessions/new'   
    post login_path, session: {name: "", password: ""}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  
  test "Successful login attempt for non admin" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {name: @user.name, password: "badpassword"}
    assert_redirected_to '/articles'
    follow_redirect!
    assert_template 'articles/index'
    assert_select "a[href=?]", logout_path, count: 1 
    assert_select "a[href$=edit]", count: 0 

    assert_select "a[data-method=delete]", count: 1  
  end

  test "Successful login attempt for admin" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {name: @admin_user.name, password: "adminpassword"}
    assert_redirected_to '/articles'
    follow_redirect!
    assert_template 'articles/index'
    assert_select "a[href=?]", logout_path, count: 1 
    assert_select "a[href$=edit]", minimum: 1 
    # Should be deletes for each article and a delete for the log out
    assert_select "a[data-method=delete]", count: @number_of_articles + 1  
  end


end
