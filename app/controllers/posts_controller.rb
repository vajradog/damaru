class PostsController < ApplicationController
   layout "super-simple"

  def index
    if current_user
      redirect_to dashboards_path
    else
      @posts = Post.all.order("created_at desc")
      @users = User.all
    end
  end

  def show
    @post = Post.find_by(slug: params[:id])
  end
end


