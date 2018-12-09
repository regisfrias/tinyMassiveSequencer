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
// How many frames to wait when in automatic mode
int block1 = 0;
int waitBottomRange = 30;
int waitTopRange = 40;
//////////////////////

// SCREEN 2 VARIABLES
static final int HIDE_CURSOR_2 = 8; // Hide cursor of joystick 2 after this amount of beats
static final int AUTOMATIC_MODE_2 = 128; // Turn on automatic mode for joystick 2 after this amount of beats
int playhead = 0;
PVector sequencerPosition = new PVector(0, 0);
int[][] store;
int inactivity2 = 0;
SoundFile kick;
SoundFile click;
SoundFile tick;
SoundFile bell;
SoundFile chord1;
SoundFile chord2;
SoundFile chord3;
SoundFile chord4;
SoundFile chord5;
SoundFile chord6;
SoundFile chord7;
SoundFile chord8;
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
  
  kick = new SoundFile(this, "kick.wav");
  click = new SoundFile(this, "click.wav");
  tick = new SoundFile(this, "tick.wav");
  bell = new SoundFile(this, "bell.wav");
  chord1 = new SoundFile(this, "chord-1.wav");
  chord2 = new SoundFile(this, "chord-2.wav");
  chord3 = new SoundFile(this, "chord-3.wav");
  chord4 = new SoundFile(this, "chord-4.wav");
  chord5 = new SoundFile(this, "chord-5.wav");
  chord6 = new SoundFile(this, "chord-6.wav");
  chord7 = new SoundFile(this, "chord-7.wav");
  chord8 = new SoundFile(this, "chord-8.wav");
  
  particles1 = new ArrayList<Particle1>();
  particles2 = new ArrayList<Particle2>();
}

void draw(){
  background(0);
  scale(screenScaleX, screenScaleY);

  drawScreen1();
  drawScreen2();
  
  if(frameCount % 4 == 0) {
    triggerParticle(playhead, -1, true);
    if(playhead < 15){
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
  
  if(inactivity1 > AUTOMATIC_MODE_1 && block1 > 50){
    int randModulo = (int)random(waitBottomRange, waitTopRange);
    if(frameCount % randModulo == 0){
      reset1();
      char[] keys = {'w', 'a', 's', 'd'};
      char randomKey = keys[int(random(keys.length))];
      Particle1 p = new Particle1(randomKey);
      particles1.add(p);
      p.create();
      block1 = 0;
    }
  }
  
  block1++;
}
