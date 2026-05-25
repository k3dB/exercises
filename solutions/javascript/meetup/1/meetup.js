const daysPerWeek = 7;
const weekPlaces  = [ 'first', 'second', 'third', 'fourth' ];
const teenths     = [ 13, 14, 15, 16, 17, 18, 19 ];

const getDayIndex = (day) => {
  switch (day) {
    case 'Sunday':    return 0;
    case 'Monday':    return 1;
    case 'Tuesday':   return 2;
    case 'Wednesday': return 3;
    case 'Thursday':  return 4;
    case 'Friday':    return 5;
    case 'Saturday':  return 6;
    default: throw new Error('Invalid day.  Be sure to use proper name casing.');
  }
}

const getDayOffset = (day, index) => {
  const offset = getDayIndex(day) - index;
  return offset < 0 ? offset + daysPerWeek : offset;
}

const getLastDay = (day, monthIndex) => {
  if (day.getMonth() !== monthIndex) {
    day.setDate(day.getDate() - daysPerWeek);
    return day;
  }

  day.setDate(day.getDate() + daysPerWeek);
  return getLastDay(day, monthIndex);
}

const getTeenthDay = (day) => {
  if (teenths.includes(day.getDate())) {
    return day;
  }

  day.setDate(day.getDate() + daysPerWeek);
  return getTeenthDay(day);
}

export const meetup = (year, month, week, day) => {
  const monthIndex = month - 1;
  const firstOfMonth = new Date(year, monthIndex, 1);
  const offset = getDayOffset(day, firstOfMonth.getDay());

  let currentDay = firstOfMonth;
  currentDay.setDate(currentDay.getDate() + offset);

  if (week === 'last')   return getLastDay(currentDay, monthIndex);
  if (week === 'teenth') return getTeenthDay(currentDay);

  currentDay.setDate(
    currentDay.getDate() + daysPerWeek * weekPlaces.indexOf(week)
  );

  return currentDay;
};
