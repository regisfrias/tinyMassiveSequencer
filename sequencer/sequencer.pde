/*
  This is an independently created Processing template
  for the Tiny Massive festival (https://tinymassive.io/)
  Author: Régis Frias (regisfrias.com)
  2018
*/

import processing.sound.*;
ArrayList<Particle1> particles1;
ArrayList<Particle2> particles2;

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
static final int AUTOMATIC_MODE_1 = 64;
int inactivity1 = AUTOMATIC_MODE_1;
static final int LINE_WIDTHS_1 = 4;
int lineWidth1;
static final int RENDER_MODES_1 = 2;
int renderMode1;
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
  
  reset1();
  reset2();
  
  drum = new SoundFile(this, "drum.wav");
  click = new SoundFile(this, "click.wav");
  tick = new SoundFile(this, "tick.wav");
  bell = new SoundFile(this, "bell.wav");
  
  particles1 = new ArrayList<Particle1>();
  particles2 = new ArrayList<Particle2>();
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
      inactivity1++;
      inactivity2++;
    } else {
      playhead = 0;
    }
    if(inactivity2 > HIDE_CURSOR_2) {
      showCursor = false;
      if(inactivity2 > AUTOMATIC_MODE_2) {
        inactivity2 = 0;
        reset2();
      }
    }
  }
  
  if(inactivity1 > AUTOMATIC_MODE_1){
    int randModulo = (int)random(8, 20);
    if(frameCount % randModulo == 0){
      reset1();
      char[] keys = {'w', 'a', 's', 'd'};
      char randomKey = keys[int(random(keys.length))];
      particles1.add(new Particle1(randomKey));
    }
  }
}
