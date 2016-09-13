Function.prototype.inherits = function (parent) {
  function Surrogate() {}

  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject () {
  this.hello = function() {
    console.log("hello");
  };
}

function Ship () {

}

function Asteroid () {

}

Ship.inherits(MovingObject);
Asteroid.inherits(MovingObject);

MovingObject.prototype.hello = function(){
  console.log("hello");
};

Ship.prototype.hey = function() {
  console.log("hey!");
};

let mo = new MovingObject();
let ship = new Ship();
let asteroid = new Asteroid();


ship.hello();
