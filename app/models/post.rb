class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites, dependent: :destroy

  def self.search(search)
    if search != ""
    # 検索フォームに何か値が入力されていた場合
      Post.where('text LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
