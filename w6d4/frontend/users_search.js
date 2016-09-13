const FollowToggle = require('./follow_toggle.js');

class UsersSearch {
  constructor(el, ul) {
    this.$el = el;
    this.$ul = ul;

    this.$el.on("input", event => this.handleInput(event));
    $('.add-mention').on('click', () => this.addMention());
  }

  addMention(){
    let $li = $('<li>');
    $li.append($('.mention-script').html());

    let $a = $('<a>');
    $a.attr('href', "javascript:void(0)");
    $a.text("Remove Mention");
    $a.on('click', () => {
      $a.parent().children().remove();
    });


    $('.mentions').append($li.append($a));
  }

  handleInput(event) {
    const query = event.currentTarget.children[0].value;
    $.ajax({
      url: '/users/search/',
      type: "GET",
      dataType: 'json',
      data: { query: query },
      success: data => {
        this.$ul.children().remove();
        for(let i = 0; i< data.length; i++) {
          console.log(data[i].followed);
          let $li = $('<li>');
          let $a = $('<a>');
          let $button = $('<button>');
          const state = data[i].followed ? "followed" : "unfollowed";
          new FollowToggle($button, { userId: data[i].id, followState: state });
          $a.attr("href", `/users/${data[i].id}`).text(data[i].username);
          $li.append($a).append($button).appendTo(this.$ul);
        }
      }
    });
  }
}

module.exports = UsersSearch;
