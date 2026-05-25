export function frontDoorResponse(line) {
  return line[0];
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
  let start = word[0].toUpperCase();
  let end   = word.slice(1).toLowerCase();

  return start + end;
}
