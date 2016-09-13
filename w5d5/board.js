class Board{
  constructor(){
    this.grid = [null,null,null].map(() => new Array(3));
  }

  isOver(){
    [].concat(...this.grid).includes(undefined);
  }

  isWon(){
    let returnVal = false;

    ['o', 'x'].forEach(sym => {
      let target = JSON.stringify([sym, sym, sym]);

      this.grid.forEach(row => {
        row = JSON.stringify(row);
        if(row === target){
          returnVal = sym;
        }
      });

      let transposed = [null,null,null].map(() => new Array(3));
      this.grid.forEach((row, i) => {
        row.forEach((el, j) => {
          transposed[j][i] = el;
        });
      });

      transposed.forEach(col => {
        col = JSON.stringify(col);
        if(col === target){
          returnVal = sym;
        }
      });

      let dia1 = JSON.stringify([this.grid[0][0],
        this.grid[1][1], this.grid[2][2]]);
      let dia2 = JSON.stringify([this.grid[0][2],
        this.grid[1][1], this.grid[2][0]]);

      if (dia1 === target || dia2 === target){
        returnVal = sym;
      }
    });

    return returnVal;
  }

  isValid(x, y){
    return this.grid[x][y] === undefined;
  }
}

module.exports = {Board: Board}
