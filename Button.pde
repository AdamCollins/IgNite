void buttons() {
  playButton();
  loadButton();
  progressBar();
  volumeSlider();
  frameAndIcon("IgNite", "icon.png");
}


void loadButton() {
  int x = width-110;
  int y = 0;
  if (mouseX>width-110 && mouseX<width && mouseY < 40) {
    stroke(black);
    if (loadFileAlpha<255) {
      loadFileAlpha+=10;
    }
  } else if (loadFileAlpha>150) {
    loadFileAlpha-=7;
  }


  stroke(grey, loadFileAlpha);
  fill(blue, loadFileAlpha);
  strokeWeight(4);
  rect(-4+x, -4+y, 120, 40);

  textAlign(CENTER);
  fill(black, loadFileAlpha);
  textSize(10);
  textFont(Arial);
  text("Load File", 55+x, 25+y);
}
void playButton() {
  if (mouseX>0 && mouseX<80 && mouseY < 40) {
    stroke(black);
    if (playButtonAlpha<255) {
      playButtonAlpha+=10;
    }
  } else if (playButtonAlpha>150) {
    playButtonAlpha-=7;
  }


  stroke(grey, playButtonAlpha);
  fill(blue, playButtonAlpha);
  strokeWeight(4);
  rect(-4, -4, 90, 50);

  textAlign(CENTER);
  fill(black, playButtonAlpha);
  textSize(10);
  textFont(Arial);
  text(state, 42, 30);
}

void progressBar() {
  if (fileLoaded) songProgress = map(player.position(), 0, player.length(), 0, width);

  if (mouseY < height-20 && mouseY > 20 && mouseX > 20 && mouseX < width-20 ) {
    stroke(black);
    if (progressBarAlpha<255) {
      progressBarAlpha+=10;
    }
  } else if (progressBarAlpha>50) {
    progressBarAlpha-=7;
  }

  fill(blue, progressBarAlpha);
  stroke(grey, progressBarAlpha);  
  line(0, height-40, width, height-40);  //static line.

  fill(black, progressBarAlpha);
  textSize(14);
  textAlign(LEFT);
  if (fileLoaded) text(player.position()/60000 + ":" + nf(player.position()%60000/1000,2) + "/" + player.length()/60000 + ":" + player.length()%60000/1000, 5, height-20);

  stroke(#00A0B0, progressBarAlpha+50);
  line(0, height-40, songProgress, height-40); // progress
}

void volumeSlider() {
  volume = map(volumeSliderX, width-105, width-10, -50, 50);
  stroke(grey, progressBarAlpha+80);
  line(width-105, 60, width-10, 60);
  fill(#00A0B0, progressBarAlpha+80);
  ellipse(volumeSliderX, 60, 10, 10);

  if (mouseX>width-105 && mouseX<width-10 && mouseY>40 && mouseY<70 && mousePressed) {
    volumeSliderX = mouseX;
  }
}




void frameAndIcon(String frameText, String iconFilename) {
  if ( fai_filename == null || !fai_filename.equals(iconFilename) ) {
    fai_iconi = loadImage(iconFilename);
    fai_icong = createGraphics(64, 64, JAVA2D);                                        //Changes the prorgam icon.
    fai_filename = iconFilename;
  }
  frame.setTitle( frameText );
  fai_icong.beginDraw();
  fai_icong.image( fai_iconi, 0, 0 );                                                 //Changes name.
  fai_icong.endDraw();
  frame.setIconImage(fai_icong.image);
}
