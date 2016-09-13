const Game = require('./game.js');
const Ship = require('./ship.js');
// const Bullet = require('./bullet.js');
const Asteroid = require('./asteroid.js');
const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');
const GameView = require('./game_view.js');

window.addEventListener('DOMContentLoaded', () => {
  let canvas = document.getElementById('game-canvas');
  canvas = canvas.getContext('2d');
  let view = new GameView({ctx: canvas});
  view.start();
});
