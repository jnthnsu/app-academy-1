Array.prototype.my_uniq = function(){
  let result = [];
  this.forEach((el) => {
    if (!result.includes(el)) {result.push(el);}
  });
  return result;
};

Array.prototype.two_sum = function(){
  let result = [];
  this.forEach((el, i) => {
    this.slice(i + 1, this.length).forEach((el2, i2) => {
      if (el === -el2) {
        result.push([i, i + 1 + i2]);
      }
    });
  });
  return result;
};

// Array.prototype.two_sum = function(){
//   let result = [];
//   this.forEach((el, i) => {
//     for (let j = i + 1; j < this.length; j++) {
//       if (el === -this[j]) {
//         result.push([i, j]);
//       }
//     }
//   });
//   return result;
// };

Array.prototype.my_transpose = function() {
  let result = [];
  let newRows = this[0].length;
  let newCols = this.length;

  for (let i = 0; i < newRows; i++){
    result.push(new Array(newCols));
  }

  this.forEach((row, i) => {
    row.forEach((el, j) => {
      result[j][i] = el;
    });
  });
  return result;
};

let a = [-2, 2, 0, 4, 3, -3];
// console.log(a.two_sum());

// let rows = [
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ];
// console.log(rows.my_transpose());


Array.prototype.stockPicker = function(){
  let maxDiff = 0;
  let result = [];

  this.forEach((el, i) => {
    for (let j = i + 1; j < this.length; j++){
      if (this[j] - el > maxDiff){
        maxDiff = this[j] - el;
        result = [i, j];
      }
    }
  });
  return result;
};

// console.log(a.stockPicker());

Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

Array.prototype.myMap = function(callback) {
  let result = [];
  this.myEach( (el) => {
    result.push(callback(el));
  });
  return result;
};

// console.log(a.myMap((i) => i * i));

Array.prototype.myInject = function(callback) {
  let accumulator = this[0];
  this.slice(1).myEach((el) => {
    accumulator = callback(accumulator, el);
  });
  return accumulator;
};

// console.log(a.myInject((acc, i) => acc + i));

Array.prototype.bubbleSort = function() {
  let sorted = false;

  function sort(el, i, arr){
    if (arr[i] > arr[i+1]){
      [arr[i], arr[i+1]] = [arr[i+1], arr[i]];
      sorted = false;
    }
  }

  while (sorted === false){
    sorted = true;
    this.forEach(sort);
  }

  return this;
};

// console.log(a.bubbleSort());

String.prototype.substrings = function() {
  let substrings = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i; j < this.length; j++) {
      substrings.push(this.slice(i,j + 1));
    }
  }
  return substrings;
};

// let string = "wilbur";
// console.log(string.substrings());
function range(start, end){
  if (end <= start + 1) {return [];}

  let lastRange = range(start, end - 1);
  lastRange.push(end - 1);
  return lastRange;
}

// console.log(range(5, 10));

Array.prototype.sum = function(){
  if(this.length === 1) {return this[0];}
  return this.slice(1).sum() + this[0];
};

// console.log(a.sum());

function exp1 (b, n){
  if (n === 0) { return 1; }
  return exp1(b, n - 1) * b;
}

function exp2 (b, n){
  if (n === 0) { return 1; }
  if (n % 2 === 0) {
    let halfExp = exp2(b, n / 2);
    return halfExp * halfExp;
  }
  else {
    let halfExp = exp2(b, (n - 1) / 2);
    return halfExp * halfExp * b;
  }
}

// console.log(exp2(2,3));
// console.log(exp2(2,4));
// console.log(exp2(2,5));
// console.log(exp2(2,0));

function fibonacci(n) {
  if (n === 1) { return [0]; }
  if (n === 2) { return [0, 1]; }
  let lastFib = fibonacci(n - 1);
  let length = lastFib.length;
  return lastFib.concat(lastFib[length - 2] + lastFib[length - 1]);
}

// console.log(fibonacci(10));

function bsearch(arr, target){
  if(arr.length < 1){
    return null;
  }

  let mid = Math.floor(arr.length / 2);
  if (arr[mid] === target){
    return mid;
  }
  else if(arr[mid] < target){
    let idx = bsearch(arr.slice(mid + 1), target);
    if (idx === null){
      return null;
    }
    return idx + mid + 1;
  }
  else {
    return bsearch(arr.slice(0, mid), target);
  }
}

