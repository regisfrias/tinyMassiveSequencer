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
    lifespan -= 15.0;
    size ++;
  }

  // Method to display
  void display() {
    strokeWeight(2);
    noFill();
    //ellipse(position.x, position.y, 8, 8);
    
    switch(type){
      case "CIRCLE":
        strokeWeight(1);
        stroke(250, 70, 140, lifespan);
        ellipse(position.x, position.y, size, size);
        break;
      case "LINE":
        strokeWeight(3);
        strokeCap(PROJECT);
        stroke(220, 70, 140, lifespan);
        line(position.x, position.y, position.x, size);
        break;
      case "TRIANGLE":
        strokeWeight(1);
        stroke(190, 70, 140, lifespan);
        beginShape();
        for(float angle = 0; angle <= 360; angle += 120){
          float x = cos(radians(angle - 90)) * size/2 + position.x;
          float y = sin(radians(angle - 90)) * size/2 + position.y;
          vertex(x, y);
        }
        endShape(CLOSE);
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
