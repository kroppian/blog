require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do 

    @normal_user1 = create(:user)    
    @normal_user2 = create(:user, email: "shmoe@yahoo.com")    
      
  end

  describe "#GET edit" do 

    context "user not logged in and tries to edit user" do

      it "returns a 403 error" do
        get :edit, id: 1 
        expect(response.response_code).to eql(403)
      end
    end

    context "user logs in and tries to edit other user" do

      it "returns a 403 error"  do

        log_in(@normal_user1)
        get :edit, id: @normal_user2.id
        expect(response.response_code).to eql(403)
        log_out 

        log_in(@normal_user2)
        get :edit, id: @normal_user1.id
        expect(response.response_code).to eql(403)
        log_out 

      end
      
    end

    context "user logs in and edits his/her own account" do

      it "returns a 200 response"  do

        log_in(@normal_user1)
        get :edit, id: @normal_user1.id
        expect(response.response_code).to eql(200)
        log_out 

        log_in(@normal_user2)
        get :edit, id: @normal_user2.id
        expect(response.response_code).to eql(200)
        log_out 

      end

      it "Offers the correct user to edit"  do

        log_in(@normal_user1)
        get :edit, id: @normal_user1.id
        expect(assigns(:user).id).to eql(@normal_user1.id)
        log_out 


        log_in(@normal_user2)
        get :edit, id: @normal_user2.id
        expect(assigns(:user).id).to eql(@normal_user2.id)
        log_out 

      end
      
    end
  end
end
