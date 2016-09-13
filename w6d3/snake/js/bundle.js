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

	const Board = __webpack_require__(1);
	const SnakeView = __webpack_require__(4);

	$( () => {
	  const rootEl = $('.snake');
	  const board = new Board();
	  let view = new SnakeView(board, rootEl);
	  setInterval(() => {
	    view.step();
	  }, 500);
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Snake = __webpack_require__(2);
	const Coord = __webpack_require__(3);


	class Board {
	  constructor(n = 40) {
	    this.snake = new Snake();
	    this.apples = [];
	    this.side = n;
	    // this.grid = this.generateGrid();

	    this.snake.segments = [new Coord([Math.floor(n / 2), Math.floor(n / 2)])];
	  }

	  // generateGrid(n = 10) {
	  //   return new Array(n).fill(new Array(n));
	  // }

	  step(){
	    this.snake.move();
	  }
	} //class

	module.exports = Board;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Coord = __webpack_require__(3);

	class Snake {
	  constructor() {
	    this.direction = new Coord([-1,0]);
	    this.segments = [];
	  }

	  move() {
	    this.segments.unshift(this.segments[0].plus(this.direction));
	    this.segments.pop();
	  }


	  turn(dir) {
	    if (!this.direction.isOpposite(dir)) {
	      this.direction = dir;
	    }
	  }
	}//class

	module.exports = Snake;


/***/ },
/* 3 */
/***/ function(module, exports) {

	class Coord {
	  constructor(arr) {
	    [this.x, this.y] = arr;
	  }

	  plus(direction) {
	    return new Coord([this.x + direction.x,this.y + direction.y]);
	  }

	  equals(coord) {
	    return (this.x === coord.x && this.y === coord.y);
	  }

	  isOpposite(coord) {
	    return (this.x === -(coord.x) && this.y === -(coord.y));
	  }
	}//class

	module.exports = Coord;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const Coord = __webpack_require__(3);
	class SnakeView{
	  constructor(board, $el){
	    this.board = board;
	    this.$el = $el;

	    this.setupBoard();
	    this.render();

	    let view = this;

	    $(window).on('keydown', event => {
	      view.handleEvent(event);
	    });
	  }

	  setupBoard(){
	    let side = this.board.side;

	    let $ul = $('<ul></ul>');
	    $ul.addClass('group');
	    $ul.css('width', `${side * 15}px`);
	    $ul.css('height', `${side * 15}px`);
	    this.$el.append($ul);

	    for (let i = 0; i < Math.pow(side, 2); i++){
	      let $li = $('<li></li>');
	      $li.attr('id', `${Math.floor(i / side)}-${i % side}`);

	      $ul.append($li);
	    }
	  }

	  render(){
	    $('li').css('background-color', 'white');
	    this.board.snake.segments.forEach(coord => {
	      $(`#${coord.x}-${coord.y}`).css('background-color', 'green');
	    });
	    this.board.apples.forEach(coord => {
	      $(`#${coord.x}-${coord.y}`).css('background-color', 'red');
	    });
	  }

	  step(){
	    this.board.step();
	    this.render();
	  }

	  handleEvent(event){
	    switch(event.key){
	      case 'ArrowDown':
	        this.board.snake.turn(new Coord([1,0]));
	        break;
	      case 'ArrowRight':
	        this.board.snake.turn(new Coord([0,1]));
	        break;
	      case 'ArrowUp':
	        this.board.snake.turn(new Coord([-1,0]));
	        break;
	      case 'ArrowLeft':
	        this.board.snake.turn(new Coord([0,-1]));
	        break;
	      }
	  }
	}

	module.exports = SnakeView;


/***/ }
/******/ ]);