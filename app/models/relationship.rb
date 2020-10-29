class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  # クラスを補足設定することで、
  # Followクラスという存在しないクラすを参照することを防ぎ、
  # Userクラスであることを明示している

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
