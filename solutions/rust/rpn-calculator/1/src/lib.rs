#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32)
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut calculated = Vec::new();

    for input in inputs {
        if is_number(input) {
            calculated.push(get_number(input));
        }
        else if is_operation(input) {
            let operand2: Option<i32> = calculated.pop();
            let operand1: Option<i32> = calculated.pop();

            if operand1 == None || operand2 == None {
                return None
            }

            calculated.push(perform_operation(operand1, operand2, input));
        }
    }

    if calculated.len() != 1 {
        return None
    }

    calculated.pop()
}


fn is_number(input: &CalculatorInput) -> bool {
    match input {
        &CalculatorInput::Value(_x) => true,
        _ => false
    }
}

fn get_number(input: &CalculatorInput) -> i32 {
    match input {
        &CalculatorInput::Value(x) => x,
        _ => 0
    }
}

fn is_operation(input: &CalculatorInput) -> bool {
    match input {
        &CalculatorInput::Value(_x) => false,
        _ => true
    }
}

// Note that division by zero is not checked.
fn perform_operation(operand1: Option<i32>, operand2: Option<i32>, input: &CalculatorInput) -> i32 {
    let value1 = match operand1 {
        Some(x) => x,
        None => 0
    };

    let value2 = match operand2 {
        Some(x) => x,
        None => 0
    };

    match input {
        &CalculatorInput::Add      => value1 + value2,
        &CalculatorInput::Subtract => value1 - value2,
        &CalculatorInput::Multiply => value1 * value2,
        &CalculatorInput::Divide   => value1 / value2,
        &CalculatorInput::Value(x) => x
    }
}
