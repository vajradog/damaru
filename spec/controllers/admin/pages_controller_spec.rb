require 'rails_helper'

describe Admin::PagesController do

  describe "GET index" do
    it "when admin or editor, it renders all pages" do
      page = Fabricate(:page)
      user = Fabricate(:user, role: "editor")
      session[:user_id] = user.id
      get :index
      expect(assigns(:pages)).to eq([page])
    end

    it "when not admin, does not render pages" do
      user = Fabricate(:user, role: "author")
      page = Fabricate(:page)
      session[:user_id] = user.id
      get :index
      expect(assigns(:pages)).to eq([])
    end
  end

  describe "GET new" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end

  describe "page create" do
    context "with valid inputs and admin or editor role" do
      before do
        user = Fabricate(:user, role: "editor")
        session[:user_id] = user.id
        post :create, page: { title: "some time", body: "some description", status: "draft"}
      end

      it "creates a new page" do
        expect(Page.count).to eq(1)
      end

      it "redirects to pages path" do
        expect(response).to redirect_to admin_pages_path
      end

       it "set to success message" do
        expect(flash[:success]).to be_present
      end

      it "creates the page with correct status" do
        expect(Page.last.status).to eq("draft")
      end
    end

    context "with valid inputs and author or contributor role" do
      before do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
      end

      it "cannot create a page" do
        post :create, page: { title: "some time", body: "some description"}
        expect(Page.count).to eq(0)
      end

      it "cannot publish a page" do
        post :create, page: { title: "some time", body: "some description", status: "publish"}
        expect(Page.published.count).to eq(0)
      end
    end
  end

  describe "PUT update" do
    context "when user is editor or admin" do
      it "updates the page" do
        user = Fabricate(:user, role: "editor")
        session[:user_id] = user.id
        page = Fabricate(:page, title: "Wonderful day")
        put :update, id: page.slug, page: { title: "What day?"}
        expect(Page.first.title).to eq("What day?")
      end
    end

    context "when user is author or contributor" do
      it "cannot update page" do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
        page = Fabricate(:page, title: "Wonderful day")
        put :update, id: page.slug, page: { title: "What day?"}
        expect(Page.first.title).to_not eq("What day?")
      end
    end
  end

  describe "DELETE destroy" do
    context "when user is an admin or editor" do
      before do
        user = Fabricate(:user, role: "admin")
        session[:user_id] = user.id
        page = Fabricate(:page)
        delete :destroy, id: page.slug
      end

      it "can delete the page" do
        expect(Page.count).to eq(0)
      end

      it "redirects to pages path" do
        expect(response).to redirect_to admin_pages_path
      end

      it "sets the flash message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when user is a contributor or author" do
      it "cannot delete the page" do
        user = Fabricate(:user, role: "author")
        session[:user_id] = user.id
        page = Fabricate(:page)
        delete :destroy, id: page.slug
        expect(Page.count).to eq(1)
      end
    end
  end
end
