module TokenKind
  NUMBER = "NUMBER"
  LPAREN = "LPAREN"
  RPAREN = "RPAREN"
  PLUS = "PLUS"
  MINUS = "MINUS"
  STAR = "STAR"
  SLASH = "SLASH"
  BAD_TOKEN = "BAD_TOKEN"
end

class Token
  def initialize(value, kind)
    @value = value
    @kind = kind
  end

  def value
    @value
  end

  def kind
    @kind
  end

  def to_s
    "Token(#{@value}, #{@kind})"
  end
end
