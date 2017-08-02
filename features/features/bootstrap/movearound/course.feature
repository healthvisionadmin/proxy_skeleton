# run this with 
# vendor/bin/behat --config features/behat.yml --tags course -s course
@course
Feature: Describing the processes for 
  creating a course
  assigning a course leader / trainer
  booking a course for users


Scenario: Creating a new course  
  Given that I have a "valid_admin" Authorization 
  """
  only admins are allowed to create new courses ??? later trainers are allowed to change some attributes like description
  """
  When I request "api/profile/1/calendar/month" with Method "GET"
  And I want to see the curl of the query
  Then the response status code should be 200
 

