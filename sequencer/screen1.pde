void drawScreen1(){
  runParticles1();
}

void runParticles1() {
  for (int i = particles1.size()-1; i >= 0; i--) {
    Particle1 p = particles1.get(i);
    p.run();
    if (p.isDead()) {
      particles1.remove(i);
    }
  }
}
