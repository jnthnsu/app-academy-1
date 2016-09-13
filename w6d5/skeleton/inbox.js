const MessageStore = require('./message_store.js');

class Inbox{
  constructor(){

  }

  render(){
    let ul = document.createElement('ul');
    ul.className = 'messages';

    MessageStore.getInboxMessages().forEach(message => {
      let element = this.renderMessage(message);
      ul.appendChild(element);
    });

    return ul;
  }

  renderMessage(message){
    let li = document.createElement('li');
    li.className = 'message';

    for(let key in message){
      let span = document.createElement('span');
      span.className = key;
      span.innerHTML = message[key];
      li.appendChild(span);
    }

    return li;
  }
}

module.exports = Inbox;
