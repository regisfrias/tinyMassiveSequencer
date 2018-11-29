/*
  This is an independently created Processing template
  for the Tiny Massive festival (https://tinymassive.io/)
  Author: Régis Frias (regisfrias.com)
  2018
*/

import processing.sound.*;
ArrayList<Particle> particles;

int screenScaleX = 10;
int screenScaleY = 10;

// Show "cursor"
boolean showCursor = true;

// Constants
// KEEP OUT!
static final int LEFT_SCREEN_WIDTH = 39;
static final int LEFT_SCREEN_HEIGHT = 9;
static final int RIGHT_SCREEN_WIDTH = 38;
static final int RIGHT_SCREEN_HEIGHT = 13;
static final int RIGHT_SCREEN_POSITION = LEFT_SCREEN_WIDTH;

int playhead = 0;
PVector sequencerPosition = new PVector(0, 0);

int[][] store = {
  {0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0},
  {0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,0},
  {1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0}
};

SoundFile drum;
SoundFile click;
SoundFile tick;
SoundFile bell;

void settings(){
  size(77 * screenScaleX, 13 * screenScaleY);
}

void setup(){
  frameRate(30);
  surface.setLocation(0, 0);
  
  colorMode(HSB, 360, 100, 100);
  
  drum = new SoundFile(this, "drum.wav");
  click = new SoundFile(this, "click.wav");
  tick = new SoundFile(this, "tick.wav");
  bell = new SoundFile(this, "bell.wav");
  
  particles = new ArrayList<Particle>();
}

void draw(){
  background(0);
  scale(screenScaleX, screenScaleY);
  noStroke();
  
  if(showCursor){
    for(int y = 0; y < store.length; y++){
      for(int x = 0; x < store[y].length; x++){
        if(store[y][x] == 1) {
          fill(0, 70, 60);
        } else if(playhead == x) {
          fill(0, 70, 10);
        } else if(sequencerPosition.x == x || sequencerPosition.y == y) {
          if(sequencerPosition.x == x && sequencerPosition.y == y)
            fill(0, 50, 80); // Cursor
          else
            fill(0, 50, 10);
        } else if(x % 4 == 0) {
          fill(10, 70, 10);
        } else {
          fill(0, 0, 0);
        }
        rect(x*2 + RIGHT_SCREEN_POSITION + 3, y*3, 2, 3);
      }
    }
  }
  
  blendMode(ADD);
  
  if(frameCount % 4 == 0) {
    if(playhead < 15){
      triggerParticle(playhead, -1);
      playhead++;
    } else {
      playhead = 0;
    }
  }
  
  runParticles();
}

void triggerParticle(int step, int track){
  if(track < 0) {
    for(int y = 0; y < store.length; y++){
      if(store[y][step] == 1) chooseTrack(playhead, y);
    }
  } else {
    chooseTrack(step, track);
  }
  

}

void chooseTrack(int step, int track){
  SoundFile sf = drum;
  PVector origin = new PVector(step*2 + RIGHT_SCREEN_POSITION + 3, track*3);
  
  switch(track){
    case 0:
      sf = tick;
      break;
    case 1:
      sf = bell;
      break;
    case 2:
      sf = click;
      break;
    case 3:
      sf = drum;
      break;
    default:
      sf = drum;
      break;
  }
  
  sf.play();
  particles.add(new Particle(origin, track));
}

void runParticles() {
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.run();
    if (p.isDead()) {
      particles.remove(i);
    }
  }
}
