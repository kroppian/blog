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
        log_in(@admin_user)
        get :index
        
        @articles.each do |expected_art|
          # TODO tidy up 
          expect(assigns(:articles).select {|found_art| found_art[:id] == expected_art.id }.first.id).to eql(expected_art.id)
        end
        log_out
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

    end

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
