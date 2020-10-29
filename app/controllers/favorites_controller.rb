class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    # こう記述することで、「current_userに関連したFavoriteクラスの新しいインスタンス」が作成可能
    # つまり、favorite.user_id = current_user.idが進んだ状態で生成されている
    # buildはnewと同じ意味で、アソシエーションしながらインスタンスをnewするときに形式的に使われる。

    favorite = current_user.favorites.build(post_id: params[:post_id])
    # URIに:post_idが含まれており、post_favorites_path(post.id)と引数でpostのidを送ってあるので、params[:post_id]とすればお気に入り登録しようとしているツイートのidが取得できる
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
  end
end
