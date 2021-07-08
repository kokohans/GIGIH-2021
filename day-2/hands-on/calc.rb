class Calculator
    def add(number1, number2)
        number1 + number2
    end
end

calc = Calculator.new
integer = calc.add(1,2)

double = calc.add(1.23, 5.44)

string = calc.add("1.23", "5.44")

puts integer
puts double
puts string