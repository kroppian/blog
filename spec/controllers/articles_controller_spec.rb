require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  before do 

    @normal_user = create(:user)    
    @admin_user = create(:user, user_type: 1)    
    @owner_user = create(:user, user_type: 2)
    @article = create(:article)

  end
 
  describe "GET #show" do

    context "user not logged in and tries to view article" do

      it "does something" do
      end

    end  

  end

  describe "GET #index" do

  end

  describe "GET #new" do

  end

  describe "GET #edit" do

  end

  describe "POST #create" do

  end

  describe "PATCH #update" do

  end

  describe "POST #delete" do

  end

end
