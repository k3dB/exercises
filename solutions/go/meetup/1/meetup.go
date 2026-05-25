package meetup

import "time"

type WeekSchedule string

const (
    First  = "first"
    Second = "second"
    Third  = "third"
    Fourth = "fourth"
    Last   = "last"
    Teenth = "teenth"
)

const DaysInWeek = 7

func Day(weekSchedule WeekSchedule, weekDay time.Weekday, month time.Month, year int) int {
    date := time.Date(year, month, 1, 0, 0, 0, 0, time.UTC)
    offset := int(weekDay) - int(date.Weekday())

    if offset < 0 {
        offset += DaysInWeek
    }

    date = date.AddDate(0, 0, offset)

    if weekSchedule == Teenth {
        return GetTeenthDay(date)
    }

    if weekSchedule == Last {
        return GetLastDay(date, month)
    }

    weekIndex := GetWeekIndex(weekSchedule)
    return date.Day() + DaysInWeek * weekIndex
}

func Contains(items []int, element int) bool {
    for _, item := range items {
        if item == element {
            return true
        }
    }

    return false
}

func GetTeenthDay(date time.Time) int {
    if Contains([]int { 13, 14, 15, 16, 17, 18, 19 }, date.Day()) {
        return date.Day()
    }

    return GetTeenthDay(date.AddDate(0, 0, DaysInWeek))
}

func GetLastDay(date time.Time, month time.Month) int {
    if date.Month() != month {
        return date.AddDate(0, 0, -DaysInWeek).Day()
    }

    return GetLastDay(date.AddDate(0, 0, DaysInWeek), month)
}

func GetWeekIndex(weekSchedule WeekSchedule) int {
    switch weekSchedule {
        case First:
            return 0
        case Second:
            return 1
        case Third:
            return 2
        case Fourth:
            return 3
        default:
            return -1
    }
}
