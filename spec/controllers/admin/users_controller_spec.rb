require 'rails_helper'

describe Admin::UsersController do
  describe "GET new" do
    context "when not signed in" do
      it_behaves_like "require_sign_in" do
        let(:action) { get :new }
      end
    end

    context 'when user is signed in but not admin' do
      it "redirect to root_path" do
        user = Fabricate(:user, role: 'author')
        session[:user_id] = user.id
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "Post create" do
    context "if signed in user is not admin" do
      it "does not create a user" do
        user = Fabricate(:user, role: 'author')
        session[:user_id] = user.id
        post :create, user: {email:"sally@y.com", password:"password", display_name:"John Doe", role: 'contributor'}
       expect(User.count).to eq(1)
      end
    end

    context "with admin and valid data" do
      before do
        user = Fabricate(:user, role: 'admin')
        session[:user_id] = user.id
        post :create, user: {email:"sally@y.com", password:"password", display_name:"John Doe", role: 'contributor'}
      end

      it "creates a user" do
        expect(User.last.email).to eq('sally@y.com')
      end

      it "signs in the new user" do
        post :create, user: {email:"sally@y.com", password:"password", display_name:"John Doe"}
        expect(session[:user_id]).to_not be_nil
      end

      it "redirects to home_path after save" do
        expect(response).to redirect_to admin_users_path
      end
    end

    context "with admin and invalid data" do
      before do
        user = Fabricate(:user, role: 'admin')
        session[:user_id] = user.id
        post :create, user: {email:"sally@y.com", password:"", display_name:"ksd"}
      end

      it "does not create a new user" do
        expect(User.count).to eq(1)
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end

      it "sets the @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "Get edit" do
    context 'when user is not signed in' do
      it "redirect to root_path" do
        user = Fabricate(:user, role: 'author')
        get :edit, id: user.slug
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is signed in but not admin' do
      it "redirect to root_path" do
        user = Fabricate(:user, role: 'author')
        jack = Fabricate(:user, role: 'contributor')
        session[:user_id] = user.id
        get :edit, id: jack.slug
        expect(response).to redirect_to root_path
      end

      it "redirect to root_path" do
        user = Fabricate(:user, role: 'editor')
        jack = Fabricate(:user, role: 'contributor')
        session[:user_id] = user.id
        get :edit, id: jack.slug
        expect(response).to redirect_to root_path
      end

      it "redirect to root_path" do
        user = Fabricate(:user, role: 'contributor')
        jack = Fabricate(:user, role: 'contributor')
        session[:user_id] = user.id
        get :edit, id: jack.slug
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is signed in as admin' do
      it "renders the edit page" do
        user = Fabricate(:user, role: 'admin')
        jack = Fabricate(:user, role: 'contributor')
        session[:user_id] = user.id
        get :edit, id: jack.slug
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "PUT update" do
    context 'when user is signed in but not admin' do
      it "cannot update someone else" do
        user = Fabricate(:user, role: 'author')
        jack = Fabricate(:user, role: 'contributor')
        session[:user_id] = user.id
        put :update, id: jack.slug, user: { display_name: "Rambo" }
        expect(jack.display_name).to_not eq('Rambo')
      end

      it "can update own profile" do
        jack = Fabricate(:user, role: 'editor')
        session[:user_id] = jack.id
        put :update, id: jack.slug, user: { display_name: "Rambo" }
        expect(jack.reload.display_name).to eq('Rambo')
      end
    end
  end
end
