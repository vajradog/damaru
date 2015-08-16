class Admin::PostsController < AdminsController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    set_post_status

    if @post.save
      flash[:success] = "You post was saved"
      redirect_to admin_posts_path
    else
      flash[:error] = "Could not save your post"
      render :new
    end
  end

  def edit; end

  def update
    set_post_status
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated"
      redirect_to admin_posts_path
    else
      flash[:error] = "Post was not updated"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"
    redirect_to admin_posts_path
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def set_post_status
    if params[:publish_button]
      if current_user.contributor?
         @post.status = "draft"
      else
        @post.status = "published"
      end
    elsif params[:draft_button]
      @post.status = "draft"
    else
      @post.status
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :status, :user_id)
  end
end
