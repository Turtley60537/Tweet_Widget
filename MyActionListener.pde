//何かアクションがあった時に実行されるクラス ex) ボタンを押す
class MyActionListener implements ActionListener {
  public void actionPerformed(ActionEvent e) {
    println(true);
    String cmd = e.getActionCommand();
    if ( cmd.equals("SendNewTweet") ) {
      if ( scrollPane.isVisible() && area.getText()!=null ) {
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
        
        //ツイートしたら入力欄収納
        smoothCanvas.getFrame().setSize( 140, 140 );
        scrollPane.setVisible ( false );
        tagField.setVisible   ( false );
        tagCheck.setVisible   ( false );
      }
    } else if ( cmd.equals("ViewText") ) {
      if ( scrollPane.isVisible() ) {
        smoothCanvas.getFrame().setSize( 140, 140 );
        scrollPane.setVisible ( false );
        tagField.setVisible   ( false );
        tagCheck.setVisible   ( false );
      } else {
        smoothCanvas.getFrame().setSize( 400, 140 );
        scrollPane.setVisible ( true );
        tagField.setVisible   ( true );
        tagCheck.setVisible   ( true );
      }
    } else if ( cmd.equals("radio1") ) {
      //ウィジェットを常に最上位に表示
      surface.setAlwaysOnTop( true );
      delay(300);
      popup.setVisible( false );
    } else if ( cmd.equals("radio2") ) {
      //ウィジェットを常に最下位に表示
      surface.setAlwaysOnTop( false );
      delay(300);
      popup.setVisible( false );
    }
  }
}