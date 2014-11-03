//WarmVector game created by Wyatt Ades
//(Networking created by Spenser Williams)

import com.dhchoi.*;
import processing.net.*;
import ddf.minim.*;
import java.awt.geom.*;

NetworkManager networkManager;
PlayerManager playerManager;

Minim minim;
String[] audioStrings = {
}; //stores the names of all the audio files
String[] imageStrings = {
  "leveltiles_01", "levelmap_01"
}; //stores the names of all the image files
AudioPlayer[] audio = new AudioPlayer[audioStrings.length]; //creates an array for the audio files
PImage[] image = new PImage[imageStrings.length]; //creates an array for the image files

Input input;
World world;
GUI gui;
StartMenu startmenu;

int level = 1; //the current level
int stage = 1;

boolean sketchFullScreen() {
  return true;
}

void setupLevel() {
  networkManager = new NetworkManager(new Client(this, "25.136.74.15", 5205));
  playerManager = new PlayerManager();
  world = new World();
  world.thisPlayer.username = "TNTniceman";
  world.thisPlayer.textureID = 25;
  gui = new GUI();
  startmenu = new StartMenu();
}

void setup() {
  size(displayWidth, displayHeight);
  noCursor();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  input = new Input();
  minim = new Minim(this);
  loadFiles();
  setupLevel(); //setup first level
}

void loadFiles() {
  for (int i = 0; i < audioStrings.length; i++) { //loads all audio files
    audio[i] = minim.loadFile(audioStrings[i]+".mp3");
  }
  for (int i = 0; i < imageStrings.length; i++) { //loads all images
    image[i] = loadImage(imageStrings[i]+".png");
  }
}

void draw()
{
  background(255);
  input.updateMouse();
  if (stage == 1) {
    startmenu.render();
    if (input.mouseLeft) stage = 2;
  } else if (stage == 2) {
    noCursor();
    world.update();
    gui.update();
    world.render();
    gui.render();
  }
  if (networkManager.getClient().available() > 0)
  {
    String packetData = networkManager.getClient().readString();
    println("Client is receiving data...");

    if (packetData != null)
    {
      println(packetData);
      networkManager.receivePacket(networkManager.decodePacket(packetData));
    }
  }
}

//this will determine if a connection can be made to the server
boolean connectAttempt() {
  try {
    if (networkManager.getClient().available() > 0) {
      String packetData = networkManager.getClient().readString();
      println("Client is receiving data...");

      if (packetData != null) {
        networkManager.receivePacket(networkManager.decodePacket(packetData));
      }
    }
    return true;
  } 
  catch(Exception e) {
    println("Exception: "+e);
    return false;
  }
}

void keyPressed() {
  input.pressKey(key, keyCode);
}

void keyReleased() {
  input.releaseKey(key, keyCode);
}

void mousePressed() {
  input.pressMouse(mouseButton);
}

void mouseReleased() {
  input.releaseMouse(mouseButton);
}

boolean collideRects(PVector pos1, PVector size1, PVector pos2, PVector size2) {
  if (pos1.x-size1.x/2<pos2.x+size2.x/2 &&
    pos1.x+size1.x/2>pos2.x-size2.x/2 &&
    pos1.y-size1.y/2<pos2.y+size2.y/2 &&
    pos1.y+size1.y/2>pos2.y-size2.y/2) {
    return true;
  } else {
    return false;
  }
}

