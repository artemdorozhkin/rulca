require "minitest/autorun"
require_relative "../rulca/parser"
require_relative "../rulca/lexer"

class TestParser < Minitest::Test
  def parse(expr)
    tokens = Lexer.tokenize(expr)
    Parser.parse_expression(tokens)
  end

  def test_simple_addition_ast
    ast = parse("2 + 3")
    assert_instance_of Parser::BinOp, ast
    assert_equal "2", ast.left
    assert_equal "+", ast.op
    assert_equal "3", ast.right
  end

  def test_operator_precedence
    ast = parse("2 + 3 * 4")
    assert_equal "+", ast.op
    assert_equal "2", ast.left
    assert_instance_of Parser::BinOp, ast.right
    assert_equal "*", ast.right.op
  end

  def test_nested_parentheses_ast
    ast = parse("(1 + (2 + 3))")
    assert_equal "+", ast.op
    assert_equal "1", ast.left
    assert_instance_of Parser::BinOp, ast.right
    assert_equal "+", ast.right.op
    assert_equal "2", ast.right.left
    assert_equal "3", ast.right.right
  end

  def test_unmatched_open_paren
    tokens = Lexer.tokenize("(2 + 3")
    assert_raises(SyntaxError) { Parser.parse_expression(tokens) }
  end

  def test_empty_expression
    tokens = Lexer.tokenize("")
    assert_raises(SyntaxError) { Parser.parse_expression(tokens) }
  end

  def test_invalid_sequence
    tokens = Lexer.tokenize("2 + * 3")
    assert_raises(SyntaxError) { Parser.parse_expression(tokens) }
  end
end
