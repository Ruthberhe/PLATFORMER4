import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;
FWorld world;

color vlgreen   =#D4F9BC;
color vdgreen   =#22B14D;
color skyblue   =#00b7EF;
color vlblue   =#99D9EA;
color white        =#FFFFFF;
color black        =#000000;   //spike
color green        =#0DFF00;
color red          =#FF0000;
color yellow       =#FFFF00;   //trampoline
color blue         =#0000FF;
color  purple      =#6F3198;
color  grey        =#A1A1A1;
color cyan          =#00BBFF;  //ice
color dblue         =#0905F7;
color  lpink        =#FFA3B1;
color dbrown       =#765339;    //normal ground
color lbrown       =#FFAD60;
color  turq        =#69F0EA;
color   pink    =#F700B9;
color   burgindi =#592B2B;
color   dgrey    =#545454;
color    lgreen   =#8BC34A;  //dirt
color middleGreen  =#00FF00;
color leftGreen    =#009F00;
color rightGreen   =#006F00;
color centerGreen  =#004F00;
color treeTrunkBrown  =#FF9500;
color  orange   =#FF8400;

Gif MARIOGIF;
Button begin, restart, pause;


Minim minim;
AudioPlayer coin1, theme, gameover, bump, nxtchpt;

int mode;
final int INTRO    = 0;
final int PLAY     = 1;
final int GAMEOVER = 2;
final int OPTIONS  = 4;

int tsize=5;
PFont platfont;

boolean mouseReleased;
boolean wasPressed;

PImage sky1, MAP3, MAP4, MAP41, MAP412, FINALMAP1, MAPPY43, dirtc, dirts, dirtse, dirtsw, brick, checkpoint, ice, spike, treetrunk, treeintersect, treetopc, treetope, treetopw, bridgec, bridgee, bridgew, bridgeRailsc, bridgeRailse, bridgeRailsw, trampoline, lava0, lava1, lava2, lava3, lava4, lava5, goomba0, goomba1, goomba2, idle0, idle1, jump0, runright1, runright2, hammer, hammerbro0, hammerbro1, thwomp0, thwomp1;
//Gif lva;
PImage[] lava;
PImage[] goomba;
PImage[] hammerBro;
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

int gridSize =32;
float zoom=1.5;


Fplayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;


boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, spacekey;

void setup() {

  fullScreen();
 
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();


  initializeModes();
  initializegifandbutton();
  initializeVariables();
  initializeImages();
  loadWorld(FINALMAP1);
  loadPlayer();
}

void initializeModes() {
  rectMode(CENTER);

  textAlign(CENTER, CENTER);

  mode=INTRO;
}
void initializeImages() {
  FINALMAP1= loadImage("FINALMAP8.png");
  checkpoint= loadImage("checkpoint.png");
  dirts= loadImage("dirt_s.png");
  dirtse= loadImage("dirt_se.png");
  dirtsw= loadImage("dirt_sw.png");
  dirtc= loadImage("dirt_center.png");
  MAP41= loadImage("MAP4.1.png");
  MAP412= loadImage("MAP4.12.png");
  MAPPY43= loadImage("MAPPY432100.png");
  spike= loadImage("spike.png");
  brick= loadImage("brick.png");
  treetrunk= loadImage("tree_trunk.png");
  treeintersect= loadImage("tree_intersect.png");
  treetopc= loadImage("treetop_center.png");
  treetope= loadImage("treetop_e.png");
  treetopw= loadImage("treetop_w.png");
  ice= loadImage("blueBlock.png");
  bridgec= loadImage("bridge_center.png");
  bridgew= loadImage("bridge_w.png");
  bridgee= loadImage("bridge_e.png");
  bridgeRailsc= loadImage("bridgeRails_center.png");
  bridgeRailsw= loadImage("bridge_w.png");
  bridgee= loadImage("bridge_e.png");
  trampoline= loadImage("trampoline.png");
  hammer = loadImage("hammer.png");
  thwomp0 = loadImage("thwomp0.png");
  thwomp1 = loadImage("thwomp1.png");
  sky1= loadImage("sky1.jpg");
  //lava
  lava= new PImage[6];

  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[1] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");


  //player
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run= new  PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] =  loadImage("runright2.png");

  action= idle;

  //goomba
  goomba= new PImage[3];
  goomba[0] = loadImage("goomba0.png");
  goomba[1] = loadImage("goomba1.png");
  goomba[2] = loadImage("goomba2.png");

  //hammerbro
  hammerBro= new PImage[3];
  hammerBro[0] = loadImage("hammerbro0.png");
  hammerBro[1] = loadImage("hammerbro1.png");
}

