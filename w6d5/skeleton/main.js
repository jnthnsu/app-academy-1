// Require your Router constructor.
// Modify the DOMContentLoaded callback:
// Get the .content DOM Node with document.querySelector. This is DOM Node we'll be updating with the Router.
// Create a new Router, passing in the .content node.
// start() your new router.
// Test that clicking on the sidebar items changes the content of the page AND that we are not making new HTTP requests.


let Router = require('./router.js');
let Inbox = require('./inbox.js');
let Sent = require('./sent.js');

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
