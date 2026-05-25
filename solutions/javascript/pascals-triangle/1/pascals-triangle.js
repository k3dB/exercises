export const rows = (count) => {
  let triangle = [];

  for (let i = 0; i < count; i++) {
    let previous = triangle[i - 1];
    triangle[i]  = [1];

    for (let j = 1; j < i; j++) {
      triangle[i].push(previous[j - 1] + previous[j]);
    }

    if (i > 0) triangle[i].push(1);
  }

  return triangle;
};
