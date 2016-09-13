class TweetCompose {
  constructor(el) {
    this.$el = $(el);
    this.$el.on("submit", (e) => this.submit(e));

    this.$el.find('textarea').on('input', (e) => {
      let length = e.originalEvent.srcElement.value.length;
      this.$el.find('.chars-left').text(`${140 - length} chars left`);

      let $submit = this.$el.find("[type='submit']");
      if (length > 140){
        $submit.prop('disabled', true);
      }
      else{
        $submit.prop('disabled', false);
      }
    });
  }

  submit(e) {
    e.preventDefault();
    const passOn = this.$el.serializeJSON();
    this.$el.filter(':input').prop('disabled', true);
    $.ajax({
      url: '/tweets',
      type: 'POST',
      dataType: 'json',
      data: passOn,
      success: (data) => this.handleSuccess(data)
    });
  }

  handleSuccess(data) {
    this.clearInput();

    $(window).trigger('insert-tweet', data);
  }

  clearInput() {
    const $inputs = this.$el.find('.tweet-form');
    $inputs.prop('disabled', false);
    $inputs.val('');
  }
}

module.exports = TweetCompose;
