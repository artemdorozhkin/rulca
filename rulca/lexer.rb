require_relative "token"

module Lexer
  def self.tokenize(user_input)
    tokens = []

    i = 0
    user_input.each_char do |_|
      if i >= user_input.size
        break
      end
      c = user_input[i]

      if Lexer.isnumber(c)
        start = i
        while Lexer.isnumber(c)
          i += 1
          if i >= user_input.size
            break
          end
          c = user_input[i]
        end
        token = Token.new(user_input[start, i - start], TokenKind::NUMBER)
        i -= 1
      elsif c == "("
        token = Token.new(c, TokenKind::LPAREN)
      elsif c == ")"
        token = Token.new(c, TokenKind::RPAREN)
      elsif c == "+"
        token = Token.new(c, TokenKind::PLUS)
      elsif c == "-"
        token = Token.new(c, TokenKind::MINUS)
      elsif c == "*"
        token = Token.new(c, TokenKind::STAR)
      elsif c == "/"
        token = Token.new(c, TokenKind::SLASH)
      elsif c == " " || c == "\n"
        i += 1
        next
      else
        token = Token.new(c, TokenKind::BAD_TOKEN)
      end

      i += 1
      tokens.append(token)
    end

    return tokens
  end

  def self.isnumber(char)
    return char.match?(/\d/)
  end
end
