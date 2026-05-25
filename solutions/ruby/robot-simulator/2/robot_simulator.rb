class Robot
  DIRECTIONS = %i[north east south west]

  attr_reader :bearing, :coordinates

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)
    @bearing = direction
  end

  def turn_right
    new_bearing_index = DIRECTIONS.index(@bearing) + 1
    @bearing = DIRECTIONS[new_bearing_index] || DIRECTIONS.first
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
    when :north then at(x, y + 1)
    when :south then at(x, y - 1)
    when :east  then at(x + 1, y)
    when :west  then at(x - 1, y)
    end
  end
end

class Simulator
  COMMANDS = {
    'L' => :turn_left,
    'R' => :turn_right,
    'A' => :advance
  }.freeze

  def instructions(commands)
    commands.chars.map { |c| COMMANDS[c] }
  end

  def place(robot, x: 0, y: 0, direction: :north)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, commands)
    instructions(commands).each { |c| robot.send(c) }
  end
end
