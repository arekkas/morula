Feature: running a command in all subprojects

  As a developer
  I want to be able to run a command in all subprojects irrespective of changes
  So that the test status on the main development branch shows broken subprojects even if they weren't modified.

  - "morula run <command>" runs the given command in all subprojects
  - command that contain command-line flags must be provided as a string


  Scenario: all subprojects work
    Given a project with the subprojects:
      | NAME | TEMPLATE  |
      | one  | passing_1 |
      | two  | passing_2 |
    When running "morula all bin/spec"
    Then it runs that command in the directories:
      | one |
      | two |


  Scenario: calling a command with command-line arguments
    Given a project with the subprojects:
      | NAME | TEMPLATE  |
      | one  | passing_1 |
      | two  | passing_2 |
    When running "morula all 'ls -la'"
    Then it runs that command in the directories:
      | one |
      | two |


  Scenario: some subprojects are failing
    Given a project with the subprojects:
      | NAME  | TEMPLATE|
      | works | passing |
      | fails | failing |
    When trying to run "morula all bin/spec"
    Then it fails with an error code and the message:
      """
      subproject fails has issues
      """


  Scenario: forgetting to provide the command
    Given a project with the subprojects:
      | NAME  | TEMPLATE|
      | works | passing |
    When trying to run "morula all"
    Then it fails with an error code and the message:
      """
      Please provide the command to run
      """


  Scenario: providing a command that doesn't exist
    Given a project with the subprojects:
      | NAME  | TEMPLATE|
      | works | passing |
    When trying to run "morula all zonk"
    Then it fails with an error code and the message:
      """
      subproject works has issues
      """
