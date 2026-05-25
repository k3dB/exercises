export function frontDoorResponse(line) {
  return line.slice(0, 1);
}

export function frontDoorPassword(word) {
  return capitalize(word);
}

export function backDoorResponse(line) {
  return line.trim().slice(-1);
}

export function backDoorPassword(word) {
  return `${capitalize(word)}, please`;
}

function capitalize(word) {
  let start = word.slice(0, 1).toUpperCase();
  let end   = word.slice(1).toLowerCase();

  return start + end;
}
