class TweetsController < ApplicationController
  def create
    if valid_params[:status].present?
      current_user.twitter_client.update valid_params[:status]
      redirect_to current_user
    else
      redirect_to current_user, alert: "Tweet cannot be blank"
    end
  end

  def favorite
    current_user.twitter_client.favorite(params[:id])
    redirect_to current_user
  end

  def unfavorite
    current_user.twitter_client.unfavorite(params[:id])
    redirect_to current_user
  end

  def retweet
    current_user.twitter_client.retweet(params[:id])
    redirect_to current_user
  end

  def search
    @search_query = valid_params[:query]
    @search_results = current_user.twitter_client.search(@search_query)
  end

  def reply
    if valid_params[:status].present?
      current_user.twitter_client.update(valid_params[:status], {in_reply_to_status_id: valid_params[:tweet_id]})
      redirect_to current_user
    else
      redirect_to current_user, alert: "Tweet cannot be blank"
    end
  end

  def refresh
    @tweets = current_user.twitter_client.home_timeline({since_id: params[:id]})
    render layout: false
  end

  def load_more
    # @tweets = JSON.parse(File.read(File.join(Rails.root, "test", "fixtures", "josh_tweets.json"))).map {|t| Hashie::Mash.new(t)}
    @tweets = current_user.twitter_client.home_timeline({max_id: params[:id]})
    render layout: false
  end

  private

  def valid_params
    params.require(:tweet).permit(:status, :query, :tweet_id)
  end
end
