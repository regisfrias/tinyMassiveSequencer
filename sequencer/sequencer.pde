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
boolean showCursor = false;

// Constants
// KEEP OUT!
static final int LEFT_SCREEN_WIDTH = 39;
static final int LEFT_SCREEN_HEIGHT = 9;
static final int RIGHT_SCREEN_WIDTH = 38;
static final int RIGHT_SCREEN_HEIGHT = 13;
static final int RIGHT_SCREEN_POSITION = LEFT_SCREEN_WIDTH;

int playhead = 0;
PVector sequencerPosition = new PVector(0, 0);

int[][] store;

int inactivity = 0;

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
  
  reset();
  
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
            fill(0, 50, 80, 0); // Cursor
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
      inactivity++;
    } else {
      playhead = 0;
    }
  }
  
  if(inactivity > 8) {
    showCursor = false;
    if(inactivity > 128) {
      inactivity = 0;
      reset();
    }
  }
  
  runParticles();
}
