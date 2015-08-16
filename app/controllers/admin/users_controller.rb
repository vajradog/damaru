class Admin::UsersController < AdminsController
  before_action :set_user, only: [:edit, :update, :show]
  #before_filter :check_permission, except: [:show, :new]

  def index; end

  def new
      @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User created"
      redirect_to admin_users_path
    else
      flash[:alert] = "Could not create user"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated"
      redirect_to admin_users_path
    else
      flash[:alert] = "could not update"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Post deleted"
    redirect_to admin_users_path
  end


  #def update_roles
#    params[:users].each do |user_data|
#      user = User.find_by(slug: params[:id])
#      user.update_column('role')
#    end
#      redirect_to admin_users_path#

#  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    if current_user.admin?
      params.require(:user).permit(:email, :display_name, :password, :role)
    else
       params.require(:user).permit(:email, :display_name, :password)
     end
  end

  def check_permission
    unless current_user.admin? || current_user == @user
      flash[:error]="Not allowed to do that"
      redirect_to root_path
    end
  end
end
