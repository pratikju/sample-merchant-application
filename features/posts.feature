@posts
Feature: creating a blog post
    In order to share my thoughts with the world
    As a blogger
    I want to write a blog post

    Background:
      Given following users exist:
        | email                  |
        | bob@example.com        |
        | alice@example.com      |
      And I sign in as "bob@example.com"
      And I go to the dashboard page

    Scenario: create a text-only post as draft
      Given I click on the create post button
      When I create a blog post as follows:
        | title              | content       |
        | I am eating yogurt | I like yogurt |
      And I click on the save button
      And I go to the dashboard page
      Then I should see "I am eating yogurt" within ".drafts"
      And I click on "I am eating yogurt"
      Then I should be on the post titled "I am eating yogurt"
      And I should see the post content "I like yogurt"

    Scenario: posting a message appends it to the top of list of posts
      Given the following posts exist:
        | title              | content       |
        | Saltwater          | The first thing we did after we landed was go to this new bar called La Caixa. |
        | Another post       | Some Content for this post. |
      When I click on the "Create Post" button
      When I create a blog post as follows:
        | title              | content       |
        | Walk then talk          | My guiding philosophy on developer advocacy. |
      And I click on the "save" button
      Then I should see "Walk then talk" as the first post within ".drafts"

    Scenario: cancel a blog post
      When I click on the "Create Post" button
      When I create a blog post as follows:
        | title              | content       |
        | Walk then talk     | My guiding philosophy on developer advocacy. |
      And I click on the "cancel" button
      Then I should be on my dashboard page
      And I should not see "Walk then talk" post in my dashboard

    Scenario: delete one of my posts
      Given I am on my dashboard
      And I have a blog post titled "Look at my Dog"
      And I choose to delete the post titled "Look at my Dog"
      And I go to my dashboard
      Then I should not see "Look at my Dog" post in my dashboard

    Scenario: change post title
      Given I am on my dashboard
      And I have a blog post as follows:
        | title              | content       |
        | Saltwater          | The first thing we did after we landed was go to this new bar called La Caixa. |
      And I choose to edit the post titled "Saltwater"
      Then I should be on the edit post page
      And I change the title to "Saltwater Lakes"
      And I click on the "save" button
      Then I should be on "My Dashboard" page
      And I should see the post titled "Saltwater Lakes"
      And I should not see any post titled "Saltwater"


    Scenario: change the content of a post
      Given I am on my dashboard
      And I have a blog post as follows:
        | title              | content       |
        | Saltwater          | The first thing we did after we landed was go to this new bar called La Caixa. |
      And I choose to edit the post titled "Saltwater"
      Then I should be on the edit post page
      And I change the content of the post to "The first thing we did after we landed was go to this place called Los Corralillos."
      And I click on the "save" button
      Then I should be on "My Dashboard" page
      And I should see the post titled "Saltwater"
      Then I should click on "Saltwater"
      And I should see the content of the post as "The first thing we did after we landed was go to this place called Los Corralillos."

      Scenario: create a post with author information
        Given I click on the create post button
        When I create a blog post as follows:
          | title              | content       |
          | I am eating yogurt | I like yogurt |
        And I click on the save button
        And I go to the dashboard page
        Then I should see "I am eating yogurt" within ".drafts"
        And I should see the author of the post as "bob@example.com"
        And I click on "I am eating yogurt"
        Then I should be on the post titled "I am eating yogurt"
        And I should see the author of the post as "bob@example.com"
