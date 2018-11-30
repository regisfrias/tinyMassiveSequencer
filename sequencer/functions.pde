void reset(){
  int pickPreset = (int)random(presets.length);
  store = presets[pickPreset];
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
