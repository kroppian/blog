require 'rails_helper'

RSpec.describe User, type: :model do

  # TODO should I use 'it_behaves_like? 
  # TODO should I use vcr?
  # TODO should I tests updates too? 

  describe 'user_type value' do 

    context 'when a User is proposed without a user_type' do 
      it 'it should raise an active record error' do 
        new_user = build(:user, user_type: nil)  
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
    
    context 'when a User is proposed with an out of range user_type' do 
      it 'it should raise an active record error' do 
        # TODO how can I properly test this if I can't even use FactoryGirl to create
        # and draft user?
        #new_user = build(:user, user_type: 3)   # negative??
        #expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

  end

  describe 'about page' do 

    context 'when a User is proposed with a nil about' do 
      it 'should create the user' do 
        new_user = build(:user, about: nil)
        expect{ new_user.save! }.to change {User.count}
      end
    end

    context 'when a User is proposed with a blank string' do 
      it 'should create the user' do 
        new_user = build(:user, about: '')
        expect{ new_user.save! }.to change {User.count}
      end
    end

    context 'when a User is proposed with a non-zero string' do 
      it 'should create the user' do 
        new_user = build(:user, about: 'I\'m a dude.')
        expect{ new_user.save! }.to change {User.count}
      end
    end

  end

  
  describe 'name formatting' do 

    context 'when a User is proposed with a name of length zero' do 
      # TODO what the hell are these? Are they functions?
      it 'should raise an active record error' do 
        new_user = build(:user, name: '')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when a User is proposed with a name of nil' do 
      it 'should raise an active record error' do 
        new_user = build(:user, name: nil)
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end 

    context 'when a User is proposed with a name of one character' do 
      it 'should create the user correctly' do 
        new_user = build(:user, name: 'Q')
        expect{ new_user.save! }.to change {User.count}
      end
    end 

    # TODO unicode character support

  end

  describe 'password formatting' do 

    context 'when a User is proposed with a nil password' do 
       it 'should raise an active record error' do 
        new_user = build(:user, password: nil, password_confirmation: nil)
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when a User is proposed with a password of length zero' do 
       it 'should raise an active record error' do 
        new_user = build(:user, password: '', password_confirmation: '')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when a User is proposed with a password with a length less than 6' do 
       it 'should raise an active record error' do 
        new_user = build(:user, password: '12345', password_confirmation: '12345')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when a User is proposed with a password with a length of 6' do 
       it 'should create the user correctly' do 
        new_user = build(:user, password: '123456', password_confirmation: '123456')
        expect{ new_user.save! }.to change {User.count}
      end
    end

    context 'when a User is proposed with a password with incorrect password confirmation' do 
       it 'should raise an active record error' do 
        new_user = build(:user, password: '123456', password_confirmation: '223456')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

  end

  describe 'email uniqueness' do 

    before do
      create(:user, email: 'joe@schmoe.net')
    end


    context 'when a User is proposed with existing email' do 
      it 'should raise an active record error' do
        new_user = build(:user, email: 'joe@schmoe.net')
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end 

    context 'when a User is proposed with unique email' do
      it 'should create the new user' do 
        new_user = build(:user, email: 'howard_schmoe.21@schmoe.net')
        expect{ new_user.save! }.to change {User.count}
      end
    end 

  end

  describe 'email formatting' do 

    context 'when a User is proposed with a blank email' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '')
        expect { new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed without an at sign' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'heythere.net')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed without domain type' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'bob@slob')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed with a one character local name' do
      it 'should create the user correctly' do 
        new_user = build(:user, email: 'b@cool.io')
        expect {new_user.save! }.to change {User.count}
      end 
    end 

    context 'when a User is proposed with no local name' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '@cool.io')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed with an email with no domain name' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'nobody@')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed with a user email with no domain name save a domain type' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'nobody@.net')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed with a user email with local name starting with a period' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '.dottydotdot@dot.org')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed with a user email with a local name that ends with a period' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: 'dottydotdot.@dot.org')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

    context 'when a User is proposed with a user email with local name just a period' do
      it 'should raise an active record error' do 
        new_user = build(:user, email: '.@dot.org')
        expect {new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end 

  end 
end 
