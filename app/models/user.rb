class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :comments
  has_many :favorites
  has_many :relationships
  # has_many :relationships, foreign_key: 'user_id'という意味
  # user_idを入り口として、relationshipsテーブルという家に「おじゃましまぁ〜す」と入って、follow_idという出口(=source: :follow)から出て、followingsテーブルからフォローしている人のデータを取ってくるイメージ
  # foregin_key = 入り口
  # source = 出口
  has_many :followings, through: :relationships, source: :follow
  # followingsは架空のクラス名
  # throughは中間テーブルを設定している
  # source: :followはこれは
  # 「relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスしてね」ということ
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # 逆方向という意味
  # class_nameはrelationsipモデルのことと設定してあげる
  # foreign_key: 'follow_id'は「relationshipsテーブルにアクセスするとき、follow_idを入り口としてきてね」という意味
  has_many :followers, through: :reverse_of_relationships, source: :user
  # followersも架空のクラス
  # through: :reverse_of_relationshipsで中間テーブルを指定し、
  # source: :userで「出口はuser_idね！それでuserテーブルから自分をフォローしているuserを取ってきてね！」と設定している

  def follow(other_user)
    unless self == other_user
    # フォローしようとしているother_userが自分自身ではないかを検証している
    # selfにはuser.follow(other)を実行した時userが代入される
    # つまり、実行したUserのインスタンスがself
      self.relationships.find_or_create_by(follow_id: other_user.id)
      # 既にフォローされている場合にフォローが重複して保存されることがなくなる
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
    # relationshipが存在すればdestroyする
  end

  def following?(other_user)
    self.followings.include?(other_user)
    # フォローしているUser達を取得し、include?(other_user)によって
    # other_userが含まれていないかを確認している
    # 含まれている場合にはtrueを返し、含まれていない場合にはfalseを返す
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
