const WINK         = 'wink';
const DOUBLE_BLINK = 'double blink';
const CLOSE_EYES   = 'close your eyes';
const JUMP         = 'jump';

const FLAGS = {
  wink:        1 << 0,
  doubleBlink: 1 << 1,
  closeEyes:   1 << 2,
  jump:        1 << 3,
  reverse:     1 << 4
};

export const commands = (bitmask) => {
  let actions = [];

  if (bitmask & FLAGS.wink)        actions.push(WINK);
  if (bitmask & FLAGS.doubleBlink) actions.push(DOUBLE_BLINK);
  if (bitmask & FLAGS.closeEyes)   actions.push(CLOSE_EYES);
  if (bitmask & FLAGS.jump)        actions.push(JUMP);

  return (
    bitmask & FLAGS.reverse
      ? actions.reverse()
      : actions
  );
};
