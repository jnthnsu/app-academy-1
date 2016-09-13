export const TONES = {
  C5: 523.25,
  D5: 587.33,
  E5: 659.25,
  F5: 698.46,
  G5: 783.99,
};

export const NOTE_NAMES = Object.keys(TONES);

export const validKeys = ['a', 's', 'd', 'f', 'g'];

export const keyMap = validKeys.reduce((obj, key, idx) => {
  obj[key] = NOTE_NAMES[idx];
  return obj;
}, {});

export const freqToKeyMap = validKeys.reduce((obj, key) => {
  obj[TONES[keyMap[key]]] = key;
  return obj;
}, {});
