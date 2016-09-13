function HanoiView(game, $el){
  this.game = game;
  this.$el = $el;
  this.render();
  this.move = [];
}

HanoiView.prototype.render = function() {
  $('li').remove();
  $('ul').remove();

  this.game.towers.forEach( (tower, towerIdx) => {
    let $ul = $('<ul></ul>');
    $ul.attr('data-id', `${towerIdx}`);
    $ul.addClass('group');
    this.$el.append($ul); // identify this tower???


    tower.forEach((size, idx) => {
      let $li = $('<li></li>');
      $li.addClass('group');
      $li.css('width', `${tower[tower.length - 1 - idx] * 100}px`);
      $ul.append($li);
    });
  });

  this.bindEvents();
};



HanoiView.prototype.bindEvents = function(){
  $('ul').each((idx, ul) => $(ul).on('click', () => this.makeMove($(ul))));
};


HanoiView.prototype.makeMove = function($ul){
  let tower = $ul.data('id');
  this.move.push(tower);

  if (this.move.length === 2){
    if (this.game.move(...this.move)){
      this.render();
      $('ul').css('border-bottom', 'black 10px solid');
    }
    else{
      alert('invalid move.');
    }
    this.move = [];
  }
  else{
    $ul.css('border-bottom', 'red 10px solid');
  }

  if (this.game.isWon()){
    alert('you win.');
    $('ul').each((idx, ul) => $(ul).off());
  }
};

module.exports = HanoiView;
