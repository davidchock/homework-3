require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /I enter a movie that does not exist$/ do 
  @movieName = "d;lafjd;lajk"
end

Then /^it should say "([^"]*)"$/ do |arg1|
  lookup = Movie.query(@movieName)
  lookup.should == arg1   
end

When /^I enter a movie$/ do
  @movieName = "Star Wars"
end


Then /^I should be taken to a separate "([^"]*)" page$/ do |arg1|
  visits "/movies/new"
  fills_in "title", :with => @movieName
  clicks_button "Enter"
end

When /^I click one of the movie results$/ do
  visit "/movies/new"
  fill_in "title", :with => "Star Wars"
  click_button "Enter"
  #clicks_link "Movie 1"
  @response = response
end

Then /^I should see the movie's information$/ do
  pending
end

Given /^I clicked a movie on the results page$/ do
  visit "/movies/new"
  fill_in "title", :with => "Star Wars"
  click_button "Enter"
  #clicks_link "Movie 1"
  @response = response 
end

When /^I see the movie information has been filled out$/ do
  
end

Then /^I should be prompted that a new movie will be stored in my database$/ do
  pending
end

When /^I click "([^"]*)"$/ do |arg1|
  visit "/movies/new"
  fill_in "title", :with => "Star Wars"
  click_button "Enter"
  click_button "None of these"
  @response = response
end

Then /^I should return back to the page with the movie search$/ do
  pending
end
