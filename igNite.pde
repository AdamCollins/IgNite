boolean fileLoaded = false;

color blue = #335755;
color white = #EDDDBB;
color grey = #3D3B38;
color black = #0C0A0B;

PFont Arial;
PImage bckgrd;

float  songProgress;
float  volume = 0.5;
float volumeSliderX;

int playButtonAlpha = 150;
int loadFileAlpha = 150;
int progressBarAlpha = 150; // bar
int soundVisionAlpha = 50;  // visual;

String state = "PLAY";
String title = "";

import ddf.minim.*;
import ddf.minim.analysis.*;

AudioMetaData meta;
Minim minim;
AudioPlayer player;
FFT fft;



PImage fai_iconi;
PGraphics fai_icong;
String fai_filename;
void setup() {
  size(500, 200);
  Arial = loadFont("data/Arial.vlw");
  bckgrd = loadImage("background.png");
  
  volumeSliderX = width-30;

  minim = new Minim(this);
}

void draw() {
  background(white);
  smooth(28);
  
  for (int i = 0; i<900; i+=200) {
    image(bckgrd, i, 0);              //Stamps background Image.
  }

  
  if (fileLoaded) {
    soundVision();                  //Calls visualizer function
    player.setGain(volume);
    
    fill(0, 0, 0, 255);
    textSize(21);    //Prints title out
    textAlign(CENTER);
    text(title, width/2, 30);
  }
  buttons();                        //controls other smaller functions.
}

void mouseReleased() {
  if (fileLoaded && player.position()>=player.length()) {          
    state = "PLAY";                                        //Resets song when it finishes.
  }
  if (mouseX>0 && mouseX<80 && mouseY < 40) {
    if (state == "PLAY" && fileLoaded) {                              
      state = "PAUSE";                                  //Plays song.
      player.play();
      player.setVolume(volume); //~~~~~~~~~~~~~~~~~~Volume?------------------\\
    } else if (state == "PAUSE") {
      state = "PLAY";                                  //Pauses song.
      player.pause();
    }
  }

  if (mouseX>width-110 && mouseX<width && mouseY < 40) {
    selectInput("Select a file to process:", "fileSelected");    //Calls selectInput if button pressed.
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String filepath = selection.getAbsolutePath();
    println("User selected " + filepath);
    // load file here
    player = minim.loadFile(filepath);
    fft = new FFT( player.bufferSize(), player.sampleRate());
    meta = player.getMetaData();
    fileLoaded = true;
    title = meta.title();
  }
}


void soundVision() {
  fft.forward( player.mix );

  fill(#45ADA8, soundVisionAlpha);
  stroke(grey);
  strokeWeight(1);


  if (progressBarAlpha<200 && soundVisionAlpha<255) {
    soundVisionAlpha+=3;
  } else if (soundVisionAlpha>50) {
    soundVisionAlpha-=5;
  }

  for (int i = 0; i < fft.specSize (); i+=5) {

    // draw the line for frequency band i, scaling it up a bit so we can see it
    colorMode(HSB);
    //stroke(i, 255, 255);

    //line( i, height, i, height - fft.getBand(i)*8 );



    rect(i+width/2, height - fft.getBand(i)*8, 10, height);
    //ellipse(i+width/2,height + 10 - fft.getBand(i)*5, 10,10);
  }

  for (int i = 0; i < fft.specSize (); i+=5) {

    // draw the line for frequency band i, scaling it up a bit so we can see it
    colorMode(HSB);
    //stroke(i, 255, 255);

    // strokeWeight(10);
    // stroke(#45ADA8,50);
    //fill(#45ADA8,20);
    //line( i+width/2, height, i+width/2, height - fft.getBand(i)*8 );


    rect(i, height - fft.getBand(i)*8, 10, height);
    //ellipse(i,height + 10 - fft.getBand(i)*5, 10,10);
  }
}

