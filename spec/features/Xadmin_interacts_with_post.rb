require 'rails_helper'

feature "user interacts with post" do
  scenario "user publishes a new post" do
    user_fills_up_new_post_form
    click_button "Publish Now"
    expect(page).to have_content "This is a new post"
  end

  scenario "user saves a new post as draft" do
    user_fills_up_new_post_form
    click_button "Save Post"
    expect(page).to_not have_content "This is a new post"
  end

  scenario "user updates a published post" do
    user_fills_up_update_post_form
    click_button "Update Post"
    expect(page).to have_content "Sure it is"
  end

  scenario "user un-publishes a post, moved to draft" do
    user_fills_up_update_post_form
    click_button "Unpublish and move to draft"
    expect(page).to_not have_content "Sure it is"
  end

  scenario "user deletes a post" do
    Fabricate(:post, title: "What a wonderful world", status: "published")
    visit root_path
    click_on "What a wonderful world"
    click_on "Delete this post"
    expect(page).to_not have_content "What a wonderful world"
  end

  def user_fills_up_update_post_form
    Fabricate(:post, title: "What a wonderful world", status: "published")
    visit root_path
    click_on "What a wonderful world"
    click_on "Edit this post"
    fill_in "post_title", with: "Sure it is"
  end

  def user_fills_up_new_post_form
    visit root_path
    click_on "New Post"
    expect(page).to have_content "Create"

    fill_in "post_title", with: "This is a new post"
    fill_in "post_body", with: "This is description for the new post"
  end
end

