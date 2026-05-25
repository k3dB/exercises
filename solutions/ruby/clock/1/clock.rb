class Clock

  attr_reader :time, :hours, :minutes

  def initialize(time = { hour: 0, minute: 0 })
    @time    = time
    @hours   = get_hours(@time)
    @minutes = get_minutes(@time)
  end

  def to_s
    "%s:%s" % [display(hours), display(minutes)]
  end

  def +(clock)
    new_minutes = minutes + clock.time[:minute]
    Clock.new(hour: hours, minute: new_minutes)
  end

  def -(clock)
    new_minutes = minutes - clock.time[:minute]
    Clock.new(hour: hours, minute: new_minutes)
  end

  def ==(clock)
    to_s == clock.to_s
  end

  private

  def get_hours(time)
    (time[:minute].to_i.div(60) + time[:hour].to_i) % 24
  end

  def get_minutes(time)
    time[:minute].to_i % 60
  end

  def display(number)
    number.to_s.rjust(2, '0')
  end

end
