const Util = require('./utils.js');

function MovingObject(params){
  this.pos = params['pos'];
  this.vel = params['vel'];
  this.radius = params['radius'];
  this.color = params['color'];
}

MovingObject.prototype.draw = function(ctx){
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

MovingObject.prototype.move = function() {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];

  this.pos = this.game.wrap(this.pos);
};

MovingObject.prototype.isCollidedWith = function(otherObject){
  return Util.distance(this.pos, otherObject.pos) < (this.radius + otherObject.radius);
};

MovingObject.prototype.collideWith = function(otherObject){
  // this.game.remove(otherObject);
  // this.game.remove(this);
};

module.exports = MovingObject;
