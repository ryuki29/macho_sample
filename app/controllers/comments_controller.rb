class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/posts/#{comment.post.id}" #コメントと紐づく投稿の詳細画面に遷移する
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
