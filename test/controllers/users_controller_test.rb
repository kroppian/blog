require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:paul)
    @admin_user = users(:admin)
    @number_of_articles = Article.count
  end

  test "About page should have admin's about" do
    get :about 
    paragraphs = css_select 'p'             

    about_found = ""
    # TODO make this prettier 
    paragraphs.each { | curr_par | 
      if curr_par.inner_html.eql? @admin_user.about
        about_found = curr_par.inner_html
      end
    }  
    assert_equal about_found, @admin_user.about


   
  end
end
