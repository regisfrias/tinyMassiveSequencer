// Borrowed from Daniel Shiffman

class Particle2 {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float size;
  int track;

  Particle2(PVector l, int _track) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
    size = 1;
    track = _track;
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
    //blendMode(ADD);
    //ellipse(position.x, position.y, 8, 8);
    
    switch(track){
      case 0:
        noStroke();
        fill(170, 70, 70, lifespan);
        rect(position.x, 0, 2, RIGHT_SCREEN_HEIGHT - size);
        break;
      case 1:
        noStroke();
        fill(130, 70, 70, lifespan);
        ellipse(position.x + 1, position.y + 1, size, size);
        break;
      case 2:
        strokeWeight(2);
        noFill();
        stroke(210, 70, 70, lifespan);
        ellipse(position.x + 1, position.y + 1, size, size);
        break;
      case 3:
        noStroke();
        fill(250, 70, 70, lifespan);
        rect(position.x, size - 1, 2, constrain(RIGHT_SCREEN_HEIGHT - size, 0, RIGHT_SCREEN_HEIGHT));
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
