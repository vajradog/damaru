require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:display_name) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:posts) }
  it { should have_secure_password }

  describe "#admin?" do
    it "returns true when user role is admin" do
      user = Fabricate(:user, role: 'admin')
      expect(user.admin?).to be true
    end
  end

   describe "#editor?" do
    it "returns true when user role is editor" do
      user = Fabricate(:user, role: 'editor')
      expect(user.editor?).to be true
    end
  end

   describe "#author?" do
    it "returns true when user role is author" do
      user = Fabricate(:user, role: 'author')
      expect(user.author?).to be true
    end
  end

   describe "#contributor?" do
    it "returns true when user role is contributor" do
      user = Fabricate(:user, role: 'contributor')
      expect(user.contributor?).to be true
    end
  end

  describe "sluggable" do
    it "generates a slug" do
      user = Fabricate(:user, role: 'contributor')
      expect(user.slug).to be_present
    end

    it "generates a slug from the display_name" do
      user = Fabricate(:user, role: 'contributor', display_name: 'John Doe')
      expect(user.slug).to eq('john-doe')
    end
  end
end
