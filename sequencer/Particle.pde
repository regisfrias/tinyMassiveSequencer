// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float size;
  String type;

  Particle(PVector l, String _type) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
    size = 1;
    type = _type;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    //position.add(velocity);
    lifespan -= 10.0;
    size ++;
  }

  // Method to display
  void display() {
    strokeWeight(2);
    noFill();
    //ellipse(position.x, position.y, 8, 8);
    
    switch(type){
      case "CIRCLE":
        strokeWeight(2);
        noFill();
        stroke(250, 70, 140, lifespan);
        ellipse(position.x, position.y, size, size);
        break;
      case "LINE":
        noStroke();
        fill(220, 70, 140, lifespan);
        rect(position.x, size, RIGHT_SCREEN_WIDTH/8, RIGHT_SCREEN_HEIGHT - size);
        break;
      case "TRIANGLE":
        noStroke();
        fill(190, 70, 140, lifespan);
        rect(position.x, 0, RIGHT_SCREEN_WIDTH/8, RIGHT_SCREEN_HEIGHT - size);
        break;
    }
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
