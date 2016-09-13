const Snake = require('./snake.js');
const Coord = require('./coord.js');


class Board {
  constructor(n = 40) {
    this.snake = new Snake();
    this.apples = [];
    this.side = n;
    // this.grid = this.generateGrid();

    this.snake.segments = [new Coord([Math.floor(n / 2), Math.floor(n / 2)])];
  }

  // generateGrid(n = 10) {
  //   return new Array(n).fill(new Array(n));
  // }

  step(){
    this.snake.move();
  }
} //class

module.exports = Board;
