require "minitest/autorun"
require_relative "../rulca/calculator"

class TestCalculator < Minitest::Test
  def test_addition
    assert_equal 5, Calculator.calculate("2 + 3")
  end

  def test_subtraction
    assert_equal -1, Calculator.calculate("2 - 3")
  end

  def test_multiplication
    assert_equal 6, Calculator.calculate("2 * 3")
  end

  def test_division
    assert_equal 2, Calculator.calculate("6 / 3")
  end

  def test_operator_precedence
    assert_equal 14, Calculator.calculate("2 + 3 * 4")
    assert_equal 20, Calculator.calculate("(2 + 3) * 4")
  end

  def test_nested_parentheses
    assert_equal 25, Calculator.calculate("(1 + (2 + 2)) * 5")
  end

  def test_whitespace_variations
    assert_equal 10, Calculator.calculate(" 2+ 3 *2 +   2 ")
  end

  def test_single_number
    assert_equal 7, Calculator.calculate("7")
  end

  def test_empty_input
    result = Calculator.calculate("")
    assert_match(/Expected number|Unexpected token/, result)
  end

  def test_unmatched_left_paren
    result = Calculator.calculate("(1 + 2")
    assert_match(/Expected '\)'/, result)
  end

  def test_double_operator
    result = Calculator.calculate("1 + * 2")
    assert_match(/Expected number|Unexpected token/, result)
  end

  def test_only_operator
    result = Calculator.calculate("*")
    assert_match(/Expected number|Unexpected token/, result)
  end

  def test_bad_characters
    result = Calculator.calculate("2 + @")
    assert_match(/Unexpected token/, result)
  end

  def test_division_by_zero
    assert_raises(ZeroDivisionError) do
      Calculator.calculate("4 / 0")
    end
  end

  def test_large_expression
    expr = "1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10"
    assert_equal 55, Calculator.calculate(expr)
  end
end
