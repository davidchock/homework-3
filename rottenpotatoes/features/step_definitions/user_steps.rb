When /^I search for "([^"]*)"$/ do |arg1|
  fill_in "Title", :with => arg1
end

Then /^I should be taken to a separate "([^"]*)" page$/ do |arg1|
  current_url.should_not == '/movies/new'
end

Then /^it should say "([^"]*)" and allow me to search again$/ do |arg1|
  response.should contain("Movie not found")
end


When /^I select "([^"]*)"$/ do |arg1|
  click_link arg1
end

Then /^I should see it is rated "([^"]*)"$/ do |arg1|
  response.should contain("R")
end

When /^I click "([^"]*)"$/ do |arg1|
  click_button arg1
end

Then /^I should be able to find "([^"]*)" in my database$/ do |arg1|
  visit '/'
  response.should contain(arg1)
end

Then /^I should go back to the new movie page$/ do
  response.should contain("New movie")
end
