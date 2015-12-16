@comments
Feature: commenting on blog posts
  In order to tell Alice how great her blog post is
  As Alice's friend
  I want to comment on her post

  Background:
    Given following users exist:
      | username    | email             |
      | Bob Jones   | bob@example.com   |
      | Alice Smith | alice@example.com |
    When "alice@example.com" has posted a blog post titled "Look at this dog"

  Scenario: comment on a post
    When I sign in as "bob@example.com"
    And I am on "alice@example.com"'s page
    Then I should see "Look at this dog"
    And I click on "Look at this dog"
    Then I should be on page titled "Look at this dog"
    And I fill in the following comment:
        | text            | is that a poodle?    |
    And I press "Comment" button
    Then I should see "is that a poodle?" within ".comment"
    And I should see "less than a minute ago" within ".comment time"

  Scenario: delete a comment
    When I sign in as "bob@example.com"
    And I am on "alice@example.com"'s page
    Then I should see "Look at this dog"
    And I click on "Look at this dog"
    Then I should be on page titled "Look at this dog"
    When I comment "is that a poodle?" on "Look at this dog"
    And I click to delete the first comment
    Then I should not see "is that a poodle?"
