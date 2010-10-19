Feature: User can search for movie

	As a user
	I can input a movie title of my choice
	So that I can search and find its information
		
Scenario: User enters a movie
Given I am on the new movie page
When I enter a movie
Then I should be taken to a separate "results" page
	
Scenario: User chooses a movie from results page
Given I am on the results page
When I click one of the movie results
Then I should see the movie's information

Scenario: User enters a movie that does not exist
Given I am on the results page
When I click "none of these"
Then it should say "Movie not found" and allow me to search again
		
Scenario: User gets a new movie in database
Given I clicked a movie on the results page
When I see the movie information has been filled out
Then I should be prompted that a new movie will be stored

		