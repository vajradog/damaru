class DashboardsController < ApplicationController
  before_filter :require_user

  def index
    if current_user.admin? || current_user.editor?
      @posts = Post.all.order("created_at desc")
    else
      @posts = current_user.posts
    end
    @users = User.all
    @pages = Page.all
    @post = Post.new
  end
end

