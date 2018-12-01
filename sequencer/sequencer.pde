/*
  This is an independently created Processing template
  for the Tiny Massive festival (https://tinymassive.io/)
  Author: Régis Frias (regisfrias.com)
  2018
*/

import processing.sound.*;
ArrayList<Particle1> particles1;
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

// SCREEN 1 VARIABLES
//////////////////////

// SCREEN 2 VARIABLES
static final int HIDE_CURSOR_2 = 8; // Hide cursor of joystick 2 after this amount of beats
static final int AUTOMATIC_MODE_2 = 128; // Turn on automatic mode for joystick 2 after this amount of beats
int playhead = 0;
PVector sequencerPosition = new PVector(0, 0);
int[][] store;
int inactivity2 = 0;
SoundFile drum;
SoundFile click;
SoundFile tick;
SoundFile bell;
//////////////////////

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
  
  particles1 = new ArrayList<Particle1>();
  particles = new ArrayList<Particle>();
}

void draw(){
  background(0);
  scale(screenScaleX, screenScaleY);

  drawScreen1();
  drawScreen2();
  
  if(frameCount % 4 == 0) {
    if(playhead < 15){
      triggerParticle(playhead, -1, true);
      playhead++;
      inactivity2++;
    } else {
      playhead = 0;
    }
    
    if(inactivity2 > HIDE_CURSOR_2) {
      showCursor = false;
      if(inactivity2 > AUTOMATIC_MODE_2) {
        inactivity2 = 0;
        reset();
      }
    }
  }
}
