require 'rails_helper'

RSpec.describe User, type: :model do

  # TODO should I use 'it_behaves_like? 
  # TODO should I use vcr?

  describe 'user_type value' do 

    context 'a user tries to create a user without a user_type' do 
      it 'it should raise an active record error' do 
        new_user = build(:user, user_type: nil)  
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
    
    context 'a user tries to create a user with an out of range user_type' do 
      it 'it should raise an active record error' do 
        # TODO how can I properly test this if I can't even use FactoryGirl to create
        # and draft user?
        #new_user = build(:user, user_type: 3)   # negative??
        #expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

  end

  describe 'about page' do 

    context 'user tries to create a user with a nil about' do 
      it 'should create the user' do 
        new_user = build(:user, about: nil)
        expect{ new_user.save! }.to change {User.count}
      end
    end

    context 'user tries to create a user with a blank string' do 
      it 'should create the user' do 
        new_user = build(:user, about: '')
        expect{ new_user.save! }.to change {User.count}
      end
    end

    context 'user tries to create a user with a non-zero string' do 
      it 'should create the user' do 
        new_user = build(:user, about: 'I\'m a dude.')
        expect{ new_user.save! }.to change {User.count}
      end
    end

  end

  
  describe 'Name formatting' do 

    context 'user creates a user with a name of length zero' do 
      # TODO what the hell are these? Are they functions?
      it 'should raise an active record error' do 
        new_user = build(:user, name: '')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'user creates a user with a name of nil' do 
      it 'should raise an active record error' do 
        new_user = build(:user, name: nil)
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end 

    context 'user creates a user with a name of one character' do 
      it 'should raise an active record error' do 
        new_user = build(:user, name: 'Q')
        expect{ new_user.save! }.to change {User.count}
      end
    end 

    # TODO unicode character support

  end

  describe 'email uniqueness' do 

    before do
      create(:user, email: 'joe@schmoe.net')
    end


    context 'a user tries to create user with existing email' do 
      it 'should raise an active record error' do
        new_user = build(:user, email: 'joe@schmoe.net')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end 

    context 'a user tries to create a user with unique email' do
      it 'should create the new user' do 
        new_user = build(:user, email: 'howard_schmoe.21@schmoe.net')
        expect{ new_user.save! }.to change {User.count}
      end
    end 

  end

  describe 'email formatting' do 

    context 'a user tries to create a blank user email' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '')
        expect { new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email without an at sign' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'heythere.net')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email without domain type' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'bob@slob')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email with one character local name' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'b@cool.io')
        expect {new_user.save! }.to change {User.count}
      end 
    end 

    context 'a user tries to create a user email with no local name' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '@cool.io')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email with no domain name' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'nobody@')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email with no domain name save a domain type' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'nobody@.net')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email with local name starting with a period' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '.dottydotdot@dot.org')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email with local name end with a period' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'dottydotdot.@dot.org')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'a user tries to create a user email with local name just a period' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '.@dot.org')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

  end 
end 
