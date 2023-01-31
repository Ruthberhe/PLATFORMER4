class Fplayer extends FGameObject {

  int frame;
  int direction;
  int lives, score, HS;


  Fplayer() {
    super();
    setPosition(150, -100);
    direction= R;
    setName("player");
    setRotatable(false);
    setFillColor(green);
    lives=5;
    score=0;
    HS=0;
  }

  void act() {

    handleInput();
    animate();
    collide();
  }

  void handleInput() {
    float vx= getVelocityX();
    float vy= getVelocityY();

    if (abs(vy)<0.1) action= idle;

    if (upkey) {
      player.setVelocity(vx, -300);
    }
    if (leftkey) {
      player.setVelocity(-300, vy);
      action= run;
      direction=L;
    }
    if (rightkey) {
      player.setVelocity(300, vy);
      action= run;
      direction= R;
    }
    
    
    if (abs(vy) >0.1) action=jump;
  }
  
  

  void collide() {
    if (isTouching("spike")) {
      setPosition(150, -100);
      lives--;
      bump.rewind();
      bump.play();
    }

    if (isTouching("checkpoint1")) {
       setPosition(150, 500);
      nxtchpt.play();
      player.lives++;
     
    }

    if (isTouching("checkpoint2")) {
      nxtchpt.play();
     setPosition(300, 1000);
      player.lives+=2;
      
    }

    if (isTouching("checkpoint3")) {
      nxtchpt.play();
      player.score+=3;
      fill(lpink);
      text("GAMECOMPLETE", width/2, height/2);
    }
  //     restart.show();
  //if (restart.clicked) {
  //  reset();
  //  mode=GAMEOVER;
  //}
  //  }

    if (isTouching("hammer")) {
      setPosition(150, -100);
      lives--;
    }



    if (lives==0) {
      mode=GAMEOVER;
    }
  }

  void animate() {
    if (frame >= action.length) frame=0;
    if (frameCount % 5==0) {
      if (direction==R)  attachImage(action[frame]);
      if (direction==L)  attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
}
