class Clock{
  constructor(){
    this.time = new Date();
    this.hours = this.time.getHours();
    this.minutes = this.time.getMinutes();
    this.seconds = this.time.getSeconds();
  }

  printTime(){
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick(){
    this.seconds++;
    this.printTime();
  }
}

// const clock = new Clock();
// global.setInterval(() => {
//   clock._tick();
// }, 1000);

const readline = require("readline");

// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

function addNumbers(sum, numsLeft, cb){
  if (numsLeft === 0){
    return cb(sum);
  }

  reader.question("Number?", res => {
    sum += parseInt(res);
    return addNumbers(sum, numsLeft - 1, cb);
  });
}

// addNumbers(0, 5, (arg) => {
//   console.log(arg);
//   reader.close();
// });

function askIfGreaterThan(x, y, cb){
  reader.question(`${x} > ${y}?`, res => {
    return cb(res === 'y');
  });
}

function innerBubbleSortLoop(arr, i, swapped, outerBubbleSortLoop){
  if (i === arr.length - 1){
    outerBubbleSortLoop(swapped);
  } else {
    askIfGreaterThan(arr[i], arr[i+1], (toSwap) => {
      if (toSwap){
        [arr[i+1], arr[i]] = [arr[i], arr[i+1]];
        swapped = true;
      }

      innerBubbleSortLoop(arr, i + 1, swapped, outerBubbleSortLoop);
    });
  }
}

function absurdBubbleSort(arr, completionCb ){
  function outerBubbleSortLoop(madeAnySwaps){
    if (madeAnySwaps){
      madeAnySwaps = false;
      innerBubbleSortLoop(arr, 0, madeAnySwaps, outerBubbleSortLoop);
    } else {
      completionCb(arr);
    }
  }

  outerBubbleSortLoop(true);
}

// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });

Function.prototype.myBind = function (context) {
  return () => {
    // Function.prototype.apply(context, this);
    this.apply(context);
  };
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
}

const lamp = new Lamp();

// turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

// boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"
// reader.close();
