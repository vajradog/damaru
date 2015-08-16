class Admin::PagesController < AdminsController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index; end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    set_page_status
    if @page.save
      flash[:success] = "You page was saved"
      redirect_to admin_pages_path
    else
      flash[:error] = "Could not save your page"
      render :new
    end
  end

  def edit; end

  def update
    set_page_status
    if @page.update(page_params)
      flash[:notice] = "page was successfully updated"
      redirect_to admin_pages_path
    else
      flash[:error] = "page was not updated"
      render :edit
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = "page deleted"
    redirect_to admin_pages_path
  end

  private

  def set_page
    @page = Page.find_by(slug: params[:id])
  end

  def set_page_status
    if params[:publish_button]
        @page.status = "published"
    else params[:draft_button]
      @page.status = "draft"
    end
  end

  def page_params
    params.require(:page).permit(:title, :body, :nav, :external_url, :status)
  end
end
