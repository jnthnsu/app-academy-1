const Game = require('./game.js');


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
