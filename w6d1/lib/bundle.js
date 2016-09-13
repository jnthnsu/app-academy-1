/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(1);
	const Ship = __webpack_require__(4);
	// const Bullet = require('./bullet.js');
	const Asteroid = __webpack_require__(2);
	const MovingObject = __webpack_require__(5);
	const Util = __webpack_require__(3);
	const GameView = __webpack_require__(6);

	window.addEventListener('DOMContentLoaded', () => {
	  let canvas = document.getElementById('game-canvas');
	  canvas = canvas.getContext('2d');
	  let view = new GameView({ctx: canvas});
	  view.start();
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(2);
	const Ship = __webpack_require__(4);

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


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(3);
	const Ship = __webpack_require__(4);
	const MovingObject = __webpack_require__(5);

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


/***/ },
/* 3 */
/***/ function(module, exports) {

	const Util = {
	  inherits (child, parent){
	    function Surrogate() {}

	    Surrogate.prototype = parent.prototype;
	    child.prototype = new Surrogate();
	    child.prototype.constructor = child;
	  },

	  randomVec (length){
	    let x = Math.random() * Math.pow(length, 2);
	    let y = Math.sqrt(Math.pow(length, 2) - Math.pow(x, 2));
	    return [x, y];
	  },

	  distance (pos1, pos2){
	    return Math.sqrt(Math.pow(pos1[0] - pos2[0], 2) + Math.pow(pos1[1] - pos2[1], 2));
	  }
	};

	module.exports = Util;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(3);
	const MovingObject = __webpack_require__(5);

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


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(3);

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


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(1);


	function GameView(params){
	  this.game = new Game();
	  this.ctx = params['ctx'];
	}

	GameView.prototype.start = function(){
	  let game_view = this;
	  setInterval(() => {
	    game_view.game.step();
	    game_view.game.draw(game_view.ctx);
	  }, 20);
	};





	module.exports = GameView;


/***/ }
/******/ ]);