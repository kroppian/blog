require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:paul)
    @admin_user = users(:admin)
    @number_of_articles = Article.count
  end

  def assert_new_article_button_count(number_of_buttons)
    assert_select 'a[href="/articles/new"]', count: number_of_buttons  
  end

  test "Failed login attempt" do
    user_logs_in("", "")
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert_navbar_good
  end

  test "Successful login attempt for non admin" do
    user_logs_in(@user.name, "lamepassword")
    assert_redirected_to '/articles'
    follow_redirect!
    assert_template 'articles/index'
    assert_logged_in_navbar_good
    # Should have no delete links for articles
    assert_edit_button_count 0
    # Should have no edit links for articles
    assert_delete_button_count 0
    # Should have no create new articles links
    assert_new_article_button_count 0

    assert_admin_flash false
  end

  test "Successful login attempt for admin" do
    user_logs_in(@admin_user.name,"adminpassword")
    assert_redirected_to '/articles'
    follow_redirect!
    assert_template 'articles/index'
    assert_logged_in_navbar_good
    # Should have delete links for articles
    assert_edit_button_count @number_of_articles 
    # Should have edit links for articles
    assert_delete_button_count @number_of_articles 
    # Should have no create new articles links
    assert_new_article_button_count 1 

    assert_admin_flash true
  end


end
