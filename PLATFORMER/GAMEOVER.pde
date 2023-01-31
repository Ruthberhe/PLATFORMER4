void gameOver() {
  background(black);
  // textSize(tsize);
  gameover.play();
  textSize(tsize);
  text("GAMEOVER", width/2, height/2);

textSize(80);
  text("HIGHSCORE: " + player.HS, width/2, height-300);
  if (tsize>130) {
    tsize=5;
  }

  tsize++;

  if (player.score>player.HS) {
    player.HS=player.score;
  }


  restart.show();
  if (restart.clicked) {
    reset();
    mode=INTRO;
  }
}
