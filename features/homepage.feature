Feature: Homepage

  @javascript
  @chrome
  Scenario: Loading the homepage
    Given I go to the root page
     Then I should see "Mnml"
