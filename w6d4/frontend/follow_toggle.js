class FollowToggle{
  constructor(el, options){
    this.$el = $(el);
    this.userId = (this.$el.data('user-id') || options.userId);
    this.followState = (this.$el.data('initial-follow-state')|| options.followState);

    this.render();
    this.handleClick();
  }

  render(){
    if(this.followState.slice(-3) === 'ing'){
      this.$el.prop('disabled', true);
      return;
    }
    else{
      let text = this.followState === 'followed' ? 'Unfollow!' : 'Follow!';
      this.$el.text(text);
      this.$el.prop('disabled', false);
    }
  }


  handleClick(){
    this.$el.click(event => {
      console.log(event);
      event.preventDefault();

      this.followState = this.followState.slice(0, -2).concat('ing');
      this.render();

      if (this.followState === 'unfollowing'){
        $.ajax({
          url: `/users/${this.userId}/follow`,
          type: `POST`,
          dataType: 'json',

          success: date => {
            this.followState = 'followed';
            this.render();
          }
        });
      }
      else{
        $.ajax({
          url: `/users/${this.userId}/follow`,
          type: `DELETE`,
          dataType: 'json',

          success: data => {
            this.followState = 'unfollowed';
            this.render();
          }
        });
      }

    });
  }
}

module.exports = FollowToggle;
