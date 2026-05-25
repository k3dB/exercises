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

    public static string Calculate(int operand1, int operand2, string operation)
    {
        if (operand2 == 0 && operation == Divide)
            return DivisionByZeroErrorMessage;

        var answer = operation switch
        {
            Add      => SimpleOperation.Addition       (operand1, operand2),
            Multiply => SimpleOperation.Multiplication (operand1, operand2),
            Divide   => SimpleOperation.Division       (operand1, operand2),
            null     => throw new ArgumentNullException       (nameof(operation)),
            ""       => throw new ArgumentException           (nameof(operation)),
            _        => throw new ArgumentOutOfRangeException (nameof(operation))
        };

        return string.Format(ResultFormat, operand1, operation, operand2, answer);
    }
}
