const Coord = require('./coord.js');
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
