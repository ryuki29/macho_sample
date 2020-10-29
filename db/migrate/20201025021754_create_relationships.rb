class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users } #参照先のテーブルを指定

      t.timestamps

      t.index [:user_id, :follow_id], unique: true
      # user_ idとfollow_idのペアで重複するものが保存されないようにするデータベースの設定
    end
  end
end
