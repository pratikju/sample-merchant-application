@publish
Feature: publish a blog post
    In order to share my thoughts with the world
    As a blogger
    I want to publish a blog post

    Background:
      Given following users exist:
        | email                  |
        | bob@example.com        |
        | alice@example.com      |
      And I sign in as "bob@example.com"

    Scenario: view a list of published posts
      Given I have the following published blog posts
        | title              | content       |
        | I am eating yogurt | I like yogurt |
        | I am eating mango  | I like mango  |
      And I am on the dashboard page
      Then I should see the following within ".published"
        | title              | content       |
        | I am eating yogurt | I like yogurt |
        | I am eating mango  | I like mango  |
      And I click on "I am eating yogurt"
      Then I should be on the post titled "I am eating yogurt"
      And I should see the post content "I like yogurt"


    Scenario: create and publish a text-only blog post
      Given I click on the create post button
      When I create a blog post as follows:
        | title              | content       |
        | I am eating yogurt | I like yogurt |
      And I click on the publish button
      And I go to the dashboard page
      Then I should see "I am eating yogurt" within ".published"
      And I click on "I am eating yogurt"
      Then I should be on the post titled "I am eating yogurt"
      And I should see the post content "I like yogurt"


    Scenario: publish a saved blog post
      Given I have the following saved post
        | title              | content       |
        | I am eating yogurt | I like yogurt |
      And I am on the dashboard page
      Then I should see "I am eating yogurt" within ".drafts"
      And I follow the "I am eating yogurt" link
      Then I should be on the page titled "I am eating yogurt"
      And I click on the publish button
      And I go to the dashboard page
      Then I should see "I am eating yogurt" within ".published"
