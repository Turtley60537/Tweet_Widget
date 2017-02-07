class OAuthRestAPI {
  OAuthRestAPI(String consumerKey, String consumerSecret, String accessToken, String accessTokenSecret) {
    //Configurationを生成するためのビルダーオブジェクトを生成
    ConfigurationBuilder cb = new ConfigurationBuilder();

    //キー設定
    cb.setOAuthConsumerKey       ( consumerKey       );
    cb.setOAuthConsumerSecret    ( consumerSecret    );
    cb.setOAuthAccessToken       ( accessToken       );
    cb.setOAuthAccessTokenSecret ( accessTokenSecret );

    //Twitterのインスタンスを生成
    twitter = new TwitterFactory(cb.build()).getInstance();
  }
}