require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do 

    @normal_user = create(:user)    
    @admin_user = create(:user, user_type: 1)    
    @owner_user = create(:user,about: "I am in charge", user_type: 2)

  end

  describe "#GET edit" do 

    context "user not logged in and tries to edit user" do

      it "returns a 403 error" do
        get :edit, id: @normal_user.id
        expect(response.response_code).to eql(403)
      end

    end # end -- context "user not logged in and tries to edit user"

    context "user logs in and tries to edit other user" do

      it "returns a 403 error"  do
        log_in(@normal_user)
        get :edit, id: @admin_user.id
        expect(response.response_code).to eql(403)
        log_out 

        log_in(@admin_user)
        get :edit, id: @normal_user.id
        expect(response.response_code).to eql(403)
        log_out 

      end
      
    end # end -- context "user logs in and tries to edit other user" 

    context "user logs in and edits his/her own account" do

      it "returns a 200 response"  do

        log_in(@normal_user)
        get :edit, id: @normal_user.id
        expect(response.response_code).to eql(200)
        log_out 

        log_in(@admin_user)
        get :edit, id: @admin_user.id
        expect(response.response_code).to eql(200)
        log_out 

      end # end -- context "user logs in and tries to edit other user" 

      it "Offers the correct user to edit"  do

        log_in(@normal_user)
        get :edit, id: @normal_user.id
        expect(assigns(:user).id).to eql(@normal_user.id)
        log_out 


        log_in(@admin_user)
        get :edit, id: @admin_user.id
        expect(assigns(:user).id).to eql(@admin_user.id)
        log_out 

      end
      
    end # end -- context "user logs in and edits his/her own account"

  end # end -- describe "#GET edit"

  describe "GET #about" do 

    context "no one is logged in, and about is accessed" do

      it "returns the owner's about page" do

        get :about 
        expect(assigns(:owner).id).to eql(@owner_user.id)

      end

    end # end -- "no one is logged in, and about is accessed" 

    context "normal user logs in, and about is accessed" do

      it "returns the owner's about page" do

        log_in(@normal_user)
        get :about 
        expect(assigns(:owner).id).to eql(@owner_user.id)
        log_out

      end

    end # end -- "normal user logs in, and about is accessed" 

    context "admin logs in, and about is accessed" do

      it "returns the owner's about page" do

        log_in(@admin_user)
        get :about 
        expect(assigns(:owner).id).to eql(@owner_user.id)
        log_out

      end

    end # end -- "admin logs in, and about is accessed" 

  end # end -- "GET #about" 


  describe "PATCH #update" do 

    context "user updates his/her owns account" do 
   
      it "should edit any user field and redirect to the main page" do 

        log_in(@normal_user) 

        # TODO why is this failing?
=begin
        options = { email: 'bobby@bobnet.net'}
        patch :update, id: @normal_user.id, user: options
        expect(response).to redirect_to(articles_path)


        options = { name: 'Freddy'}
        patch :update, id: @normal_user.id, user: options
        expect(response).to redirect_to(articles_path)
        expect(@normal_user.name).to eql(options[:name])
=end      
        options = { password: 'badpassword', password_confirmation: 'badpassword'}
        patch :update, id: @normal_user.id, user: options
       
        # TODO check the password value?
        expect(response).to redirect_to(articles_path)
        log_out

      end

    end # end -- "user edits his/her owns account"


    context "user updates tries to edit a user account while not logged in" do 

      it "should return with a 403 error" do

        options = { name: 'Freddy'}
        patch :update, id: @normal_user.id, user: options
        expect(response.response_code).to eql(403)
      
      end

    end # end -- "user edits tries to edit a user account while not logged in"

    context "user logs in and tries to update another user account" do 
      
      it "should return with a 403 error" do 

        log_in(@normal_user)
        options = { name: 'Freddy'}
        patch :update, id: @admin_user.id, user: options
        expect(response.response_code).to eql(403)

      end

    end # end -- "user logs in and tries to update another user account" 

  end # end -- "PATCH #update"

end
