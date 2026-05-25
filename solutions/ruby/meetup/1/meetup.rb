require 'date'

class Meetup
  DAYS = %i[ sunday monday tuesday wednesday thursday friday saturday ].freeze

  DAYS_PER_WEEK = 7
  WEEK_NUMBERS  = %i[ first second third fourth ].freeze
  TEENTHS       = [ 13, 14, 15, 16, 17, 18, 19 ]

  def initialize(month, year)
    @month = month
    @year  = year
  end

  def day(day_of_week, week)
    first_of_month = Date.new(@year, @month, 1)

    offset = DAYS.index(day_of_week) - first_of_month.wday
    offset += DAYS_PER_WEEK if offset.negative?

    first_day = first_of_month.next_day(offset)

    return last(first_day)   if week == :last
    return teenth(first_day) if week == :teenth

    first_day.next_day(DAYS_PER_WEEK * WEEK_NUMBERS.index(week))
  end

  def last(current_day)
    return current_day.prev_day(DAYS_PER_WEEK) if current_day.month != @month
    last(current_day.next_day(DAYS_PER_WEEK))
  end

  def teenth(current_day)
    return current_day if TEENTHS.include?(current_day.day)
    teenth(current_day.next_day(DAYS_PER_WEEK))
  end
end
