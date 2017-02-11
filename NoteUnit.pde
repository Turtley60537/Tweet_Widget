class NoteUnit {

  JButton jotDownButton, viewTextButton;

  JTextArea area;
  JScrollPane scrollPane;

  JButton openNoteButton, templateButton, deleteButton;

  int unitX, unitY;  //まとめて移動するためのx, y
  boolean setTemplateFlag;

  NoteUnit() {
    unitX = 20;
    unitY = unitPosY.get(1);
    setTemplateFlag = false;

    //ノートに書き留めるボタンの初期設定
    jotDownButton = new JButton("Jot Down");
    jotDownButton.setFont           ( new Font("Times New Roman", Font.BOLD, 16) );
    jotDownButton.setForeground     ( new Color( 50, 170, 50 ) );
    jotDownButton.setBackground     ( bgColor                  );
    jotDownButton.setBounds         ( unitX, unitY, 100, 50    );  //要変更
    jotDownButton.addActionListener ( new MyActionListener()   );
    jotDownButton.setActionCommand  ( "JotDown"                );
    layeredPane.add( this.jotDownButton );

    //テキスト欄の表示ボタンの初期設定
    viewTextButton = new JButton("View Text");
    viewTextButton.setFont           ( new Font("Times New Roman", Font.BOLD, 16) );
    viewTextButton.setBackground     ( bgColor                  );
    viewTextButton.setBounds         ( unitX, unitY+50, 100, 50 );
    viewTextButton.addActionListener ( new MyActionListener()   );
    viewTextButton.setActionCommand  ( "NoteViewText"           );
    layeredPane.add( viewTextButton );

    //テキストエリアの初期設定
    area = new JTextArea("");
    area.setLineWrap             ( true );
    area.setWrapStyleWord        ( true );
    scrollPane = new JScrollPane ( area );
    scrollPane.setBounds         ( unitX+100, unitY, 260, 70 ); //要変更
    scrollPane.setVisible        ( false );
    layeredPane.add( this.scrollPane );

    //ノートを開くボタンの初期設定
    openNoteButton = new JButton("Open Note");
    openNoteButton.setFont           ( new Font("Times New Roman", Font.BOLD, 15) );
    openNoteButton.setForeground     ( new Color( 50, 150, 50 )    );
    openNoteButton.setBackground     ( bgColor                     );
    openNoteButton.setBounds         ( unitX+95, unitY+70, 95, 29  ); 
    openNoteButton.addActionListener ( new MyActionListener()      );
    openNoteButton.setActionCommand  ( "OpenNote"                  );
    openNoteButton.setVisible        ( false                       );
    layeredPane.add( this.openNoteButton );

    //マークダウンのテンプレボタンの初期設定
    templateButton = new JButton("Template");
    templateButton.setFont           ( new Font("Times New Roman", Font.BOLD, 15) );
    templateButton.setBackground     ( bgColor                      );
    templateButton.setBounds         ( unitX+188, unitY+70, 120, 29 );
    templateButton.addActionListener ( new MyActionListener()       );
    templateButton.setActionCommand  ( "Template"                   );
    templateButton.setVisible        ( false                        );
    layeredPane.add( templateButton );

    //文字列削除ボタンの初期設定
    deleteButton = new JButton("Delete");
    deleteButton.setFont           ( new Font("Times New Roman", Font.BOLD, 14) );
    deleteButton.setForeground     ( new Color( 150, 50, 50 )    );
    deleteButton.setBackground     ( bgColor                     );
    deleteButton.setBounds         ( unitX+298, unitY+70, 63, 29 );
    deleteButton.addActionListener ( new MyActionListener()      );
    deleteButton.setActionCommand  ( "Delete"                    );
    deleteButton.setVisible        ( false                       );
    layeredPane.add( deleteButton );
  }

  //入力欄の開閉
  void textPartsSetVisible( boolean _bool ) {
    if ( _bool ) {
      this.scrollPane.setVisible     ( true );
      this.openNoteButton.setVisible ( true );
      this.templateButton.setVisible ( true );
      this.deleteButton.setVisible   ( true );
    } else {
      this.scrollPane.setVisible     ( false );
      this.openNoteButton.setVisible ( false );
      this.templateButton.setVisible ( false );
      this.deleteButton.setVisible   ( false );
    }
  }

  //NoteUnit自体の表示/非表示のトグル
  void unitSetVisible( boolean _bool ) {
    if ( _bool ) {
      this.jotDownButton.setVisible  ( true );
      this.viewTextButton.setVisible ( true );
    } else {
      this.jotDownButton.setVisible  ( false );
      this.viewTextButton.setVisible ( false );
      this.scrollPane.setVisible     ( false );
      this.openNoteButton.setVisible ( false );
      this.templateButton.setVisible ( false );
      this.deleteButton.setVisible   ( false );
    }
  }

  //tweetUnitを閉じてるいる時などに、noteUnit自体の位置を変更
  void resetUnitLocation() {
    jotDownButton.setLocation  ( unitX,     unitY    );
    viewTextButton.setLocation ( unitX,     unitY+50 );
    scrollPane.setLocation     ( unitX+100, unitY    );
    openNoteButton.setLocation ( unitX+95,  unitY+70 ); 
    templateButton.setLocation ( unitX+188, unitY+70 );
    deleteButton.setLocation   ( unitX+298, unitY+70 );
  }

  //アクション：ノートに書き留める
  void jotDownButtonAction() {
    if ( !this.scrollPane.isVisible() && this.area.getText().equals("") ) {
      return;
    }
    String [] loadText;

    //ファイルがすでに存在するなら、ロードして新たに付け加えてセーブ
    try {
      /*
       * ●出力例
       * 年/月/日 時:分
       * 本文
       * \n
       */
      loadText = loadStrings("./SaveNote.txt");               //もともと保存されていたメモの配列
      String [] saveText = new String [loadText.length + 1];  //これから保存するメモの配列
      for ( int i=0; i<loadText.length; i++ ) {
        saveText[i] = loadText[i];
      }
      String nowTime = "\n"+ year() +"/"+ month() +"/"+ day() +" "+ hour() +":"+ minute(); //現在時刻
      saveText[loadText.length] = nowTime +"\n"+ this.area.getText() + "\n";
      saveStrings("SaveNote.txt", saveText);
    } 

    //ファイルがまだ存在しなかったら、新しくファイルを作成してセーブ
    //出力例は上に同じ
    catch( Exception e ) {
      println( e );
      PrintWriter saveText = createWriter("./SaveNote.txt");
      String nowTime = year()+"/"+month()+"/"+day()+" "+hour()+":"+minute(); //現在時刻
      saveText.println( nowTime +"\n"+ this.area.getText() + "\n");
      saveText.flush();
      saveText.close();
    }

    this.area.setText("");
    this.textPartsSetVisible       ( false );
    if ( !tweetUnit.scrollPane.isVisible() ) {
      nowFrameSizeX = closedFrameSizeX;
      smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
    }
  }

  //アクション：ノート入力欄開閉
  void viewTextButtonAction() {
    if ( this.scrollPane.isVisible() ) {
      this.textPartsSetVisible       ( false );
      if ( !tweetUnit.scrollPane.isVisible() ) {
        nowFrameSizeX = closedFrameSizeX;
        smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
      }
    } else {
      nowFrameSizeX = openFrameSizeX;
      smoothCanvas.getFrame().setSize ( nowFrameSizeX, nowFrameSizeY-frameGapY );
      this.textPartsSetVisible        ( true );
    }
  }

  //アクション：保存したノートを開く
  void openNoteButtonAction() {
    String [] tempURL = loadStrings("../myurl.txt");
    launch(tempURL);
  }

  //アクション：ノート入力欄にマークダウンのテンプレを記入する
  void templateButtonAction() {
    String template = "";
    template += "# \n";
    template += " * \n";
    template += "## \n";
    template += " * ";
    area.setText( template );

    setTemplateFlag = true;
  }

  //アクション：ノート入力欄の削除する
  void deleteButtonAction() {
    this.area.setText("");

    setTemplateFlag = false;
  }
}