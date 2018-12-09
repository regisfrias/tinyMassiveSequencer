void drawScreen2(){
  if(showCursor){
    for(int y = 0; y < store.length; y++){
      for(int x = 0; x < store[y].length; x++){
        if(store[y][x] == 1) {
          fill(0, 70, 60);
        } else if(playhead == x) {
          fill(0, 70, 50);
        } else if(sequencerPosition.x == x || sequencerPosition.y == y) {
          if(sequencerPosition.x == x && sequencerPosition.y == y)
            fill(0, 10, 100); // Cursor
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

void triggerParticle(int step, int track, boolean triggerSound){
  if(track < 0) {
    for(int y = 0; y < store.length; y++){
      if(store[y][step] == 1) chooseTrack(playhead, y, triggerSound);
    }
  } else {
    chooseTrack(step, track, triggerSound);
  }
}

void chooseTrack(int step, int track, boolean triggerSound){
  SoundFile sf = kick;
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
      sf = kick;
      break;
    default:
      sf = kick;
      break;
  }
  
  if(triggerSound) sf.play();
  particles2.add(new Particle2(origin, track));
}

void runParticles() {
  for (int i = particles2.size()-1; i >= 0; i--) {
    Particle2 p = particles2.get(i);
    p.run();
    if (p.isDead()) {
      particles2.remove(i);
    }
  }
}

void reset2(){
  int pickPreset = (int)random(presets.length);
  store = presets[pickPreset];
}

void clearStore(){
  for(int y = 0; y < store.length; y++){
    for(int x = 0; x < store[y].length; x++){
      store[y][x] = 0;
    }
  }
}
