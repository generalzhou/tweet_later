get '/' do
  @user = current_user
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do

  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # @user = User.find_or_create_by_username()
  @user = User.find_or_create_by_oauth_token_and_oauth_secret(:oauth_token => @access_token.token, :oauth_secret => @access_token.secret)
  session[:user_id] = @user.id
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token

  redirect '/'
  
end

get '/status/:job_id' do
  @job_id = params[:job_id]
  erb :status
end

post '/status/:job_id' do
  job_status(params[:job_id])
end

post '/tweet' do
  job_id = current_user.tweet(params[:tweet])
  redirect to "/status/#{job_id}"
end

post '/tweet_later' do
  user_id = current_user.id
  job_id = User.delay_for(params[:delay].to_i.seconds).tweet(user_id, params[:tweet])

  # User.delay_for(20.seconds).tweet(user.id, 'this is a test')
  
  redirect to "/status/#{job_id}"
end
