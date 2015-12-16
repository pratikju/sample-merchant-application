@signin
Feature: user Sign In

  Scenario: user logs in
    Given a user with email "bob@example.com" and password "secret"
    When I sign in manually as "bob@example.com" with password "secret"
    Then I should be on the dashboard page

  Scenario: user logs in
    Given a user with email "bob@example.com" and password "secret"
    When I sign in manually as "bob@example.com" with password "terces"
    Then I should be on user sign_in page
    And I should see an error message

  Scenario: user logs out
    Given I am signed in as "bob@example.com" with password "secret"
    And I click on my name in the header
    And I follow "Log out"
    Then I should be on the home page
