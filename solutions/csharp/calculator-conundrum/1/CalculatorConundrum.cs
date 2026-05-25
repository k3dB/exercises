using System;
using System.Collections.Generic;
using System.Linq;

public static class SimpleCalculator
{
    private const string
        DivisionByZeroErrorMessage = "Division by zero is not allowed.",
        ResultFormat = "{0} {1} {2} = {3}",
        Add          = "+",
        Multiply     = "*",
        Divide       = "/";

    private static HashSet<string> _validOperations = new[]
    {
        Add, Multiply, Divide
    }.ToHashSet();

    public static string Calculate(int operand1, int operand2, string operation)
    {
        ValidateOperation(operation);

        if (operand2 == 0 && operation == Divide)
            return DivisionByZeroErrorMessage;

        var answer = operation switch
        {
            Add      => SimpleOperation.Addition       (operand1, operand2),
            Multiply => SimpleOperation.Multiplication (operand1, operand2),
            Divide   => SimpleOperation.Division       (operand1, operand2),
            _        => 0
        };

        return string.Format(ResultFormat, operand1, operation, operand2, answer);
    }

    private static void ValidateOperation(string operation)
    {
        if (operation is null)
            throw new ArgumentNullException(nameof(operation));

        if (string.IsNullOrEmpty(operation))
            throw new ArgumentException(nameof(operation));

        if (!_validOperations.Contains(operation))
            throw new ArgumentOutOfRangeException(nameof(operation));
    }
}
