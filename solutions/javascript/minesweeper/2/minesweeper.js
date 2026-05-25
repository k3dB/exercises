const isBomb = (c) => c === '*';

const updateRow = (row, index) => {
  let tiles = row.split('');

  if (index > 0 && !isBomb(tiles[index - 1])) {
    tiles[index - 1] = +tiles[index - 1] + 1;
  }

  if (!isBomb(tiles[index])) {
    tiles[index] = +tiles[index] + 1;
  }

  if (index < tiles.length - 1 && !isBomb(tiles[index + 1])) {
    tiles[index + 1] = +tiles[index + 1] + 1;
  }

  return tiles.join('');
};

export const annotate = (grid) => {
  for (let i = 0; i < grid.length; i++) {
    for (let j = 0; j < grid[i].length; j++) {
      if (!isBomb(grid[i].charAt(j))) continue;

      if (i > 0) {
        grid[i - 1] = updateRow(grid[i - 1], j);
      }

      grid[i] = updateRow(grid[i], j);

      if (i < grid.length - 1) {
        grid[i + 1] = updateRow(grid[i + 1], j);
      }
    }
  }

  return grid;
};
