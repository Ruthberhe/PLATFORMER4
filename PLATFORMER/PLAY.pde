void play() {
  background(black);

  // pause.show();
  actWorld();
  drawWorld();
  println(player);
  if (pause.clicked) {
    mode=PLAY;
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.draw();
  world.step();
  popMatrix();

  fill(red);
  text("SCORE: "+player.score, width/3, 50);
  text("LIVES: "+player.lives, width-200, 50);
}

void actWorld() {
  player.act();
  for (int i=0; i<terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i=0; i<enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}
