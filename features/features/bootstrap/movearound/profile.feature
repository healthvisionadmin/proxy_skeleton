# run this with vendor/bin/behat --config features/behat.yml --tags profile -s profile_endpoints
@profile
Feature: Testing Profile Endpoints, Group Access
  

Scenario: Having a VALID Auth-Bearer from an ADMIN
  Given that I have a "valid_user_1_group_1" Authorization
  When I request "/api/profiles/all" with Method "GET"
  And I want to see the curl of the query
  Then the response status code should be 200

Scenario: Having a VALID Auth-Bearer from an USER
  Given that I have a "valid_user_1_group_2" Authorization
  When I request "/api/profiles/all" with Method "GET"
  #And I want to see the curl of the query
  Then the response status code should be 401
 


#  When I request "api/profile/1/calendar/blocked" with Method "GET"
#  Then the response status code should be 200
#   And the Element nr. 0 of "data" should have attribute "profile_id" with value 1



#Scenario: Having a VALID Auth-Bearer and requesting basic endpoints
#  Given that I have a "valid_user_1_group_1" Authorization
#  When I request "/api/profiles/all" with Method "GET"
#  And I want to see the curl of the query
#  Then the response status code should be 200
   

#  And the response should contain attribute "data" with 15 Elements
#
#  When I request "api/doctors/paged/1/10" with Method "GET"
#  Then the response status code should be 200
#  And the response should contain attribute "data" with 10 Elements
#
#  When I request "api/doctors/paged/2/8" with Method "GET"
#  Then the response status code should be 200
#  And the response should contain attribute "data" with 8 Elements
#
#  When I request "api/doctors/paged/2/8" with Method "GET"
#  Then the response status code should be 200
#  And the response should contain attribute "data" with 8 Elements
#  And the Element nr. 0 of "data" should have attribute "id" with value 9
