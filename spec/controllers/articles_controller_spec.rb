require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  let(:article) { article.create(title: 'Assignment', text:'blah blah') }

  before do 

    @normal_user = create(:user)    
    @admin_user = create(:user, user_type: 1)    
    @owner_user = create(:user, user_type: 2)
    @articles = []
    10.times {
      @articles.push create(:article)
    }

  end
 
  describe 'GET #show' do

    context 'user not logged in and tries to view article' do
      it 'Article should be displayed' do
        get :show, id: @articles.first.id 
        expect(assigns(:article).id).to eql(@articles.first.id)
        expect(response.response_code).to eql(200)
      end
    end  

    context 'non-admin user logs in and tries to view article' do
      it 'Article should be displayed' do
        log_in(@normal_user)
        get :show, id: @articles.first.id 
        expect(assigns(:article).id).to eql(@articles.first.id)
        expect(response.response_code).to eql(200)
        log_out
      end
    end  

    context 'admin user logs in and tries to view article' do
      it 'Article should be displayed' do
        log_in(@admin_user)
        get :show, id: @articles.first.id 
        expect(assigns(:article).id).to eql(@articles.first.id)
        expect(response.response_code).to eql(200)
        log_out
      end
    end  

  end 

  describe 'GET #index' do

    context 'user not logged in and tries to view article' do
      it 'Articles should be returned' do
        get :index
        @articles.each do |expected_art|
          # TODO tidy up 
          expect(assigns(:articles).select {|found_art| found_art[:id] == expected_art.id }.first.id).to eql(expected_art.id)
        end
      end
    end  

    context 'user logs in and tries to view article' do
      it 'Articles should be returned' do
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

  describe 'GET #new' do

    context 'user not logged in and tries to access new article page' do
      it 'returns a 403 error' do
        get :new
        expect(response.response_code).to eql(403)
        expect(assigns(:article)).to eql(nil)
      end
    end 

    context 'non-admin user logged in and tires to access new article page' do
      it 'returns a 403 error' do
        log_in(@normal_user)
        get :new
        expect(response.response_code).to eql(403)
        expect(assigns(:article)).to eql(nil)
        log_out
      end
    end 

    context 'admin user logged in and tires to access new article page' do
      it 'returns a 200 successful' do
        log_in(@admin_user)
        get :new
        expect(response.response_code).to eql(200)
        expect(assigns(:article).class).to eql(Article)
        log_out
      end
    end 

    context 'owern logged in and tires to access new article page' do
      it 'returns a 200 successful' do
        log_in(@owner_user)
        get :new
        expect(response.response_code).to eql(200)
        expect(assigns(:article).class).to eql(Article)
        log_out
      end
    end 

  end 

  describe 'GET #edit' do

    context 'user not logged in and tires to access edit article page' do
      it 'returns a 403 error' do
        @articles.each do |art| 
          get :edit, id: art.id
          expect(response.response_code).to eql(403)
          expect(assigns(:article)).to eql(nil)
        end
      end
    end 

    context 'non-admin user tires to access edit article page' do
      it 'returns a 403 error' do
        log_in @normal_user
        @articles.each do |art| 
          get :edit, id: art.id
          expect(response.response_code).to eql(403)
          expect(assigns(:article)).to eql(nil)
        end
        log_out
      end
    end 

    context 'admin user tires to access edit article page' do
      it 'returns a 200 error' do
        log_in @admin_user
        @articles.each do |art| 
          get :edit, id: art.id
          expect(response.response_code).to eql(200)
          expect(assigns(:article)).to eql(art)
        end
        log_out
      end
    end 

    context 'owner tires to access edit article page' do
      it 'returns a 200 error' do
        log_in @admin_user
        @articles.each do |art| 
          get :edit, id: art.id
          expect(response.response_code).to eql(200)
          expect(assigns(:article)).to eql(art)
        end
        log_out
      end
    end 

  end 

  describe 'POST #create' do

    context 'A non logged in user tries to create an article'  do 
      it 'Does not update the article model' do
        expect do 
          post :create, article: attributes_for(:article)
        end.to_not change {Article.count}
      end
    end

    context 'A non-admin in user tries to create an article'  do 
      it 'Does not update the article model' do
        log_in @normal_user
        expect do 
          post :create, article: attributes_for(:article)
        end.to_not change {Article.count}
      end
    end

    context 'An admin in user tries to create an article'  do 
      it 'Does not update the article model' do
        log_in @admin_user
        expect do 
          post :create, article: attributes_for(:article)
        end.to change {Article.count}
      end
    end

    context 'The owner tries to create an article'  do 
      it 'Does not update the article model' do
        log_in @owner_user
        expect do 
          post :create, article: attributes_for(:article)
        end.to change {Article.count}
      end

    end

  end

  describe 'PATCH #update' do

    # TODO complete me

  end

  describe 'POST #delete' do

    context 'A non logged in user tries to create an article'  do 
      it 'Does not update the article model' do
        expect do 
          post :create, article: attributes_for(:article)
        end.to_not change {Article.count}
      end
    end

    context 'A non-admin in user tries to create an article'  do 
      it 'Does not update the article model' do
        log_in @normal_user
        expect do 
          post :create, article: attributes_for(:article)
        end.to_not change {Article.count}
      end
    end

    context 'An admin in user tries to create an article'  do 
      it 'Does not update the article model' do
        log_in @admin_user
        expect do 
          post :create, article: attributes_for(:article)
        end.to change {Article.count}
      end
    end

    context 'The owner tries to create an article'  do 
      it 'Does not update the article model' do
        log_in @owner_user
        expect do 
          post :create, article: attributes_for(:article)
        end.to change {Article.count}
      end

    end
    
  end

end
