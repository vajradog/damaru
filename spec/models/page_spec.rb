require 'rails_helper'

describe Page do
  it { should validate_presence_of(:title) }

  describe "check_url_or_body" do
    it "when neither body or url is given, it should be invalid" do
      page = Page.create(title: "Nice Title", body: nil, external_url: nil)
      expect(page).to be_invalid
    end

    it "when either the body or url is given, it should be valid" do
      page = Page.create(title: "Nice Title", body: "Some text", external_url: nil)
      expect(page).to be_valid
    end
  end

  describe "#published?" do
    it "shows post with published status as published" do
      page = Fabricate(:page, status: 'published')
      expect(page.published?).to be true
    end

    it "does not show post with draft status as published" do
      page = Fabricate(:page, status: "draft")
      expect(page.published?).to be false
    end
  end

  describe "sluggable" do
    it "generates a slug" do
      page = Fabricate(:page)
      expect(page.slug).to be_present
    end

    it "generates a slug from the post title" do
      page = Fabricate(:page, title: 'About us')
      expect(page.slug).to eq('about-us')
    end
  end
end
