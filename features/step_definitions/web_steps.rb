When(/^I go to the new user registration page$/) do
  visit "/users/sign_up"
end

When(/^I fill in the new user form with email "(.*?)", password "(.*?)" and password confirmation "(.*?)"$/) do |arg1, arg2, arg3|
  within("#form") do
    fill_in 'email', :with => arg1
    fill_in 'password', :with => arg2
    fill_in 'password confirmation', :with => arg3
  end
end

When(/^I submit the form$/) do
  click_button 'sign_up'
end

Then(/^I should be on the dashboard page$/) do
  within('.page-header') do
    page.should have_content("Dashboard page")
  end
end

Then(/^I should see the 'dashboard' contents$/) do
  expect(page).to have_content('Dashboard contents')
end

Then(/^I should be on the new user registration page$/) do
  visit "user/sign_up"
end

Then(/^I should see an error message$/) do
  within('#error_explanation') do
    page.should have_content("doesn't match")
end
