class  FThwomp extends FGameObject {

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    setRotatable(false);
    attachImage(thwomp0);
  }

  void act() {

    if(player.getX()>=getX()&& player.getY()>getY()) {
      setStatic(false);
      attachImage(thwomp1);
      }
      
    if (isTouching("player") && player.getY()>getY()) {
      mode=GAMEOVER;
    } 
     if (isTouching("player") && player.getY()<getY()) {
  player.score+=5;
    } 
    
    
    
    


    
  }
}
