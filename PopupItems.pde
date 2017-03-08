class PopupItems {
  JMenu        afloatMenu;
  ButtonGroup  radioGroup;
  JRadioButton radioButton1, radioButton2;

  JMenu        layoutMenu;
  JCheckBox    tweetUnitCheck, noteUnitCheck;

  PopupItems() {
    popup      = new JPopupMenu();

    //Afloatの設定たち
    afloatMenu = new JMenu("Afloat");

    //Afloat内AlwaysOnTopラジオボタンの初期設定
    radioGroup   = new ButtonGroup ();
    radioButton1 = new JRadioButton ( "Always On Top"        );
    radioButton1.addActionListener  ( new MyActionListener() );
    radioButton1.setActionCommand   ( "radio1"               );
    radioButton1.setSelected        ( true                   );

    //Afloat内Defaultラジオボタンの初期設定
    radioButton2 = new JRadioButton ( "Default"              );
    radioButton2.addActionListener  ( new MyActionListener() );
    radioButton2.setActionCommand   ( "radio2"               );

    //ラジオボタンをグループ化
    radioGroup.add( radioButton1 );
    radioGroup.add( radioButton2 );

    afloatMenu.add( radioButton1 );
    afloatMenu.add( radioButton2 );
    popup.add( afloatMenu );

    //Layoutの設定たち
    layoutMenu     = new JMenu    ( "Layout" );

    //tweetUnitの表示/非表示変更チェックボックスの初期設定
    tweetUnitCheck = new JCheckBox   ( "Tweet Unit"           );
    tweetUnitCheck.addActionListener ( new MyActionListener() );
    tweetUnitCheck.setActionCommand  ( "TweetUnitCheck"       );
    tweetUnitCheck.setSelected       ( true                   );

    //noteUnitの表示/非表示変更チェックボックスの初期設定
    noteUnitCheck  = new JCheckBox   ( "Note Unit"            );
    noteUnitCheck.addActionListener  ( new MyActionListener() );
    noteUnitCheck.setActionCommand   ( "NoteUnitCheck"        );
    noteUnitCheck.setSelected        ( true                   );

    layoutMenu.add( tweetUnitCheck );
    layoutMenu.add( noteUnitCheck  );
    popup.add ( layoutMenu );
  }
  
  //アクション:ウィジェットを常に最上位に表示
  void radio1Action() {
    surface.setAlwaysOnTop( true );
    delay(300);
    popup.setVisible( false );
  }

  //アクション:ウィジェットの表示を元に戻す
  void radio2Action() {
    surface.setAlwaysOnTop( false );
    delay(300);
    popup.setVisible( false );
  }

  //アクション:TweetUnitを表示
  void tweetUnitCheckAction() {
    //押したタイミングではisSelected()は変更後の状態を示す？
    if ( tweetUnitCheck.isSelected() ) {

      tweetUnit.unitSetVisible( true );
      //noteUnitの位置を変更
      noteUnit.unitY  = unitPosY.get(1);
      if ( noteUnit.jotDownButton.isVisible() ) {
        //縦サイズを大きくする
        nowFrameSizeY = setFrameYByUnitsNum.get(1);
        smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
      }
    } else if ( !tweetUnitCheck.isSelected() ) {
      tweetUnit.unitSetVisible( false );
      if ( noteUnit.jotDownButton.isVisible() ) {

        //noteUnitの位置を変更
        noteUnit.unitY = unitPosY.get(0);
        tweetUnit.textPartsSetVisible( false );
        //縦サイズを小さくする
        nowFrameSizeY = setFrameYByUnitsNum.get(0);
        if ( !noteUnit.scrollPane.isVisible() ) {
          //横サイズを小さくする
          nowFrameSizeX = closedFrameSizeX;
        }
      } else if ( !noteUnit.jotDownButton.isVisible() ) {
        nowFrameSizeX = closedFrameSizeX;
      }
      smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
    }
    noteUnit.resetUnitLocation();
  }


  //アクション:NoteUnitを表示
  void noteUnitCheckAction() {
    //押したタイミングではisSelected()は変更後の状態を示す？
    if ( noteUnitCheck.isSelected() ) {
      noteUnit.unitSetVisible( true  );

      if ( tweetUnit.tweetButton.isVisible() ) {
        //noteUnitの位置を変更
        noteUnit.unitY = unitPosY.get(1);
        //縦サイズを大きくする
        nowFrameSizeY = setFrameYByUnitsNum.get(1);
        smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
      } else {
        //noteUnitの位置を変更
        noteUnit.unitY = unitPosY.get(0);
      }
      noteUnit.resetUnitLocation();
    } else if ( !noteUnitCheck.isSelected() ) {
      noteUnit.unitSetVisible     ( false );
      noteUnit.textPartsSetVisible( false );

      if ( tweetUnit.tweetButton.isVisible() ) {
        //縦サイズを小さくする
        nowFrameSizeY = setFrameYByUnitsNum.get(0);
        if ( !tweetUnit.scrollPane.isVisible() ) {
          //横サイズを小さくする
          nowFrameSizeX = closedFrameSizeX;
        }
      } else {
        //横サイズを小さくする
        nowFrameSizeX = closedFrameSizeX;
      }
      smoothCanvas.getFrame().setSize( nowFrameSizeX, nowFrameSizeY-frameGapY );
    }
  }
}