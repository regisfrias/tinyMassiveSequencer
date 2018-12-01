void drawScreen2(){
  if(showCursor){
    for(int y = 0; y < store.length; y++){
      for(int x = 0; x < store[y].length; x++){
        if(store[y][x] == 1) {
          fill(0, 70, 60);
        } else if(playhead == x) {
          fill(0, 70, 10);
        } else if(sequencerPosition.x == x || sequencerPosition.y == y) {
          if(sequencerPosition.x == x && sequencerPosition.y == y)
            fill(0, 50, 80, 0); // Cursor
          else
            fill(0, 50, 10);
        } else if(x % 4 == 0) {
          fill(10, 70, 10);
        } else {
          fill(0, 0, 0);
        }
        rect(x*2 + RIGHT_SCREEN_POSITION + 3, y*3, 2, 3);
      }
    }
  }
  
  runParticles();
}

void triggerParticle(int step, int track){
  if(track < 0) {
    for(int y = 0; y < store.length; y++){
      if(store[y][step] == 1) chooseTrack(playhead, y);
    }
  } else {
    chooseTrack(step, track);
  }
}

void chooseTrack(int step, int track){
  SoundFile sf = drum;
  PVector origin = new PVector(step*2 + RIGHT_SCREEN_POSITION + 3, track*3);
  
  switch(track){
    case 0:
      sf = tick;
      break;
    case 1:
      sf = bell;
      break;
    case 2:
      sf = click;
      break;
    case 3:
      sf = drum;
      break;
    default:
      sf = drum;
      break;
  }
  
  sf.play();
  particles.add(new Particle(origin, track));
}

void runParticles() {
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.run();
    if (p.isDead()) {
      particles.remove(i);
    }
  }
}
