require 'rails_helper'

describe Post do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should respond_to(:status) }
  it { should belong_to(:user) }

  describe "#published?" do
    it "shows post with published status as published" do
      post = Fabricate(:post, status: "published")
      expect(post.published?).to be true
    end

    it "does not show post with draft status as published" do
      post = Fabricate(:post, status: "draft")
      expect(post.published?).to be false
    end
  end

  describe "sluggable" do
    it "generates a slug" do
      post = Fabricate(:post)
      expect(post.slug).to be_present
    end

    it "generates a slug from the post title" do
      post = Fabricate(:post, title: 'What a wonderful world')
      expect(post.slug).to eq('what-a-wonderful-world')
    end
  end
end
