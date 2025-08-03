require_relative "calculator"

module Rulca
  def self.main()
    while true
      puts("Input expression:")
      user_input = gets()
      if user_input == "exit\n"
        break
      end
      puts Calculator.calculate(user_input)
    end
  end
end

if __FILE__ == $0
  Rulca.main()
end
