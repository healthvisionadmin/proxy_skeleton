@new

Feature: Testing Migrations with Behat
i want to check if a certain database is up
i want to do this based with an external setting.file
and i want slim to use this as well


Scenario: Asure that certain db is up and avail
Given that we use Database "healt_test"


When I request "/api/profiles/all" with Method "GET"
Then the response status code should be 200

When I request "api/profile/1/calendar/blocked" with Method "GET"
Then the response status code should be 200
And the Element nr. 0 of "data" should have attribute "profile_id" with value 1
  

And the response should contain attribute "data" with 15 Elements


When I request "api/doctors/paged/2/8" with Method "GET"
Then the response status code should be 200
And the response should contain attribute "data" with 8 Elements
