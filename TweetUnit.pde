class TweetUnit {
  RestAPI restAPI;

  JButton     viewTextButton, tweetButton;

  JTextArea   area;
  JScrollPane scrollPane;

  JTextField  tagField;
  JCheckBox   tagCheck;

  int unitX, unitY;  //まとめて移動するためのx, y

  TweetUnit() {
    restAPI = new RestAPI();

    unitX = 20;
    unitY = unitPosY.get(0);

    //ツイートボタンの初期設定
    tweetButton = new JButton( "Send Tweet" );
    tweetButton.setFont           ( new Font("Times New Roman", Font.BOLD, 16) );
    tweetButton.setForeground     ( new Color( 255, 50, 50 ) );
    tweetButton.setBackground     ( bgColor                  );
    tweetButton.setBounds         ( unitX, unitY, 100, 50    );
    tweetButton.addActionListener ( new MyActionListener()   );
    tweetButton.setActionCommand  ( "SendNewTweet"           );
    layeredPane.add( tweetButton );

    //テキスト欄の表示ボタンの初期設定
    viewTextButton = new JButton("View Text");
    viewTextButton.setFont           ( new Font("Times New Roman", Font.BOLD, 16) );
    viewTextButton.setBackground     ( bgColor                  );
    viewTextButton.setBounds         ( unitX, unitY+50, 100, 50 );
    viewTextButton.addActionListener ( new MyActionListener()   );
    viewTextButton.setActionCommand  ( "TweetViewText"          );
    layeredPane.add( viewTextButton );

    //テキストエリアの初期設定
    area = new JTextArea("");
    area.setLineWrap             ( true );
    area.setWrapStyleWord        ( true );
    scrollPane = new JScrollPane ( area );
    scrollPane.setBounds         ( unitX+100, unitY, 260, 70 );
    scrollPane.setVisible        ( false );
    layeredPane.add( scrollPane );

    //タグの入力欄の初期設定
    tagField = new JTextField("");
    tagField.setBounds        ( unitX+162, unitY+70, 198, 30 );
    tagField.setVisible       ( false );
    layeredPane.add( tagField );

    //タグのチェックボックス
    tagCheck = new JCheckBox( "Tag:" );
    tagCheck.setFont         ( new Font("Times New Roman", Font.BOLD, 14) );
    tagCheck.setForeground   ( new Color(#00ECFF)          );
    tagCheck.setBounds       ( unitX+101, unitY+70, 61, 30 );
    tagCheck.setVisible      ( false                       );
    layeredPane.add( tagCheck );
  }

  //入力欄の開閉の関数
  void textPartsSetVisible( boolean _bool ) {
    if ( _bool ) {
      this.scrollPane.setVisible ( true );
      this.tagField.setVisible   ( true );
      this.tagCheck.setVisible   ( true );
    } else {
      this.scrollPane.setVisible ( false );
      this.tagField.setVisible   ( false );
      this.tagCheck.setVisible   ( false );
    }
  }

  //TweetUnit自体の表示/非表示のトグル
  void unitSetVisible( boolean _bool ) {
    if ( _bool ) {
      this.tweetButton.setVisible    ( true );
      this.viewTextButton.setVisible ( true );
      /*
      this.scrollPane.setVisible     ( true );
       this.tagField.setVisible       ( true );
       this.tagCheck.setVisible       ( true );
       */
    } else {
      this.tweetButton.setVisible    ( false );
      this.viewTextButton.setVisible ( false );
      this.scrollPane.setVisible     ( false );
      this.tagField.setVisible       ( false );
      this.tagCheck.setVisible       ( false );
    }
  }

  //noteUnitを閉じている時などに、tweetUnit自体の位置を変更
  void resetUnitLocation() {
    tweetButton.setLocation    ( unitX    , unitY    );
    viewTextButton.setLocation ( unitX    , unitY+50 );
    scrollPane.setLocation     ( unitX+100, unitY    );
    tagField.setLocation       ( unitX+162, unitY+70 );
    tagCheck.setLocation       ( unitX+101, unitY+70 );
  }

  //アクション：ツイートするところ
  void tweetButtonAction() {
    //area.getText().equals("")が働かない
    if ( !this.scrollPane.isVisible() && this.area.getText().equals("") ) {
      return;
    }
    this.restAPI.createTweet();
    this.textPartsSetVisible ( false );
    if ( !noteUnit.scrollPane.isVisible() ) {
      nowFrameSizeX = closedFrameSizeX;
      smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
    }
  }

  //アクション：ツイート入力欄開閉
  void viewTextButtonAction() {
    if ( this.scrollPane.isVisible() ) {
      this.textPartsSetVisible ( false );
      if ( !noteUnit.scrollPane.isVisible() ) {
        nowFrameSizeX = closedFrameSizeX;
        smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
      }
    } else {
      nowFrameSizeX = openFrameSizeX;
      smoothCanvas.getFrame().setSize ( nowFrameSizeX, nowFrameSizeY-frameGapY );
      this.textPartsSetVisible        ( true );
    }
  }
}