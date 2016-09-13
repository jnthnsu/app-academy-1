class InfiniteTweets{
  constructor(el){
    this.$el = $(el);
    this.max_created_at;

    this.$el.find('a').on('click', () => {
      this.fetchTweets();
    });
  }

  fetchTweets(){
    $.ajax({
      url: '/feed',
      type: 'GET',
      dataType: 'json',
      data: {max_created_at: this.max_created_at},


      success: (data) => {
        if (data.length < 20){
          this.$el.find('a').remove();
          this.$el.append($('<span>').text('No More Tweets'));
        }
        else{
          this.max_created_at = data.slice(-2)[0].created_at;
          data.forEach(el => {
            $(window).trigger('insert-tweet', el);
          });
        }
      }
    });
  }
}

module.exports = InfiniteTweets;
