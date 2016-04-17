require 'rails_helper'

RSpec.describe User, type: :model do

  # TODO should I use 'it_behaves_like? 
  # TODO should I use vcr?


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
