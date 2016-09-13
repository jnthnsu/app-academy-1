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
