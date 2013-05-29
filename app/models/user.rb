class User < ActiveRecord::Base
  has_many :tweets

  def twitter_client
    @twitter_client ||= Twitter::Client.new(:oauth_token => self.oauth_token,
                                            :oauth_token_secret => self.oauth_secret)
  end

  def tweet(status)
    tweet = Tweet.create!(:text => status)
    self.tweets << tweet
    tweet.job_id = TweetWorker.perform_async(tweet.id)
  end

  def self.tweet(user_id, status)
    User.find_by_id(user_id).tweet(status)
  end

end
