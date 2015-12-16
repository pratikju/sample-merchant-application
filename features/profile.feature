@profile
Feature: Profile
  Background:
    Given following users exist:
      | email                  | first_name   | last_name |
      | bob@example.com        | Bob          | Jones     |
      | alice@example.com      | Alice        | Smith     |
    And I sign in as "bob@example.com"

  Scenario: I look at my profile
    When I click on my name in the header
    And I follow "Profile"
    Then I should see the following:
      | email           | first_name | last_name |
      | bob@example.com | Bob        | Jones     |

  Scenario: I can see draft posts
    Given I have the following saved posts:
      | title         | content                    |
      |My First Post  | This is my first blog post |
      |My Second Post | This is my second blog post|
    When I visit profile page
    Then I should see the following posts as draft:
      | title         | content                    |
      |My First Post  | This is my first blog post |
      |My Second Post | This is my second blog post|

  Scenario: I can see published posts
    Given I have published posts
      | title         | content                    |
      |My First Post  | This is my first blog post |
      |My Second Post | This is my second blog post|
    When I visit profile page
    Then I should see a list my published posts as follows:
      | title         | content                    |
      |My First Post  | This is my first blog post |
      |My Second Post | This is my second blog post|

  Scenario: I edit profile
    Given I visit profile page
    Then I click on "Edit Profile"
    And change my first name to "Robert" and last name to "Plant"
    And I click on the "save" button
    Then I should be on my profile page
    And I should see my first name as "Robert" and last name as "Plant"


  Scenario: I change my password
    Given I visit profile page
    When I click on "Change my Password"
    Then I should be on the "change password" page
    And I set my new password as "s3cr3t"
    And I click on "Change my password"
    And I should be redirected to sign_in page
