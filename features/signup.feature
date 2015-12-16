@signup
Feature: User Sign Up

  Scenario: user signs up
    When I go to the new user registration page
    And I fill in the new user form with email "bob@example.com", password "s3cr3t1234" and password confirmation "s3cr3t1234"
    And I submit the form
    Then I should be on the dashboard page
    And  I should see the 'dashboard' contents


  Scenario: user signs up error
    When I go to the new user registration page
    And  I fill in the new user form with email "bob@example.com", password "s3cr3t1234" and password confirmation "s3cr3t"
    And  I submit the form
    Then I should be on the new user registration page
    And I should see an error message
