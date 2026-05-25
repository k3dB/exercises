class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    raise ArgumentError        if !all_integers?(first_operand, second_operand)
    raise UnsupportedOperation if !ALLOWED_OPERATIONS.include?(operation)

    begin
    '%s %s %s = %s' % [
      first_operand,
      operation,
      second_operand,
      result(first_operand, second_operand, operation).to_s
    ]
    rescue ZeroDivisionError
      'Division by zero is not allowed.'
    end
  end

  private

  def self.all_integers?(*operands)
    operands.all?{ |o| o.is_a?(Integer) }
  end

  def self.division_by_zero?(second_operand, operation)
    second_operand.zero? && operation == '/'
  end

  def self.result(first_operand, second_operand, operation)
    first_operand.public_send(operation, second_operand)
  end
end

class SimpleCalculator::UnsupportedOperation < StandardError
end
