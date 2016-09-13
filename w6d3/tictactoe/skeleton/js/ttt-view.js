var View = function (game, $el) {
  this.game = game;
  this.$el = $el;
  this.setupBoard();
  this.bindEvents();
};

View.prototype.bindEvents = function () {
  let $lis = $('li');
  // debugger
  $lis.each( (idx,el) => $(el).on("click", () => this.makeMove($(el) )));

};

View.prototype.makeMove = function ($square) {
  // alert($square.data("id"));
  let pos = $square.data("id").split(",").map( (el) => parseInt(el));
  // debugger

  try{
    this.game.playMove(pos);
    $square.text(this.game.currentPlayer);
  }
  catch(MoveError){
    alert('invalid move.');
  }

  let $h1 = $("<h1></h1>");

  if(this.game.isOver()){
    let winner = this.game.winner();
    if(winner === null){
      $h1.text('Tie!');
    }
    else{
      $h1.text(`${winner} wins!`);
    }

    this.$el.append($h1);
  }
};

View.prototype.setupBoard = function () {
  let $ul = $("<ul></ul>");
  $ul.addClass('group');

  for (let i = 0; i < 9; i++){
    let $li = $("<li></li>");
    $li.attr("data-id", [Math.floor(i / 3), i % 3]);
    $ul.append($li);
  }

  this.$el.append($ul);
};

module.exports = View;
