const Board = require('./board');

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


class Game{
  constructor(){
    this.board = new Board();
    this.players = ['x', 'o'];
  }

  promptMove(cb){
    console.log(this.board);

    reader.question(`${this.players[0]} move?`, move => {
      move = move.split(',').map(el => parseInt(el));
      let [x, y] = move;
      if (this.board.isValid(x, y)){
        cb(x, y, this.players[0]);
      }
      else{
        this.promptMove(cb);
      }
    });
  }

  move(x, y, mark){
    this.board.grid[x][y] = mark;
    return true;
  }

  changePlayer(){
    this.players.unshift(this.players.pop());
  }


  run(completionCb){
    this.promptMove((x, y, mark) => {
      this.move(x, y, mark);
      this.changePlayer();
      if (this.board.isWon()){
        completionCb(this.board.isWon());
      }
      else if (this.board.isOver()){
        completionCb();
      }
      else{
        this.run(completionCb);
      }
    });
  }
}

let g = new Game;
g.run(sym => {
  reader.close();
  console.log(`${sym} won.`);
});
