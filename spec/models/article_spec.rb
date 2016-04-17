require 'rails_helper'

RSpec.describe Article, type: :model do

  describe 'title format' do 

    context 'when Article is proposed with nil title' do 
      it 'should raise an active record error' do 
        new_article = build(:article, title: nil)  
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end

    context 'when Article is proposed with title of length zero' do 
      it 'should raise an active record error' do 
        new_article = build(:article, title: '')  
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end

    context 'when Article is proposed with with title of length of one' do 
      it 'should create the proposed article' do 
        new_article = build(:article, title: 't')  
        expect{ new_article.save! }.to change {Article.count}
      end 
    end

    context 'when Article is proposed with title of length greater than one' do 
      it 'should create the proposed article' do 
        new_article = build(:article, title: 'This is a title')  
        expect{ new_article.save! }.to change {Article.count}
      end 
    end

    context 'when Article is proposed with title of length 120 chars' do 
      it 'should create the proposed article' do 
        new_article = build(:article, title: 'a' * 120)
        expect{ new_article.save! }.to change {Article.count}
      end 
    end

    context 'when Article is proposed with title of length greater than 120 chars' do 
      it 'should create the proposed article' do 
        new_article = build(:article, title: 'a' * 121)
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end


  end

  describe 'text format' do 

    context 'when Article is proposed with nil text' do 
      it 'should raise an active record error' do 
        new_article = build(:article, text: nil)  
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end

    context 'when Article is proposed with text of length zero' do 
      it 'should raise an active record error' do 
        new_article = build(:article, text: '')  
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end

    context 'when Article is proposed with text of length one' do 
      it 'should create the proposed article' do 
        new_article = build(:article, text: 'a')  
        expect{ new_article.save! }.to change {Article.count}
      end 
    end

  end

  describe 'user id' do 

    context 'when Article is proposed with nil user_id' do 
      it 'should raise an active record error' do 
        new_article = build(:article, user_id: nil)  
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end

    context 'when Article is proposed with non-existant user_id' do 
      it 'should raise an active record error' do 
        new_article = build(:article, user_id: -1)  
        expect{ new_article.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end 
    end


    context 'when Article is proposed with existing user_id' do 
      it 'should raise an active record error' do 
        new_article = build(:article)  
        expect{ new_article.save! }.to change {Article.count}
      end 
    end


  end
end
