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
      first_operand.public_send(operation, second_operand)
    ]
    rescue ZeroDivisionError
      'Division by zero is not allowed.'
    end
  end

  private

  def self.all_integers?(*operands)
    operands.all?{ |o| o.is_a?(Integer) }
  end
end

class SimpleCalculator::UnsupportedOperation < StandardError
end
