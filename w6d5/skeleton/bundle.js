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

	// Require your Router constructor.
	// Modify the DOMContentLoaded callback:
	// Get the .content DOM Node with document.querySelector. This is DOM Node we'll be updating with the Router.
	// Create a new Router, passing in the .content node.
	// start() your new router.
	// Test that clicking on the sidebar items changes the content of the page AND that we are not making new HTTP requests.


	let Router = __webpack_require__(1);
	let Inbox = __webpack_require__(2);
	let Sent = __webpack_require__(4);

	document.addEventListener('DOMContentLoaded', e => {

	  let links = Array.from(document.querySelectorAll('.sidebar-nav > li'));

	  links.forEach(function(li) {
	    li.addEventListener("click", () => {
	      window.location.hash = li.innerText.toLowerCase();
	    });
	  });

	  let container = document.querySelector('.content');

	  let routes = {inbox: new Inbox(), sent: new Sent()};

	  let router = new Router(container, routes);
	  router.start();
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Router {

	  constructor(node, routes) {
	    this.node = node;
	    this.routes = routes;

	    window.addEventListener('hashchange', this.render.bind(this));
	  }

	  start() {
	    window.location.hash = 'inbox';
	    this.render();
	  }

	  activeRoute() {
	    return this.routes[window.location.hash.slice(1)];
	  }

	  render() {
	    this.node.innerHTML = "";
	    let component = this.activeRoute();

	    if (component !== undefined){
	      let route = document.createElement("p");
	      let element = component.render();
	      this.node.appendChild(element);
	    }
	  }
	}


	module.exports = Router;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

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


/***/ },
/* 3 */
/***/ function(module, exports) {

	const MessageStore = {
	  messages: {
	    sent: [
	      {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
	      {to: "person@mail.com", subject: "zzz", body: "so booring"}
	    ],
	    inbox: [
	      {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body:
	  "Stay at home mom discovers cure for leg cramps. Doctors hate her"},
	    {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"}
	    ]
	  },

	  getInboxMessages: function(){
	    return this.messages.inbox;
	  },

	  getSentMessages: function(){
	    return this.messages.sent;
	  }
	};

	class Message{
	  constructor(from, to, subject, body){
	    this.from = from;
	    this.to = to;
	    this.subject = subject;
	    this.body = body;

	    this.messageDraft = new Message();
	  }

	  updateDraftField(field, value){
	    Object.defineProperty(this.messageDraft, field).set(value);
	    MessageStore.sent.push(this.messageDraft);
	    this.messageDraft = new Message();
	  }
	}

	module.exports = MessageStore;
	module.exports = Message;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	class Sent{
	  constructor(){

	  }

	  render(){
	    let ul = document.createElement('ul');
	    ul.className = 'messages';

	    MessageStore.getSentMessages().forEach(message => {
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

	module.exports = Sent;


/***/ }
/******/ ]);