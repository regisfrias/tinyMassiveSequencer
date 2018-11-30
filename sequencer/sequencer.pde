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

// Screen 1 variables
//////////////////////

// Screen 2 variables
int playhead = 0;
PVector sequencerPosition = new PVector(0, 0);

int[][] store;

int inactivity = 0;

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
  
  particles = new ArrayList<Particle>();
}

void draw(){
  background(0);
  scale(screenScaleX, screenScaleY);

  screen1();
  screen2();
}
