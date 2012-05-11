class Authentication < ActiveRecord::Base
  belongs_to :user
  serialize :access_token
  
  attr_accessible :provider, :uid
  
  TWITTER_TAG = " #justhateit"
  
  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end
  
  def update_token(omniauth)
    self.access_token = omniauth['extra']['access_token']
  end
  
  def upadte_tokens!(omniauth)
    self.update_token(omniauth)
    save!
  end
  
  def post(message)
    send("post_to_#{self.provider}", message)
  end
  
protected
  def post_to_twitter(message)
    tweet = message[0..(140-TWITTER_TAG.length)] + TWITTER_TAG
    result = self.access_token.post("http://api.twitter.com/1/statuses/update.json", {:status => tweet})
    
    ActiveRecord::Base.logger.info "Twitter post result (#{result.code}): #{result.body}"
  end
  
  def post_to_facebook(message)
    me = FbGraph::User.me(self.tokens[:access_token])
    me.feed!(
      :message => message,
      #:picture => 'https://graph.facebook.com/matake/picture',
      :link => root_url,
      #:name => 'FbGraph',
      #:description => 'A Ruby wrapper for Facebook Graph API'
    )
    
    #result = self.access_token.post("https://graph.facebook.com/me/feed", {
    #  :message => message,
    #  :link => root_url
    #})
    
    #ActiveRecord::Base.logger.info "Twitter post result (#{result.code}): #{result.body}"
  end
end
