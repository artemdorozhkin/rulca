require "minitest/autorun"
require_relative "../rulca/lexer"
require_relative "../rulca/token"

class TestLexer < Minitest::Test
  def test_single_number
    tokens = Lexer.tokenize("42")
    assert_equal 1, tokens.size
    assert_equal TokenKind::NUMBER, tokens[0].kind
    assert_equal "42", tokens[0].value
  end

  def test_operators
    tokens = Lexer.tokenize("1 + 2 - 3 * 4 / 5")
    kinds = tokens.map(&:kind)
    assert_equal [
      TokenKind::NUMBER,
      TokenKind::PLUS,
      TokenKind::NUMBER,
      TokenKind::MINUS,
      TokenKind::NUMBER,
      TokenKind::STAR,
      TokenKind::NUMBER,
      TokenKind::SLASH,
      TokenKind::NUMBER,
    ], kinds
  end

  def test_parentheses
    tokens = Lexer.tokenize("(1 + 2)")
    kinds = tokens.map(&:kind)
    assert_equal [
      TokenKind::LPAREN,
      TokenKind::NUMBER,
      TokenKind::PLUS,
      TokenKind::NUMBER,
      TokenKind::RPAREN,
    ], kinds
  end

  def test_ignores_spaces_and_newlines
    tokens = Lexer.tokenize(" 1 +\n2 ")
    kinds = tokens.map(&:kind)
    assert_equal [TokenKind::NUMBER, TokenKind::PLUS, TokenKind::NUMBER], kinds
  end

  def test_bad_token
    tokens = Lexer.tokenize("2 @ 3")
    assert_equal TokenKind::BAD_TOKEN, tokens[1].kind
    assert_equal "@", tokens[1].value
  end
end
