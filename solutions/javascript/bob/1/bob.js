const isSilence = (message) => !message.match(/[^\s]+/g);

const isShouting = (message) => {
  return (
        message.match(/[A-Z]+/g)
    && !message.match(/[a-z]+/g)
  );
};

const isQuestion = (message) => message.trim().endsWith('?');

export const hey = (message) => {
  if (isSilence(message)) {
    return 'Fine. Be that way!';
  }

  if (isShouting(message) && isQuestion(message)) {
    return "Calm down, I know what I'm doing!"
  }

  if (isShouting(message)) {
    return 'Whoa, chill out!';
  }

  if (isQuestion(message)) {
    return 'Sure.'
  }

  return 'Whatever.';
};
