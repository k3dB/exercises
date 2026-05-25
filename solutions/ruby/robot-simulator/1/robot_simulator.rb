class Robot
  DIRECTIONS = %i[north east south west]

  attr_reader :bearing, :coordinates

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)
    @bearing = direction
  end

  def turn_right
    new_bearing_index = DIRECTIONS.index(@bearing) + 1
    new_bearing_index = 0 if new_bearing_index == DIRECTIONS.length
    @bearing = DIRECTIONS[new_bearing_index]
  end

  def turn_left
    @bearing = DIRECTIONS[DIRECTIONS.index(@bearing) - 1]
  end

  def at(x, y)
    @coordinates = [x, y]
  end

  def advance
    x, y = @coordinates
    case @bearing
    when :north
      at(x, y + 1)
    when :east
      at(x + 1, y)
    when :south
      at(x, y - 1)
    when :west
      at(x - 1, y)
    end
  end
end

class Simulator
  def instructions(instruction_set)
    robot_instructions = []

    instruction_set.chars.each do |instruction|
      case instruction
      when 'L'
        robot_instructions << :turn_left
      when 'R'
        robot_instructions << :turn_right
      when 'A'
        robot_instructions << :advance
      end
    end

    robot_instructions
  end

  def place(robot, x: 0, y: 0, direction: :north)
    robot.at(x, y)
    robot.orient(direction)
    robot
  end

  def evaluate(robot, instruction_set)
    instructions(instruction_set).each { |i| robot.send(i) }
  end
end
