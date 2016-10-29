require 'spec_helper'
require 'rails_helper'


feature 'goal' do
  feature "the goal creation process" do

    before(:each) do
      login
      visit new_goal_url
      @goal = build(:goal)
      fill_in "title", with: @goal.title
      fill_in "details", with: @goal.details
    end

    scenario "works with valid params" do
      click_on "Create Goal"

      expect(page).to have_content /#{@goal.title}/i
      expect(page).to have_content /#{@goal.details}/i
    end

    scenario "doesn't work with invalid params" do
      fill_in "details", with: nil
      click_on "Create Goal"
      expect(page).to have_content /details can't be blank/i
    end
  end

  feature "the goal edit process" do
    scenario "works" do
      login

      @goal = create(:goal)

      visit goal_url(@goal)
      click_on "Complete"
      save_and_open_page

      expect(page).to have_content /goal updated/i
    end
  end
end
