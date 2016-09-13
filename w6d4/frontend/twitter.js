const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');
const TweetCompose = require('./tweet_compose.js');
const InfiniteTweets = require('./infinite_tweets.js');

$(() => {
  $(window).on("insert-tweet", (event, tweet) =>{
    $('#feed').append($('<li>').text(JSON.stringify(tweet.content)));
  });




  $('.follow-toggle').each((idx, el) => {
    new FollowToggle(el);
  });

  new UsersSearch($('.users-search').first(), $('.users').first());
  new TweetCompose($('.tweet-compose').first());
  new InfiniteTweets($('.infinite-tweets').first());
});
