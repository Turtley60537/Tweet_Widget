import twitter4j.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.http.*;
import twitter4j.internal.async.*;
import twitter4j.internal.http.*;
import twitter4j.internal.logging.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.util.*;
import twitter4j.util.*;

import java.awt.*;
import java.awt.event.*;
import java.awt.event.ActionListener;

import javax.swing.*;
import javax.swing.ImageIcon;

import processing.awt.PSurfaceAWT;

Twitter twitter;
OAuthRestAPI restAPI;

PSurfaceAWT awtSurface;
PSurfaceAWT.SmoothCanvas smoothCanvas;

JTextArea    area;
JLayeredPane pane;
JScrollPane  scrollPane;

JTextField   tagField;
JCheckBox    tagCheck;
JButton      viewTextButton, tweetButton;

JPopupMenu   popup;
ButtonGroup  radioGroup;
JRadioButton radioButton1, radioButton2;

Color bgColor = new Color( 0, 0, 0, 100 );

void setup() {
  //twitterの初期設定
  //配布時参照不可
  String keys[] = loadStrings("../twitterOathKey.txt");
  //キー設定　自分のキーを入力
  final String consumerKey       = keys[0];
  final String consumerSecret    = keys[1];
  final String accessToken       = keys[2];
  final String accessTokenSecret = keys[3];
  
  restAPI = new OAuthRestAPI(consumerKey, consumerSecret, accessToken, accessTokenSecret);

  //ウィンドウの初期設定
  surface.setAlwaysOnTop( true );
  surface.setResizable  ( true );
  awtSurface   = (PSurfaceAWT) surface;
  smoothCanvas = (PSurfaceAWT.SmoothCanvas) awtSurface.getNative();

  smoothCanvas.getFrame().removeNotify();
  smoothCanvas.getFrame().setUndecorated ( true );
  smoothCanvas.getFrame().setSize        ( 140, 163 );
  smoothCanvas.getFrame().setBackground  ( bgColor  );
  smoothCanvas.getFrame().setOpacity     ( 0.5f     );
  smoothCanvas.getFrame().setLocation    ( 390, 350 );
  smoothCanvas.setBounds( 0, 0, 400, 100 );

  Canvas canvas = (Canvas)       surface.getNative();
  pane          = (JLayeredPane) canvas.getParent().getParent();
  pane.setBackground( bgColor );

  //テキストエリアの初期設定
  area = new JTextArea("");
  area.setLineWrap             ( true );
  area.setWrapStyleWord        ( true );
  scrollPane = new JScrollPane ( area );
  scrollPane.setBounds         ( 120, 20, 260, 70 );
  scrollPane.setVisible        ( false );
  pane.add( scrollPane );

  //タグの入力欄の初期設定
  tagField = new JTextField("");
  tagField.setBounds        ( 182, 90, 198, 30 );
  tagField.setVisible       ( false );
  pane.add( tagField );

  //タグのチェックボックス
  tagCheck = new JCheckBox( "Tag:" );
  tagCheck.setFont         ( new Font("Times New Roman", Font.BOLD, 14) );
  tagCheck.setForeground   ( new Color(#00ECFF) );
  tagCheck.setBounds       ( 121, 90, 61, 30    );
  tagCheck.setVisible      ( false );
  pane.add( tagCheck );

  //ツイートボタンの初期設定
  tweetButton = new JButton( "Send Tweet" );
  tweetButton.setFont           ( new Font("Times New Roman", Font.BOLD, 16) );
  tweetButton.setForeground     ( new Color( 255, 50, 50 ) );
  tweetButton.setBackground     ( bgColor                  );
  tweetButton.setBounds         ( 20, 20, 100, 50          );
  tweetButton.addActionListener ( new MyActionListener()   );
  tweetButton.setActionCommand  ( "SendNewTweet"           );
  pane.add( tweetButton );

  //テキスト欄の表示ボタンの初期設定
  viewTextButton = new JButton("View Text");
  viewTextButton.setFont           ( new Font("Times New Roman", Font.BOLD, 16) );
  viewTextButton.setBackground     ( bgColor                );
  viewTextButton.setBounds         ( 20, 70, 100, 50        );
  viewTextButton.addActionListener ( new MyActionListener() );
  viewTextButton.setActionCommand  ( "ViewText"             );
  pane.add( viewTextButton );

  //ポップアップの初期設定
  radioGroup   = new ButtonGroup  ();
  radioButton1 = new JRadioButton ( "Always On Top"        );
  radioButton1.addActionListener  ( new MyActionListener() );
  radioButton1.setActionCommand   ( "radio1"               );
  radioButton1.setSelected        ( true );

  radioButton2 = new JRadioButton ( "Default" );
  radioButton2.addActionListener  ( new MyActionListener() );
  radioButton2.setActionCommand   ( "radio2"               );

  radioGroup.add( radioButton1 );
  radioGroup.add( radioButton2 );

  popup = new JPopupMenu();
  popup.add( radioButton1 );
  popup.add( radioButton2 );

  background(50);
  noLoop();
}

void draw() {
  //loop(), noLoop()を使ってできるだけdraw()を実行しないようにしている
}

int preMouseX, preMouseY, preFrameX, preFrameY;

void mousePressed() {
  if ( mouseButton==LEFT ) {
    //ウィンドウの移動に関するコード
    loop();
    preMouseX = MouseInfo.getPointerInfo().getLocation().x;
    preMouseY = MouseInfo.getPointerInfo().getLocation().y;
    preFrameX = smoothCanvas.getFrame().getLocation().x;
    preFrameY = smoothCanvas.getFrame().getLocation().y;
  } else if ( mouseButton==RIGHT ) {
    popup.show(smoothCanvas.getFrame(), mouseX, mouseY );
  }
}

void mouseDragged() {
  //ウィンドウの移動に関するコード
  int distX = MouseInfo.getPointerInfo().getLocation().x - preMouseX;
  int distY = MouseInfo.getPointerInfo().getLocation().y - preMouseY;
  int locateX = preFrameX + distX;
  int locateY = preFrameY + distY;
  smoothCanvas.getFrame().setLocation(locateX, locateY);
}

void mouseReleased() {
  noLoop();
}

void mouseWheel( processing.event.MouseEvent event ) {
  //ウィンドウの透過に関するコード
  float opacity = smoothCanvas.getFrame().getOpacity();
  if ( event.getAmount() < 0) {
    opacity -= 0.01f;
  } else if (event.getAmount()>0) {
    opacity += 0.01f;
  }
  if ( opacity>=1.0f ) opacity = 1.0f;
  if ( opacity<=0.2f ) opacity = 0.2f;
  smoothCanvas.getFrame().setOpacity( opacity );
}