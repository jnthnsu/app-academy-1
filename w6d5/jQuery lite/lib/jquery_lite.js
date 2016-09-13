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

	const DOMNodeCollection = __webpack_require__(1);

	window.$l = function(input){
	  if (typeof input === 'string'){
	    return new DOMNodeCollection(Array.from(document.querySelectorAll(input)));
	  }
	  else if(typeof input === 'object'){
	    return new DOMNodeCollection([input]);
	  }
	  else if(typeof input === 'function'){
	    let functions = [];
	    functions.push(input);

	    document.addEventListener('DOMContentLoaded', () => {
	      functions.forEach(fn => {
	        fn();
	      });
	    });

	    return (...args) => {
	      functions.concat(args);

	      document.addEventListener('DOMContentLoaded', () => {
	        functions.forEach(fn => {
	          fn();
	        });
	      });
	    };
	  }
	};

	window.$l.extend = function(...objs){
	  let result = {};
	  objs.forEach(obj => {
	    for (let key in obj){
	      result[key] = obj[key];
	    }
	  });
	  return result;
	};

	window.$l.ajax = function(options){
	  let defaults = {
	    success: () => {},
	    error: () => {},
	    url: window.location.href,
	    method: 'GET',
	    data: {},
	    dataType: 'json',
	    contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
	  };

	  options = window.$l.extend(defaults, options);

	  const xhr = new XMLHttpRequest();
	  xhr.open(options['method'], options['url']);

	  if (xhr.status === 200){
	    options['success'](JSON.parse(xhr.response));
	  }
	  else{
	    options['error'](JSON.parse(xhr.response));
	  }

	  xhr.send(options['data']);
	};


/***/ },
/* 1 */
/***/ function(module, exports) {

	class DOMNodeCollection{
	  constructor(arr){
	    this.arr = arr;
	  }

	  html(str){
	    if(str === undefined){
	      return this.arr[0].innerHTML;
	    }
	    else{
	      this.arr.forEach(node => {
	        node.innerHTML = str;
	      });
	    }
	  }

	  empty(){
	    this.html('');
	  }

	  append(child){
	    this.arr.forEach(node => {
	      node.innerHTML.concat(child.outerHTML);
	    });
	  }

	  attr(attr_get, val){
	    if (val === undefined){
	      return this.arr[0].attributes[attr_get];
	    }
	    else{
	      this.arr.forEach(node => {
	        node.setAttribute(attr_get, val);
	      });
	    }
	  }

	  addClass(nodeClass) {
	    this.arr.forEach(node => {
	      node.classList.add(nodeClass);
	    });
	  }

	  removeClass(nodeClass) {
	    this.arr.forEach(node => {
	      node.classList.remove(nodeClass);
	    });
	  }

	  children() {
	    let childrenArr = this.arr.reduce([], function(arr, node) {
	      arr.concat(node.children);
	    });

	    return new DOMNodeCollection(childrenArr);
	  }

	  parent() {
	    let parentArr = this.arr.reduce([], function(arr, node) {
	      arr.concat(node.parent);
	    });

	    let uniqueParents = parentArr.uniq();

	    return new DOMNodeCollection(uniqueParents);
	  }

	  find(selector) {
	    let resultArr = this.arr.reduce([], function(arr, node) {
	      arr.concat(node.querySelectorAll(selector));
	    });

	    let descendants = resultArr.uniq();

	    return resultArr;
	  }

	  remove(){
	    this.arr.forEach(node => {
	      node.outerHTML = '';
	    });

	    this.arr = [];
	  }

	  on(event, cb){
	    this.arr.forEach(node => {
	      node.addEventListener(event, cb);
	    });
	  }

	  off(event, cb){
	    this.arr.forEach(node => {
	      node.removeEventListener(event, cb);
	    });
	  }




	}

	module.exports = DOMNodeCollection;


/***/ }
/******/ ]);