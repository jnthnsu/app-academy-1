const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');

function Ship(params){
  this.radius = 20;
  this.color = 'red';
  this.vel = [0,0];
  this.pos = [0,0];
  this.game = params['game'];
}

Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function (){
  this.pos = this.game.randomPosition();
  this.vel = [0,0];
};

Ship.prototype.collideWith = function(otherObject){
  // this.game.remove(otherObject);
  // this.game.remove(this);
};

module.exports = Ship;
