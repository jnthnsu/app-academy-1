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
