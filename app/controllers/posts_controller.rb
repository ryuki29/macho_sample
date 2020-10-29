class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index] 
  # indexアクション以外はログイン済ユーザーのみにアクセスを許可する
  before_action :set_post, only: [:edit, :show]
  # 共通の処理はこのようにまとめることができる
  def index
    @posts = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private
  def post_params
    params.require(:post).permit(:text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
