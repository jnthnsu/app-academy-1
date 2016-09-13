function sum(){
  let args = Array.prototype.slice.call(arguments);
  return args.reduce((a, b) => a + b, 0);
}
//
// console.log(sum(1, 2, 3, 4) === 10,
//     sum(1, 2, 3, 4, 5) === 15);

Function.prototype.myBind = function(context){
  let args1 = Array.from(arguments);
  let parent = this;
  return function(){
    let args2 = Array.from(arguments);
    parent.apply(context, args1.slice(1).concat(args2));
  };
};

// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }
//
// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// markov.says.myBind(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// markov.says.myBind(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// markov.says.myBind(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true

Function.prototype.curry = function(numArgs){
  let args = [];
  let originalFunc = this;
  
  function _curry(num){
    args.push(num);
    if (args.length === numArgs){
      return originalFunc(...args);
    }
    else{
      return _curry;
    }
  }

  return _curry;

  // let args1 = Array.from(arguments);
  // let parent = this;
  //
  // if (args1.length === args1[0] + 1){
  //   return parent(...args1.slice(1));
  // }
  // else{
  //   return function(){
  //     let args2 = Array.from(arguments);
  //     return parent.curry(...args1.concat(args2));
  //   };
  // }
};



  // var numbers = this.numbers ? numbers : [];
  // var numArgs = this.numArgs ? numArgs : null;
  //
  // console.log(numbers, numArgs);
  // numArgs === null ? numArgs = num : numbers.push(num);
  //
  // console.log(numbers, numArgs);
  //
  // if (numbers.length === numArgs){
  //   return this.call(numbers);
  // }
  //
  // return this;


function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

// you'll write `Function#curry`!
// const f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
// f1 = f1(4); // [Function]
// f1 = f1(20); // [Function]
// f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
