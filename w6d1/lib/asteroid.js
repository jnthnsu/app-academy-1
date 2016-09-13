const Util = require('./utils.js');
const Ship = require('./ship.js');
const MovingObject = require('./moving_object.js');

function Asteroid(params) {
  this.pos = params['pos'];
  this.vel = Util.randomVec(2);
  this.color = "purple";
  this.radius = 20;
  this.game = params['game'];
}

Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function(otherObject){
  if (otherObject instanceof Ship){
    otherObject.relocate();
  }
};

module.exports = Asteroid;