// console.log(bsearch([1, 2, 3], 1));
// console.log(bsearch([2, 3, 4, 5], 3));
// console.log(bsearch([2, 4, 6, 8, 10], 6));
// console.log(bsearch([1, 3, 4, 5, 9], 5));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 6));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 0));
// console.log(bsearch([1, 2, 3, 4, 5, 7], 6));

function makeChange(amount, coins){
  if (amount === 0){
    return [];
  }

  let bestChange = [];
  for (let i = 0; i < coins.length; i++){
    let coin = coins[i];

    if (amount - coin < 0){
      continue;
    }

    let thisChange = [coin].concat(makeChange(amount - coin, coins));
    if (bestChange.length === 0 || thisChange.length < bestChange.length){
      bestChange = thisChange;
    }
  }

  return bestChange;
}

// console.log(makeChange(24, [10, 7, 1]));

function mergeSort(arr){
  if (arr.length === 1){
    return arr;
  }

  let mid = Math.floor(arr.length / 2);
  let leftHalf = arr.slice(0, mid);
  let rightHalf = arr.slice(mid);

  return merge(mergeSort(leftHalf), mergeSort(rightHalf));
}

function merge(arr1, arr2){
  if (arr1.length === 0 || arr2.length === 0){
    return arr1.concat(arr2);
  }
  if (arr1[0] < arr2[0]){
    return [arr1[0]].concat(merge(arr1.slice(1), arr2));
  }
  else {
    return [arr2[0]].concat(merge(arr1, arr2.slice(1)));
  }
}

// console.log(mergeSort(a));

Array.prototype.subsets = function() {
  if (this.length === 0) { return [[]]; }
  let lastSubsets = this.slice(0, this.length - 1).subsets();

  let last = this[this.length - 1];
  let subsets = [];

  lastSubsets.forEach( (el) => {
    subsets.push(el.concat(last));
  });

  return subsets.concat(lastSubsets);
};

// console.log([1,2,3].subsets());

function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  return `${this.owner} love ${this.name}`;
};

let milly = new Cat("Milly", "Nevin");
let george = new Cat("George", "Nevin");
console.log(milly.cuteStatement());
console.log(george.cuteStatement());

Cat.prototype.cuteStatement = function () {
  return `Everyone loves ${this.name}!`;
};

console.log(milly.cuteStatement());
console.log(george.cuteStatement());

Cat.prototype.meow = function () { return `${this.name} meows`; };

console.log(milly.meow());

milly.meow = function(){return `${this.name} MEOWS`;};

console.log(milly.meow());
console.log(george.meow());

function Student(fname, lname){
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

function Course(name, dept, credits, days, timeBlocks){
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.timeBlocks = timeBlocks;
}

Student.prototype.name = function(){
  return `${this.fname} ${this.lname}`;
};

Student.prototype.enroll = function(course){
  if (!this.courses.includes(course)){
    if (this.courses.some((myCourse) => {
      return myCourse.conflictsWith(course);
    })) {throw 'no!';}
    this.courses.push(course);
    course.students.push(this);
  }
};

Student.prototype.courseLoad = function(){
  let courseLoad = {};
  this.courses.forEach((course) => {
    if (courseLoad[course.dept]){
      courseLoad[course.dept] += course.credits;
    }
    else{
      courseLoad[course.dept] = course.credits;
    }
  });
  return courseLoad;
};

Course.prototype.addStudent = function(student){
  student.enroll(this);
};

Course.prototype.conflictsWith = function(otherCourse){
  let sharedDays = this.days.filter((day) => otherCourse.days.includes(day));
  let sharedBlocks = this.timeBlocks.filter((time) => otherCourse.timeBlocks.includes(time));

  return sharedDays.length > 1 && sharedBlocks.length > 1;
};

let bio = new Course('bio', 'sci', 2, ['mon', 'tue'], [1, 4]);
let chem = new Course('chem', 'sci', 2, ['mon', 'tue'], [1, 4]);
let phys = new Course('phys', 'sci', 2, ['mon', 'tue'], [3]);

console.log(bio.conflictsWith(chem));
console.log(bio.conflictsWith(phys));

let s = new Student('a', 'b');
s.enroll(bio);
s.enroll(chem);
