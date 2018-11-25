/*
  This is an independently created Processing template
  for the Tiny Massive festival (https://tinymassive.io/)
  Author: Régis Frias (regisfrias.com)
  2018
*/

import processing.sound.*;
ArrayList<Particle> particles;

/*
IMPORTANT:
The following 2 lines just make the project
appear normal on computer screens.
Use '1' instead for final output. */
int screenScaleX = 10;
int screenScaleY = 10;

// Turn this off (false) here
// (or with keyboard '1')
// for live output.
boolean debug = false;

// Constants
// KEEP OUT!
static final int LEFT_SCREEN_WIDTH = 39;
static final int LEFT_SCREEN_HEIGHT = 9;
static final int RIGHT_SCREEN_WIDTH = 38;
static final int RIGHT_SCREEN_HEIGHT = 13;
static final int RIGHT_SCREEN_POSITION = LEFT_SCREEN_WIDTH;

int playhead = 0;
PVector sequencerPosition = new PVector(0, 0);

//int[][] store = {
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
//  {0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0},
//  {0,0,0,0,1,0,0,0,0,0,0,1,0,1,0,1},
//  {1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0}
//};

int[][] store = {
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0}
};

SoundFile drum;
SoundFile click;
SoundFile tick;

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
  
  particles = new ArrayList<Particle>();
}

void draw(){
  background(0);
  scale(screenScaleX, screenScaleY);
  noStroke();
  
  // -----------------
  // Display reference
  if(debug){
    fill(0,0,100);
    for(int x = 0; x < LEFT_SCREEN_WIDTH; x ++){
      for(int y = 0; y < LEFT_SCREEN_HEIGHT; y ++){
        rect(x, y, 0.9, 0.9);
      }
    }
    
    fill(100,0,0);
    for(int x = RIGHT_SCREEN_POSITION; x < RIGHT_SCREEN_WIDTH + RIGHT_SCREEN_POSITION; x ++){
      for(int y = 0; y < RIGHT_SCREEN_HEIGHT; y ++){
        rect(x, y, 0.9, 0.9);
      }
    }
  }
  // -----------------
  
  for(int y = 0; y < store.length; y++){
    for(int x = 0; x < store[y].length; x++){
      if(store[y][x] == 1) {
        fill(0, 70, 90);
      } else if(playhead == x) {
        fill(0, 70, 60);
      } else if(sequencerPosition.x == x || sequencerPosition.y == y) {
        if(sequencerPosition.x == x && sequencerPosition.y == y) fill(0, 50, 60);
        else fill(0, 50, 30);
      } else if(x % 4 == 0) {
        fill(10, 70, 30);
      } else {
        fill(0, 0, 0);
      }
      rect(x*2 + RIGHT_SCREEN_POSITION + 4, y*2 + 2, 1, 1);
    }
  }
  
  blendMode(ADD);
  
  if(frameCount % 4 == 0) {
    if(playhead < 15){
      if(store[2][playhead] == 1) {
        tick.play();
        PVector origin = new PVector(playhead*2 + RIGHT_SCREEN_POSITION + 4, 5);
        particles.add(new Particle(origin, "CIRCLE"));
      }
      if(store[3][playhead] == 1) {
        click.play();
      }
      if(store[4][playhead] == 1) {
        drum.play();
        PVector origin = new PVector(playhead*2 + RIGHT_SCREEN_POSITION + 4, RIGHT_SCREEN_HEIGHT);
        particles.add(new Particle(origin, "LINE"));
      }
      playhead++;
    } else {
      playhead = 0;
    }
  }
  
  runParticles();
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
