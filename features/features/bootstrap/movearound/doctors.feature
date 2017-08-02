# run this with vendor/bin/behat --config features/behat.yml -s doctor_endpoints
@doctors
Feature: Easily Combining Migrations with behat testing
  In order to have real testing scenarios
  we need to integrate Migrations with Behat testing

#Background:
#  run
#  php cli.php status
#  to get the current state of migrations.
#  copy the output and paste it into like #so#
#  ""#"#
#  up#  20151221231934  User#
#  up#  20151222115832  Grou#p#
#  up#  20151222221225  User#Permission#
#  up#  20151223205740  Rout#e#
#  up#  20161130012345  Cour#s#es#
#  up#  20161130184116  Doct#o#rBookings#
#  up  20161130201046  #DoctorBookingsDemoData
#  """


#Scenario: ...
#  Given that I have a "valid_user_1_group_1" Authorization
#  When I request "api/doctors/paged/1" with Method "GET"
#  Then the response status code should be 200
#  And the response should contain attribute "data" with 15 #Elements


Scenario: Want to be sure that certain migrations are up before proceeding
  Given that Migration Status is:
    """
    up  20151221231934   #User
    up  20151222115832   #Group
    up  20151222221225  #UserPermission
    up  20161130012345   #Courses
    up  20161130184116   #DoctorBookings
    up  20161130201046   #DoctorBookingsDemoData
    """
#
#
#
Scenario: Posting todo test for admin / non admin / self  
  Given that I have a "valid_user_1_group_1" Authorization
  And I want create an "api/doctors" by method "POST" with values:
      | firma | better inc    |
      | user_id | 48          |
      | name  | Brian         |
      | room  | WC            |
  And I want to see the curl of the query
  And I want to see the Response
  Then the response status code should be 400
  And the response should contain attribute "error" with 3 Elements
  And I internal internal HTTP-ERROR should be 400


#And the response type should be "application/json"

#Scenario: Having a VALID Auth-Bearer and requesting basic endpoints
#  Given that I have a "valid" Authorization
#  When I request "api/doctors/all" with Method "GET"
#  Then the response status code should be 200
#  And the response should contain attribute "data" with 20 Elements
#  And I want to see the curl of the query
#
#  When I request "api/doctors/paged/1" with Method "GET"
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
