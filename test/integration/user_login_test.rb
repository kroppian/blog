require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:paul)
    @admin_user = users(:admin)
    @number_of_articles = Article.count
  end

  def assert_edit_button_count(number_of_buttons)
    assert_select 'a[data-method=delete][href^="/articles"]', count: number_of_buttons  
  end

  def assert_delete_button_count(number_of_buttons)
    assert_select 'a[href^="/articles"][href$="edit"]', count: number_of_buttons  
  end

  def assert_logged_in
    assert_select "a[href=?]", logout_path, count: 1 
  end

  def user_logs_in(user_name, password)
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {name: user_name, password: password}

  end

  test "Failed login attempt" do
    user_logs_in("", "")
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  
  test "Successful login attempt for non admin" do
    user_logs_in(@user.name, "badpassword")
    assert_redirected_to '/articles'
    follow_redirect!
    assert_template 'articles/index'
    assert_logged_in
    # Should have no delete links for articles
    assert_edit_button_count 0
    # Should have no edit links for articles
    assert_delete_button_count 0
  end

  test "Successful login attempt for admin" do
    user_logs_in(@admin_user.name,"adminpassword")
    assert_redirected_to '/articles'
    follow_redirect!
    assert_template 'articles/index'
    assert_logged_in
    # Should have delete links for articles
    assert_edit_button_count @number_of_articles 
    # Should have edit links for articles
    assert_delete_button_count @number_of_articles 

  end


end
