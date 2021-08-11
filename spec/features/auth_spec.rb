require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Name', :with => "tester"
      fill_in 'Email', :with => "testing@email.com"
      fill_in 'Password', :with => "biscuits"
      click_on "Submit"
    end

    scenario "sends authentication mail after signup" do
        expect(page).to have_content "Sign up"
        expect(page).to have_content "Authentication mail has been sent ,please follow the link provided in the mail to complete the authentication process"
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      click_on "Submit"
    end

    scenario "re-renders the signup page after failed signup" do
        expect(page).to have_content "Sign up"
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end

end