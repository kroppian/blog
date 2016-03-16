ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def assert_admin_flash(has_flash)
    # there should only be one or zero admin flashes
    assert_select '#admin-flash',count: (has_flash ? 1 : 0)
  end

  def assert_edit_button_count(number_of_buttons)
    assert_select 'a[data-method=delete][href^="/articles"]', count: number_of_buttons  
  end

  def assert_delete_button_count(number_of_buttons)
    assert_select 'a[href^="/articles"][href$="edit"]', count: number_of_buttons  
    assert_navbar_good
  end

  def assert_navbar_good
    # Look for the brand link the top left hand corner
    assert_select 'a[href=?][class=navbar-brand]', articles_path, count: 1
    # Look for the "Home link"
    assert_select 'a[href=?] > span', articles_path, count: 1 
    assert_select 'a[href=?]', about_path, count: 1
  end

  def assert_user_settings_not_present(*uid)
    
    assert_select 'a[href=?]', logout_path, count: 0 
    uid.empty? ? assert_select('a[href^="/users/"][href$="/edit"]', count: 0) : assert_select('a[href=?]', "/users/" + uid.to_s + "/edit", count: 0)

  end

  def assert_user_settings_present(uid )

    assert_select 'a[href=?]', logout_path, count: 1 
    assert_select 'a[href=?]', "/users/" + uid.to_s + "/edit", count: 1
    
  end

  def assert_logged_in_navbar_good
    assert_select "a[href=?]", logout_path, count: 1 
    assert_navbar_good
  end

  def user_logs_in(user_name, password)
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: user_name, password: password}
  end

  def user_logs_out
    delete logout_path      
  end 

end
