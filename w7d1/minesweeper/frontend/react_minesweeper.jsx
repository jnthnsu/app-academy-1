import React from 'react';
import ReactDOM from 'react-dom';
import {Board, Tile} from './minesweeper';

class Game extends React.Component{
  constructor(){
    super();
    this.state = {board: new Board(9, 10)};
  }

  updateGame(tile, action) {
    if (action === "R") {
      tile.explore();
    } else {
      tile.toggleFlag();
    }
  }

  render(){
    return (
      <div className='board'>
        <ReactBoard
          board={this.state.board}
          updateGame= {this.updateGame.bind(this)}
        />
      </div>
    );
  }
}

const ReactBoard = ({board, updateGame}) => {
  let tiles = board.grid.reduce((prev, curr) => {
    return prev.concat(curr);
  }, []);


  tiles = tiles.map(tile => (
    <li key={tile.pos} className='tile'>
      <ReactTile tile={tile} updateGame={updateGame}/>
    </li>
  ));



  return (
    <ul>
      {tiles}
    </ul>
  );
};


const ReactTile = ({tile, updateGame}) => {
  let tileText = "";

  if (tile.explored) {
    if (tile.bombed) {
      tileText = "B";
    } else {
      tileText = tile.adjacentBombCount() === 0 ? "-"
        : tile.adjacentBombCount();
    }
  } else if (tile.flagged) {
    tileText = "F";
  }

  return (
    <div onClick={updateGame(tile, "R")}>{tileText}</div>
  );
};

export {Game};
