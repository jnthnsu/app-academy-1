const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {
  constructor() {
    this.stacks = [[3, 2, 1], [], []];
  }

  promptMove(cb) {
    console.log(JSON.stringify(this.stacks));

    reader.question("Which stack do you want to pop from?", res1 => {
      reader.question("Which stack do you want to move to?", res2 => {
        if (this.isValidMove(parseInt(res1), parseInt(res2))) {
          cb(res1, res2);
        }
        else{
          this.promptMove(cb);
        }
      });
    });
  }

  isValidMove(start, end) {
    let popStack = this.stacks[start];
    let pushStack = this.stacks[end];

    if (popStack.length === 0) {
      return false;
    } else if (pushStack.length === 0) {
      return true;
    }

    return popStack.slice(-1)[0] < pushStack.slice(-1)[0];
  }

  move(start, end) {
    this.stacks[end].push(this.stacks[start].pop());
    return true;
  }

  isWon(){
    let target = JSON.stringify([3,2,1]);
    if (JSON.stringify(this.stacks[1]) === target ||
      JSON.stringify(this.stacks[2]) === target){
      return true;
    }
    return false;
  }

  run(completedCb) {
    this.promptMove((res1, res2) => {
      if (this.move(res1, res2)){
        if (this.isWon()){
          completedCb();
        }
        else{
          this.run(completedCb);
        }
      }
    });
  }
}

let g = new Game();
g.run(() => {
  reader.close();
  console.log('cool');
});
