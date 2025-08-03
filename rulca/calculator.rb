require_relative "lexer"
require_relative "parser"
require_relative "evaluator"

module Calculator
  def self.calculate(expression)
    begin
      tokens = Lexer.tokenize(expression)
      ast = Parser.parse_expression(tokens)
      return Evaluator.evaluate(ast)
    rescue SyntaxError => e
      return e.message
    end
  end
end
