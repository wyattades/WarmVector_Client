//WarmVector game created by Wyatt Ades
//(Networking created by Spenser Williams)


import com.dhchoi.*;
import processing.net.*;
import ddf.minim.*;
import java.awt.geom.*;

NetworkManager networkManager;
PlayerManager playerManager;
Player thisPlayer;
CountdownTimer packetSendFast;

//String[] config = loadStrings("..\..\WarmVector\config.txt");
Minim minim;
String[] audioStrings = { //stores the names of all the audio files
}; 
String[] imageStrings = { //stores the names of all the image files
  "leveltiles_01", "levelmap_01"
}; 
AudioPlayer[] audio = new AudioPlayer[audioStrings.length]; //creates an array for the audio files
PImage[] image = new PImage[imageStrings.length]; //creates an array for the image files

Input input;
World world;
GUI gui;
StartMenu startmenu;

int level;
int stage;
int connectionTimer;
boolean testConnection;

boolean sketchFullScreen() {
  return true;
}

void beginProgram() {
  stage = 1;
  level = 0;
  connectionTimer = 0;
  world = new World();
  world.thisPlayer.username = "Big_Cock69";
  world.thisPlayer.textureID = 25;
  playerManager = new PlayerManager();
  gui = new GUI();
  startmenu = new StartMenu();
  testConnection = false;
}

void setup() {
  size(displayWidth, displayHeight);
  frameRate(60);
  noCursor();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  input = new Input();
  minim = new Minim(this);
  loadFiles();
  beginProgram();
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
  if (stage == 1) {
    startmenu.render();
    startmenu.update();
    testConnection = false;
  } else if (stage == 2) {
    world.update();
    gui.update();
    world.render();
    gui.render();
  } else if (stage == 3) {
    text("Connecting to Server...", width/2, height/2);
    if (testConnection) { //i have a boolean so i can print the above text before trying to connect
      connectionTimer = millis();
      networkManager = new NetworkManager(new Client(this, "25.16.219.103", 5205));
      packetSendFast = CountdownTimer.getNewCountdownTimer(this).configure(200, 1000000).start();// 15 packets every second
      if (millis()-connectionTimer > 4000) {
        stage = 1;
        println("Connection Timed Out");
      } else {
        stage = 4;
      }
    }
    testConnection = true;
  } else if (stage == 4) {
    if (networkManager.getClient().available() > 0) {
      String packetData = networkManager.getClient().readString();

      if (packetData != null && !packetData.contains("**") && packetData.length()>1) {
        networkManager.receivePacket(networkManager.decodePacket(packetData));
      }
    }
    world.update();
    gui.update();
    world.render();
    gui.render();
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

void onTickEvent(int id, long timeLeftUntilFinish)
{
  switch(id)
  {
  case 0:

    playerManager.sendPlayerPosition();
    break;
  }
}

void onFinishEvent(int timerId)
{
}

