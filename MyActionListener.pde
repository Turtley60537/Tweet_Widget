//何かアクションがあった時に実行されるクラス ex) ボタンを押す

class MyActionListener implements ActionListener {

  public void actionPerformed(ActionEvent e) {

    //println(true);
    String cmd = e.getActionCommand();

    //ツイートするところ
    if      ( cmd.equals("SendNewTweet") )  tweetUnit.tweetButtonAction();

    //ツイート入力欄開閉
    else if ( cmd.equals("TweetViewText") ) tweetUnit.viewTextButtonAction();

    //ノートに書き留める
    else if ( cmd.equals("JotDown")      ) noteUnit.jotDownButtonAction();

    //ノート入力欄開閉
    else if ( cmd.equals("NoteViewText") ) noteUnit.viewTextButtonAction();

    //保存したノートを開く
    else if ( cmd.equals("OpenNote")     ) noteUnit.openNoteButtonAction();

    //ノート入力欄にマークダウンのテンプレを記入
    else if ( cmd.equals("Template")     ) noteUnit.templateButtonAction();

    //ノート入力欄の削除
    else if ( cmd.equals("Delete")       ) noteUnit.deleteButtonAction();

    //ウィジェットを常に最上位に表示
    else if ( cmd.equals("radio1") ) popupItems.radio1Action();

    //ウィジェットの表示を元に戻す
    else if ( cmd.equals("radio2") ) popupItems.radio2Action();

    //TweetUnitを表示
    else if ( cmd.equals("TweetUnitCheck") ) popupItems.tweetUnitCheckAction();

    //NoteUnitを表示
    else if ( cmd.equals("NoteUnitCheck")  ) popupItems.noteUnitCheckAction();
  }
}