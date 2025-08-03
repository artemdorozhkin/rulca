require_relative "token"

module Parser
  class BinOp
    def initialize(left, op, right)
      @left = left
      @op = op
      @right = right
    end

    def left
      @left
    end

    def right
      @right
    end

    def op
      @op
    end

    def to_s
      return "Left(#{@left}) Op(#{@op}) Right(#{@right})"
    end
  end

  def self.parse_expression(tokens)
    node = Parser.parse_term(tokens)
    while tokens.size > 0 and (tokens[0].kind == TokenKind::PLUS or tokens[0].kind == TokenKind::MINUS)
      op = Parser.parse_operator(tokens)
      right = Parser.parse_expression(tokens)
      node = BinOp.new(node, op, right)
    end

    return node
  end

  def self.parse_term(tokens)
    node = Parser.parse_primary(tokens)
    while tokens.size > 0 and (tokens[0].kind == TokenKind::STAR or tokens[0].kind == TokenKind::SLASH)
      op = Parser.parse_operator(tokens)
      right = Parser.parse_primary(tokens)
      node = BinOp.new(node, op, right)
    end

    return node
  end

  def self.parse_primary(tokens)
    if tokens.size == 0
      raise SyntaxError.new "Expected number"
    end

    token = tokens[0]
    tokens.delete_at(0)
    if token.kind == TokenKind::NUMBER
      return token.value
    end

    if token.kind == TokenKind::LPAREN
      expr = Parser.parse_expression(tokens)
      if tokens.size == 0 or tokens[0].kind != TokenKind::RPAREN
        raise SyntaxError.new "Expected ')'"
      end
      tokens.delete_at(0)
      return expr
    end

    raise SyntaxError.new "Unexpected token: #{token.value}"
  end

  def self.parse_operator(tokens)
    token = tokens[0]
    tokens.delete_at(0)

    case token.kind
    when TokenKind::PLUS
      return token.value
    when TokenKind::MINUS
      return token.value
    when TokenKind::STAR
      return token.value
    when TokenKind::SLASH
      return token.value
    else
      raise SyntaxError.new "Unexpected token: #{token.value}"
    end
  end
end
