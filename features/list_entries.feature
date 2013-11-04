Feature: Review journal entries
	In order to review the journal
	As a user
	I want to list and filter entries

	Scenario: List the most recent journal entries
		Given an empty file named "test.md"
		When I run `jou -a "Example" -t "test.md"`
		When I run `jou`
		Then the output should contain "Example"