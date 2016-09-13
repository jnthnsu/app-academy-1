class Coord {
  constructor(arr) {
    [this.x, this.y] = arr;
  }

  plus(direction) {
    return new Coord([this.x + direction.x,this.y + direction.y]);
  }

  equals(coord) {
    return (this.x === coord.x && this.y === coord.y);
  }

  isOpposite(coord) {
    return (this.x === -(coord.x) && this.y === -(coord.y));
  }
}//class

module.exports = Coord;
