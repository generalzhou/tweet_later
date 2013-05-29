class TweetWorker
    include Sidekiq::Worker

    def perform(tweet_id)
      tweet = Tweet.find(tweet_id)
      user = tweet.user
      user.twitter_client.update(tweet.text)
    end
end
