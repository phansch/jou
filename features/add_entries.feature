Feature: Add journal entries
	In order to fill the journal
	As a user
	I want to add entries

	Scenario: Add entry
		Given an empty file named "test.md"
		When I run `jou add "Example" -t "test.md"`
		Then the file "test.md" should contain "Example"
		And the file "test.md" should not contain "Hello"
