require 'rails_helper'

describe Admin::GeneralSettingsController do

  describe "GET edit" do
    context "when user is admin" do
      it "render edit page" do
        setting = Fabricate(:general_setting)
        user = Fabricate(:user, role: "admin")
        session[:user_id] = user.id
        get :edit, id: setting.id
        expect(response).to render_template :edit
      end
    end

    context "when user is not admin" do
      it "does not render edit page" do
        setting = Fabricate(:general_setting)
        user = Fabricate(:user, role: "editor")
        session[:user_id] = user.id
        get :edit, id: setting.id
        expect(response).to_not render_template :edit
      end
    end

  end

  describe "PUT update" do
    context "when user is admin" do
      it "can update general settings" do
        setting = Fabricate(:general_setting, title: "My Blog")
        user = Fabricate(:user, role: "admin")
        session[:user_id] = user.id
        put :update, id: setting.id, general_setting: { title: "My Website"}
        expect(setting.reload.title).to eq('My Website')
      end
    end

    context "when user is not admin" do
      it "cannot update general settings" do
        setting = Fabricate(:general_setting, title: "My Blog")
        user = Fabricate(:user, role: "editor")
        session[:user_id] = user.id
        put :update, id: setting.id, general_setting: { title: "My Website"}
        expect(setting.reload.title).to_not eq('My Website')
      end
    end
  end
end
