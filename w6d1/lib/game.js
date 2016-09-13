const Asteroid = require('./asteroid.js');
const Ship = require('./ship.js');

function Game () {
  this.DIM_X = 1000;
  this.DIM_Y = 1000;
  this.NUM_ASTEROIDS = 25;
  this.asteroids = [];

  this.addAsteroids();

  this.ship = new Ship({game: this});
  this.ship.pos = this.randomPosition();
}

Game.prototype.addAsteroids = function() {
  for(let i = 0; i < this.NUM_ASTEROIDS; i ++) {
    let newAsteroid = new Asteroid({ pos: this.randomPosition(), game: this });
    this.asteroids.push(newAsteroid);
  }
};

Game.prototype.allObjects = function(){
  return this.asteroids.concat(this.ship);
};

Game.prototype.randomPosition = function() {
  let randomX = Math.random() * this.DIM_X;
  let randomY = Math.random() * this.DIM_Y;
  return [randomX, randomY];
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
  this.allObjects().forEach(asteroid => asteroid.draw(ctx));
};

Game.prototype.moveObjects = function() {
  this.allObjects().forEach(asteroid => asteroid.move());
};

Game.prototype.wrap = function(pos){
  return [pos[0] % this.DIM_X, pos[1] % this.DIM_Y];
};

Game.prototype.checkCollisions = function(){
  this.allObjects().forEach( asteroid => {
    this.allObjects().filter(otherAsteroid => otherAsteroid !== asteroid).forEach( otherAsteroid => {
      if (asteroid.isCollidedWith(otherAsteroid)){
        asteroid.collideWith(otherAsteroid);
        // alert('COLLISION');
      }
    });
  });
};

Game.prototype.step = function(){
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function(asteroid){
  this.asteroids = this.asteroids.filter(otherAsteroid => otherAsteroid !== asteroid);
};

module.exports = Game;
