Feature: User can search for movie

	As a user
	I can input a movie title of my choice
	So that I can search and find its information
		


Scenario: User enters a movie that does not exist
Given I am on the new movie page
When I search for "as;jk;lj;"
Then it should say "Movie not found" and allow me to search again
	
Scenario: User chooses a movie from results page and see its information
Given I am on the new movie page
When I search for "Saw"
And I select "Saw III"
Then I should see it is rated "R"
		
Scenario: User saves a new movie in database
Given I am on the new movie page
When I search for "Bourne"
And I select "The Bourne Identity"
And I click "Save"
Then I should be able to find "The Bourne Identity" in my database

Scenario: User chooses none of these
Given I am on the new movie page
When I search for "Bourne"
And I click "None of these"
Then I should go back to the new movie page

Scenario: User enters a movie that exists and taken to a new 
Given I am on the new movie page
When I search for "Star Wars"
Then I should be taken to a separate "results" page

		