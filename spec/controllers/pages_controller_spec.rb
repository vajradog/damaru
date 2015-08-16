require 'rails_helper'

describe PagesController do

  describe "GET show" do
    it "renders the show template" do
      page = Fabricate(:page)
      get :show, id: page.id
      expect(response).to render_template :show
    end
  end
end
