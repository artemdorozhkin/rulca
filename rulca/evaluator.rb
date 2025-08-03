require_relative "parser"

module Evaluator
  def self.evaluate(ast)
    if ast.instance_of? Parser::BinOp
      left_val = Evaluator.evaluate(ast.left)
      right_val = Evaluator.evaluate(ast.right)

      if ast.op == "+"
        return left_val + right_val
      end

      if ast.op == "-"
        return left_val - right_val
      end

      if ast.op == "*"
        return left_val * right_val
      end

      if ast.op == "/"
        return left_val / right_val
      end
    else
      return ast.to_i
    end
  end
end
