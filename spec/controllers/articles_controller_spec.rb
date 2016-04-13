require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  before do 

    @normal_user = create(:user)    
    @admin_user = create(:user, user_type: 1)    
    @owner_user = create(:user, user_type: 2)
    @articles = []
    10.times {
      @articles.push create(:article)
    }

  end
 
  describe "GET #show" do

    context "user not logged in and tries to view article" do

      it "Article should be displayed" do
        get :show, id: @articles.first.id 
        expect(assigns(:article).id).to eql(@articles.first.id)
        expect(response.response_code).to eql(200)

      end

    end  

    context "user logs in and tries to view article" do

      it "Article should be displayed" do
        log_in(@admin_user)
        get :show, id: @articles.first.id 
        expect(assigns(:article).id).to eql(@articles.first.id)
        expect(response.response_code).to eql(200)
        log_out
      end

    end  

  end # end -- describe "GET #show"

  describe "GET #index" do

    context "user not logged in and tries to view article" do

      it "Articles should be returned" do
        get :index
        
        @articles.each do |expected_art|
          # TODO tidy up 
          expect(assigns(:articles).select {|found_art| found_art[:id] == expected_art.id }.first.id).to eql(expected_art.id)
        end
      end

    end  

    context "user logs in and tries to view article" do

      it "Articles should be returned" do
        log_in(@admin_user)
        get :index
        
        @articles.each do |expected_art|
          # TODO tidy up 
          expect(assigns(:articles).select {|found_art| found_art[:id] == expected_art.id }.first.id).to eql(expected_art.id)
        end
        log_out
      end

    end  

  end

  describe "GET #new" do

    context "user not logged in and tires to access new article page" do

      it "returns a 403 error" do

        get :new
        expect(response.response_code).to eql(403)

      end

    end # end -- user not logged in and tires to access new article page

    context "non-admin user logged in and tires to access new article page" do

      it "returns a 403 error" do

        log_in(@normal_user)
        get :new
        expect(response.response_code).to eql(403)
        log_out

      end

    end # end -- non-admin user logged in and tires to access new article page

    context "admin user logged in and tires to access new article page" do

      it "returns a 200 successful" do

        log_in(@admin_user)
        get :new
        expect(response.response_code).to eql(200)
        log_out

      end

    end # end -- admin user logged in and tires to access new article page

    context "owern logged in and tires to access new article page" do

      it "returns a 200 successful" do

        log_in(@owner_user)
        get :new
        expect(response.response_code).to eql(200)
        log_out

      end

    end # end -- admin user logged in and tires to access new article page

  end # end -- get #new

  describe "GET #edit" do

    context "user not logged in and tires to access edit article page" do

      it "returns a 403 error" do

        @articles.each do |art| 

          get :edit, id: art.id
          expect(response.response_code).to eql(403)

        end

      end

    end # end -- user not logged in and tires to access edit article page

    context "non-admin user tires to access edit article page" do

      it "returns a 403 error" do

        log_in @normal_user

        @articles.each do |art| 

          get :edit, id: art.id
          expect(response.response_code).to eql(403)

        end

        log_out

      end

    end # end -- non-admin user tires to access edit article page

    context "admin user tires to access edit article page" do

      it "returns a 200 error" do

        log_in @admin_user

        @articles.each do |art| 

          get :edit, id: art.id
          expect(response.response_code).to eql(200)

        end

        log_out

      end

    end # end -- admin user tires to access edit article page

    context "owner tires to access edit article page" do

      it "returns a 200 error" do

        log_in @admin_user

        @articles.each do |art| 

          get :edit, id: art.id
          expect(response.response_code).to eql(200)

        end

        log_out

      end

    end # end -- owner tires to access edit article page

  end # end -- GET #edit

  describe "POST #create" do

  end

  describe "PATCH #update" do

  end

  describe "POST #delete" do

  end

end
