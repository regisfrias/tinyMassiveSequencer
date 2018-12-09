class Particle1 {
  float lifespan;
  float size;
  char type;
  float hue;
  SoundFile sf;

  Particle1(char _type) {
    type = _type;
    lifespan = 255.0;
    size = 0;
    hue = random(360);
    sf = null;
  }
  
  void create(){
    if(type == 'w' || type == 'a' || type == 's' || type == 'd'){
      switch(type) {
        case 'w': //println("Joystick 1: up");
          sf = renderMode1 == 0 ? chord1 : chord5;
          break;
        case 'a': //println("Joystick 1: left");
          sf = renderMode1 == 0 ? chord2 : chord6;
          break;
        case 's': //println("Joystick 1: down");
          sf = renderMode1 == 0 ? chord3 : chord7;
          break;
        case 'd': //println("Joystick 1: right");
          sf = renderMode1 == 0 ? chord4 : chord8;
          break;
      }
      
      if(sf != null) {
        if(sf.isPlaying()) sf.stop();
        sf.play();
      }
    }
  }

  void run() {
    update();
    display();
  }

  void update() {
    lifespan -= 3.0;
    size++;
  }

  void display() {
    //blendMode(ADD);
    noStroke();
    fill(hue, 70, 70, constrain(lifespan, 0, 255));
    
    if(lifespan > 0.0) {
      switch(type) {
        case 'w': //println("Joystick 1: up");
          render(true, false);
          break;
        case 'a': //println("Joystick 1: left");
          render(true, true);
          break;
        case 's': //println("Joystick 1: down");
          render(false, false);
          break;
        case 'd': //println("Joystick 1: right");
          render(false, true);
          break;
      }
    } else {
      if(sf != null) sf.stop();
    }
  }

  void render(boolean up, boolean left) {
    int start = 0;
    if (left) {
      if (up) start = 0;
      else start = 1;
    } else {
      if (up) start = 2;
      else start = 3;
    }

    int loopSize = 0;
    int loopIncr = 0;

    switch(renderMode1) {
    case 0:
      loopSize = LEFT_SCREEN_WIDTH - lineWidth1;
      loopIncr = LINE_WIDTHS_1;
      break;
    case 1:
      loopSize = LEFT_SCREEN_WIDTH - lineWidth1;
      loopIncr = 4;
      break;
    }

    for (int i = start; i < loopSize; i += loopIncr) {
      switch(renderMode1) {
      case 0:
        renderLines(i, up, left);
        break;
      case 1:
        renderSquares(i, up);
        break;
      }
    }
  }

  void renderSquares(int index, boolean up) {
    if (up) {
      float thisSize = sin(radians(index * 2)) * (LEFT_SCREEN_HEIGHT - this.size);
      rect(index, thisSize, lineWidth1, lineWidth1);
    } else {
      float thisSize = sin(radians(index * 2)) * this.size;
      rect(index, thisSize, lineWidth1, lineWidth1);
    }
  }

  void renderLines(int index, boolean up, boolean left) {
    float thisSize = left ? cos(radians(index * 2)) * this.size : sin(radians(index * 2)) * this.size;
    if (up)
      rect(index, 0, lineWidth1, constrain(LEFT_SCREEN_HEIGHT - thisSize, 0, LEFT_SCREEN_HEIGHT));
    else
      rect(index, thisSize, lineWidth1, constrain(LEFT_SCREEN_HEIGHT - thisSize, 0, LEFT_SCREEN_HEIGHT));
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
