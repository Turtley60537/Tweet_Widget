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

PSurfaceAWT awtSurface;
PSurfaceAWT.SmoothCanvas smoothCanvas;
Canvas canvas;

TweetUnit tweetUnit;
NoteUnit noteUnit;

JPopupMenu   popup;
PopupItems   popupItems;

JLayeredPane layeredPane;

Color bgColor;
int nowFrameSizeX, nowFrameSizeY, frameGapY;  //gapY: フレームを消したからかサイズのズレが発生するため
int closedFrameSizeX, openFrameSizeX;
ArrayList<Integer> setFrameYByUnitsNum = new ArrayList<Integer>();

ArrayList<Integer> unitPosY = new ArrayList<Integer>();

int preMouseX, preMouseY, preFrameX, preFrameY;

void setup() {
  bgColor  = new Color( 0, 0, 0, 100 );

  closedFrameSizeX = 140;
  openFrameSizeX   = 400;
  nowFrameSizeX    = closedFrameSizeX;

  nowFrameSizeY    = 270;
  frameGapY        = 22;

  setFrameYByUnitsNum.add( new Integer(162) );
  setFrameYByUnitsNum.add( new Integer(270) );

  unitPosY.add( 20  );
  unitPosY.add( 130 );

  //ウィンドウの初期設定
  surface.setAlwaysOnTop( true );
  surface.setResizable  ( true );
  awtSurface   = (PSurfaceAWT) surface;
  smoothCanvas = (PSurfaceAWT.SmoothCanvas) awtSurface.getNative();

  smoothCanvas.getFrame().removeNotify();
  smoothCanvas.getFrame().setUndecorated ( true );
  //smoothCanvas.getFrame().setSize      ( 140, 163 );
  nowFrameSizeX = closedFrameSizeX;
  smoothCanvas.getFrame().setSize        ( nowFrameSizeX, nowFrameSizeY );
  smoothCanvas.getFrame().setBackground  ( bgColor  );
  smoothCanvas.getFrame().setOpacity     ( 0.9f     );
  smoothCanvas.getFrame().setLocation    ( 390, 350 );
  //smoothCanvas.setBounds( 0, 0, 100, 100 );

  canvas = (Canvas)       surface.getNative();

  //println(canvas.getParent().getClass());                                                   //JPanel
  //println(canvas.getParent().getParent().getClass());                                       //JLayeredPane
  //println(canvas.getParent().getParent().getParent().getClass());                           //JRootPane
  //println(canvas.getParent().getParent().getParent().getParent().getClass());               //JFrame
  //println(canvas.getParent().getParent().getParent().getParent().getParent().getClass()); //NullPointerException

  layeredPane = (JLayeredPane) canvas.getParent().getParent();
  layeredPane.setBackground( bgColor );

  tweetUnit = new TweetUnit();
  noteUnit  = new NoteUnit();
  popupItems    = new PopupItems();

  background(50);
  noLoop();
}

void draw() {
  //loop(), noLoop()を使ってできるだけdraw()を実行しないようにしている
}

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