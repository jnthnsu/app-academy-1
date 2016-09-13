require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content /Sign Up/i
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in "Username", :with => "testing_username"
      fill_in "Password", :with => "biscuits"
      click_on "Sign Up"
    end


    scenario "shows username on the homepage after signup" do
      expect(page).to have_content /testing_username/i
    end

    scenario "redirects to user show page after signup" do
      expect(page).to have_content /testing_username's profile/i
    end
  end

end

feature "logging in" do
  before(:each) do
    user = User.create!(username: "testing_username", password: "password")
    visit new_session_url
    fill_in "Username", :with => "testing_username"
  end

  scenario "shows login page with failure sign in" do
    fill_in "Password", :with => "pass"
    click_on "Sign In"
    expect(page).to have_content /username/i
    expect(page).to have_content /sign in/i
  end

  scenario "shows username on the homepage after login" do
    fill_in "Password", :with => "password"
    click_on "Sign In"
    expect(page).to have_content /testing_username/i
    expect(page).to have_content /testing_username's profile/i
  end

  scenario "logging out begins with a logged out state" do
    fill_in "Password", :with => "password"
    click_on "Sign In"
    click_on "Sign Out"
    expect(page).not_to have_content /sign out/i
  end

  scenario " logging out doesn't show username on the homepage after logout" do
    fill_in "Password", :with => "password"
    click_on "Sign In"
    click_on "Sign Out"
    expect(page).not_to have_content /testing_username/i
  end

end
