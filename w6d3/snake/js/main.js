const Board = require('./board.js');
const SnakeView = require('./snake_view.js');

$( () => {
  const rootEl = $('.snake');
  const board = new Board();
  let view = new SnakeView(board, rootEl);
  setInterval(() => {
    view.step();
  }, 500);
});