void initializeVariables() {
  PFont platfont = createFont("Early GameBoy.ttf", 50);
  textFont(platfont);

  //music minim= new Minim(this);
  coin1 = minim.loadFile( "coin1.wav");
  theme = minim.loadFile( "mario bros theme.mp3");
  bump = minim.loadFile( "bump.wav");
  gameover = minim.loadFile( "gameover.wav");
  nxtchpt = minim.loadFile( "nxtchpt.wav");
}

void initializegifandbutton() {
  MARIOGIF= new Gif("MARIOGIF/frame_", "_delay-0.1s.gif", 5, 3, width/2-300, 200, 500, 500);
  restart= new Button("RESTART", width/2, 200, 300, 100, green, blue);
  begin = new Button("BEGIN", 700, height/2, 300, 100, white, black);
  pause = new Button("PAUSE", 50, 50, 100, 50, white, black);
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 3000, 3000);
  world.setGravity(0, 900);

  for (int y=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++) {
      color c=img.get(x, y);//current
      color s= img.get(x, y+1); //below
      color w= img.get(x-1, y);//west of pixel
      color e= img.get(x+1, y);//east of pixel

      FBox b= new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);

      if (c== dbrown) {
        b.attachImage(brick);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      } else if (c==dgrey) {
        b.attachImage(brick);
        b.setFriction(2);
        b.setName("wall");
        world.add(b);
      } else if (c==cyan) {
        b.attachImage(ice);
        b.setFriction(2);
        b.setName("ice");
        world.add(b);
      } else if (c==black) {
        b.attachImage(spike);

        b.setName("spike");
        world.add(b);
      } else if (c==lbrown) {
        b.attachImage(treetrunk);
        b.setSensor(true);
        b.setName("treetrunk");
        world.add(b);
      } else if (c==green && s== lbrown ) { //intersection
        b.attachImage(treeintersect);

        b.setName("treetop");
        world.add(b);
      } else if (c==green && w==green && e==green) { //midpiece
        b.attachImage(treetopc);

        b.setName("treetop");
        world.add(b);
      } else if (c==green && w!=green) { //west
        b.attachImage(treetopw);

        b.setName("treetop");
        world.add(b);
      } else if (c==green && e!= green) { //east
        b.attachImage(treetope);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if ( c==purple) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        b.attachImage(bridgec);
        b.setName("bridge");
        terrain.add(br);
        world.add(br);
      } else if (c==yellow) {
        b.attachImage(trampoline);
        b.setRestitution(2);
        b.setName("trampoline");
        world.add(b);
      } else if (c==lgreen ) {
        b.attachImage(dirtc);
        b.setName("dirt");
        world.add(b);
      } else if  (c==green && e!= green) {
        b.attachImage(dirtse);
        b.setName("dirt");
        world.add(b);
      } else if (c==white) {
        b.attachImage(checkpoint);
        b.setName("checkpoint1");
        world.add(b);
      } else if (c==lpink) {
        b.attachImage(checkpoint);
        b.setName("checkpoint2");
        world.add(b);
      } else if (c==turq) {
        b.attachImage(checkpoint);
        b.setName("checkpoint3");
        world.add(b);
      } else if (c==red) {
        FLava la = new FLava(x*gridSize, y*gridSize);
        la.setName("lava");
        terrain.add(la);
        world.add(la);
      } else if (c==grey) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        gmb.setName("goomba");
        enemies.add(gmb);
        world.add(gmb);
      } else if (c==pink) {
        FHammerbro bro = new FHammerbro(x*gridSize, y*gridSize);
        bro.setName("hammerbro");
        enemies.add(bro);
        world.add(bro);
      } else if (c==burgindi) {
        FThwomp thw = new FThwomp(x*gridSize, y*gridSize);
        thw.setName("thwomp");
        enemies.add(thw);
        world.add(thw);
      }
    }
  }
}


void loadPlayer() {
  player = new Fplayer();
  world.add(player);
}

void draw() {

  click();
    if (mode == INTRO) {
    intro();
  } else if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameOver();
  }
}



void click() {
  mouseReleased = false;
  if (mousePressed) wasPressed = true;
  if (wasPressed && mousePressed == false) {
    mouseReleased = true;
    wasPressed = false;
  }
}
