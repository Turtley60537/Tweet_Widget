class RestAPI {
  RestAPI() {
    //twitterの初期設定
    //配布時参照不可
    String keys[] = loadStrings("../twitterOathKey.txt");
    //キー設定　自分のキーを入力
    final String consumerKey       = keys[0];
    final String consumerSecret    = keys[1];
    final String accessToken       = keys[2];
    final String accessTokenSecret = keys[3];

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

  void createTweet() {
    //ツイートするところ
    String tweetSentences = "";
    if ( tagCheck.isSelected() && tagField.getText()!=null ) {
      tweetSentences += tagField.getText() + "\n";
    }
    tweetSentences += area.getText();

    try {
      Status status = twitter.updateStatus( tweetSentences );
      println("Successfully updated the status to [" + status.getText() + "].");
      area.setText("");
    }
    catch ( TwitterException ex) {
      println(ex.getStatusCode());
    }
  }
}