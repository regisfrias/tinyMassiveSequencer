class Particle1 {
  float lifespan;
  float size;
  char type;
  float hue;
  
  Particle1(char _type){
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
    
    switch(type){
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
  
  void render(boolean up, boolean left){
    //int lineWidth = 1;
    //switch(renderMode){
    //  case 0:
    //    lineWidth = 1;
    //    break;
    //  case 1:
    //    lineWidth = 2;
    //    break;
    //  case 2:
    //    lineWidth = 4;
    //    break;
    //}
    
    int start = 0;
    if(left){
      if(up) start = 0;
      else start = 1;
    } else {
      if(up) start = 2;
      else start = 3;
    }
    
    for(int i = start; i < LEFT_SCREEN_WIDTH - lineWidth1; i+=4){
      float thisSize = left ? cos(radians(i*lineFrequency1)) * size : sin(radians(i*lineFrequency1)) * size;
      if(up)
        rect(i, 0, lineWidth1, constrain(LEFT_SCREEN_HEIGHT - thisSize, 0, LEFT_SCREEN_HEIGHT));
      else
        rect(i, thisSize, lineWidth1, constrain(LEFT_SCREEN_HEIGHT - thisSize, 0, LEFT_SCREEN_HEIGHT));
    }
  }
  
  boolean isDead(){
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
