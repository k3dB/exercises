const secrets = [
  { flag: 1 << 0, action: (a) => a.push('wink')            },
  { flag: 1 << 1, action: (a) => a.push('double blink')    },
  { flag: 1 << 2, action: (a) => a.push('close your eyes') },
  { flag: 1 << 3, action: (a) => a.push('jump')            },
  { flag: 1 << 4, action: (a) => a.reverse()               }
];

export const commands = (bitmask) => {
  let actions = [];

  secrets
    .filter(s => bitmask & s.flag)
    .forEach(s => s.action(actions));

  return actions;
};
