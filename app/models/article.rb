class Article < ActiveRecord::Base

  belongs_to :user, class_name: User

  # TODO what's the difference between this and 'null: false' in the schema?
  validates :title, presence: true, length: {minimum: 1, maximum: 120}
  
  validates :text, presence: true, length: {minimum: 1}

  validates :user, presence: true

end
