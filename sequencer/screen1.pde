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

void reset1(){
  lineWidth1 = round(random(1, LINE_WIDTHS_1));
  renderMode1 = int(random(0, RENDER_MODES_1));
}
