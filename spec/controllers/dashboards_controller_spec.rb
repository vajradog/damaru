require 'rails_helper'

describe DashboardsController do

  describe "GET index" do

    it_should_behave_like "require_sign_in" do
      let(:action) { get :index }
    end

    context "when the user role is admin or editor" do
      it "renders all posts" do
        user = Fabricate(:user, role: 'admin')
        session[:user_id] = user.id
        post = Fabricate(:post)
        get :index
        expect(assigns(:posts)).to eq([post])
      end
    end

    context "when the user role is author or contributor" do
      it "renders only posts they own" do
        user = Fabricate(:user, role: 'contributor')
        session[:user_id] = user.id
        post = Fabricate(:post, user_id: user.id)
        get :index
        expect(assigns(:posts)).to eq([post])
      end

      it "does not render posts they do not own" do
        user = Fabricate(:user, role: 'author')
        user2 = Fabricate(:user, role: 'contributor')
        session[:user_id] = user2.id
        post = Fabricate(:post, user_id: user.id)
        get :index
        expect(assigns(:posts)).to_not eq([post])
      end
    end

    it "renders @users for all users in any roles" do
      user = Fabricate(:user, role: 'contributor')
      session[:user_id] = user.id
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders @pages for all users in any roles" do
      page = Fabricate(:page)
      user = Fabricate(:user, role: 'contributor')
      session[:user_id] = user.id
      get :index
      expect(assigns(:pages)).to eq([page])
    end

    it "assigns @post for all users in any roles" do
      post = Fabricate(:post)
      user = Fabricate(:user, role: 'contributor')
      session[:user_id] = user.id
      get :index
      expect(assigns(:post)).to be_instance_of(Post)
    end
  end
end
