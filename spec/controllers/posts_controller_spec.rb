require 'rails_helper'

describe PostsController do
  describe "GET index" do

    it "renders the posts index for users not logged in" do
      get :index
      expect(response).to render_template :index
    end

    it "renders the dashboards page for logged in users" do
      user = Fabricate(:user, role: 'author')
      session[:user_id] = user.id
      get :index
      expect(response).to redirect_to dashboards_path
    end
  end

  describe "GET show" do
    it "renders the show template" do
      post = Fabricate(:post)
      get :show, id: post.slug
      expect(response).to render_template :show
    end
  end
end
