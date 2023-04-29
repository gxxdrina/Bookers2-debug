class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :user_id
  #同じユーザーが同じ本に対して複数のコメントを投稿できない(一意性をチェック)
    
end
