const Coord = require('./coord.js');

class Snake {
  constructor() {
    this.direction = new Coord([-1,0]);
    this.segments = [];
  }

  move() {
    this.segments.unshift(this.segments[0].plus(this.direction));
    this.segments.pop();
  }


  turn(dir) {
    if (!this.direction.isOpposite(dir)) {
      this.direction = dir;
    }
  }
}//class

module.exports = Snake;
