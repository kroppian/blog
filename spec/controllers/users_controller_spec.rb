require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do 


  end

  describe "#GET edit" do 
    context "unauthorized request" do

      it "returns a 403 error" do
        @user = build(:user)
        get :edit, id: 1 
      end
    end
  end
end
