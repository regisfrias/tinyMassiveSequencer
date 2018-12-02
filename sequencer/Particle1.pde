class Particle1 {
  float lifespan;
  float size;
  char type;
  float hue;

  Particle1(char _type) {
    type = _type;
    lifespan = 255.0;
    size = 0;
    hue = random(360);
  }

  void run() {
    update();
    display();
  }

  void update() {
    lifespan -= 7.0;
    size++;
  }

  void display() {
    blendMode(ADD);
    fill(hue, 70, 70, constrain(lifespan, 0, 255));

    switch(type) {
    case 'w': //println("Joystick 1: up");
      render(true, false);
      break;
    case 'a': //println("Joystick 1: left");
      render(false, false);
      break;
    case 's': //println("Joystick 1: down");
      render(true, true);
      break;
    case 'd': //println("Joystick 1: right");
      render(false, true);
      break;
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
        renderCircles(i, up, loopIncr);
        break;
      }
    }
  }

  void renderCircles(int index, boolean up, int loopIncr) {
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
