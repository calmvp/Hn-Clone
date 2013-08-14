class Post < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :imageable
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  
end
