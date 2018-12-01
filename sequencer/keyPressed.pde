void keyPressed(){
  
  switch(key){
    //0 (Important: this button (numpad 0) should reset the game state.)
    case '0':
      println("Reset");
      reset();
      break;
    /////////////////////////////////
    
    // Joystick 1
    // W, A, S, D (joystick 1 up/left/down/right)
    case 'w':
      println("Joystick 1: up");
      break;
    case 'a':
      println("Joystick 1: left");
      break;
    case 's':
      println("Joystick 1: down");
      break;
    case 'd':
      println("Joystick 1: right");
      break;

    //Q, E (2 generic buttons mounted next to joystick 1 )
    case 'q':
      println("Joystick 1: generic button 1");
      break;
    case 'e':
      println("Joystick 1: generic button 2");
      break;
    /////////////////////////////////
      
    // Joystick 2
    // I, J, K, L (joystick 2 up/left/down/right)
    case 'i':
      println("Joystick 2: up");
      if(sequencerPosition.y > 0) sequencerPosition.y--;
      break;
    case 'j':
      println("Joystick 2: left");
      if(sequencerPosition.x > 0) sequencerPosition.x--;
      break;
    case 'k':
      println("Joystick 2: down");
      if(sequencerPosition.y < store.length-1) sequencerPosition.y++;
      break;
    case 'l':
      println("Joystick 2: right");
      if(sequencerPosition.x < store[0].length-1) sequencerPosition.x++;
      break;
      
    //U, O (2 generic buttons mounted next to joystick 2 )
    case 'u':
      println("Joystick 2: generic button 1");
      int index = store[(int)sequencerPosition.y][(int)sequencerPosition.x];
      int[] arr = {1,0};
      store[(int)sequencerPosition.y][(int)sequencerPosition.x] = arr[index];
      break;
    case 'o':
      println("Joystick 2: generic button 2");
      showCursor = !showCursor;
      break;
    /////////////////////////////////
  }
  
  if(key == 'i' || key == 'j' || key == 'k' || key == 'l' || key == 'u'){
    inactivity2 = 0;
    showCursor = true;
    triggerParticle((int)sequencerPosition.x, (int)sequencerPosition.y);
  }
}
