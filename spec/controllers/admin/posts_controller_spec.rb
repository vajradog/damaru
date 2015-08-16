require 'rails_helper'

describe Admin::PostsController do
  describe "GET index" do
    it "when admin or editor, it renders all posts" do
      post = Fabricate(:post)
      user = Fabricate(:user, role: "editor")
      session[:user_id] = user.id
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it "when not admin, renders posts only owned by user" do
      user = Fabricate(:user, role: "author")
      post = Fabricate(:post, user_id: user.id)
      session[:user_id] = user.id
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET new" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    context "with valid inputs and user above author role" do
      before do
        user = Fabricate(:user, role: "author")
        session[:user_id] = user.id
        post :create, post: { title: "some time", body: "some description", status: "draft"}
      end

      it "creates a new post" do
        expect(Post.count).to eq(1)
      end

      it "redirects to posts path" do
        expect(response).to redirect_to admin_posts_path
      end

       it "set to success message" do
        expect(flash[:success]).to be_present
      end

      it "creates the post with correct status" do
        expect(Post.last.status).to eq("draft")
      end
    end

    context "with valid inputs and user below author role" do
      before do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
      end

      it "creates a new post" do
        post :create, post: { title: "some time", body: "some description"}
        expect(Post.count).to eq(1)
      end

      it "cannot publish a post" do
        post :create, post: { title: "some time", body: "some description", status: "publish"}
        expect(Post.published.count).to eq(0)
      end
    end
  end

  describe "PUT update" do
    context "with valid inputs" do
      it "updates the post the user owns" do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
        post = Fabricate(:post, title: "Wonderful day", user_id: user.id)
        put :update, id: post.slug, post: { title: "What day?"}
        expect(Post.first.title).to eq("What day?")
      end

      it "cannot update the post the user doesn't own" do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
        post = Fabricate(:post, title: "Wonderful day")
        put :update, id: post.slug, post: { title: "What day?"}
        expect(Post.first.title).to_not eq("What day?")
      end
    end

    context "with correct role but invalid inputs" do
      it "renders the edit page" do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
        post = Fabricate(:post, title: "Wonderful day", user_id: user.id)
        put :update, id: post.slug, post: { title: ""}
        expect(response).to render_template :edit
      end

      it "sets the error message" do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
        post = Fabricate(:post, title: "Wonderful day", user_id: user.id)
        put :update, id: post.slug, post: { title: ""}
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "DELETE destroy" do
    context "when user is an admin" do
      before do
        user = Fabricate(:user, role: "admin")
        session[:user_id] = user.id
         post = Fabricate(:post)
        delete :destroy, id: post.slug
      end

      it "deletes the post" do
        expect(Post.count).to eq(0)
      end

      it "redirects to posts path" do
        expect(response).to redirect_to admin_posts_path
      end

      it "sets the flash message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when user is an editor" do
      it "deletes the post" do
        user = Fabricate(:user, role: "editor")
        session[:user_id] = user.id
         post = Fabricate(:post)
        delete :destroy, id: post.slug
        expect(Post.count).to eq(0)
      end
    end

    context "when user is an author" do
      it "cannot delete the post" do
        user = Fabricate(:user, role: "author")
        session[:user_id] = user.id
         post = Fabricate(:post)
        delete :destroy, id: post.slug
        expect(Post.count).to eq(1)
      end
    end

    context "when user is a contributor" do
      it "cannot delete the post" do
        user = Fabricate(:user, role: "contributor")
        session[:user_id] = user.id
         post = Fabricate(:post)
        delete :destroy, id: post.slug
        expect(Post.count).to eq(1)
      end
    end
  end
end


