.PHONY: run
run:
	ruby rulca/main.rb

.PHONY: tests
tests:
	ruby tests/test_calculator.rb
	ruby tests/test_lexer.rb
	ruby tests/test_parser.rb