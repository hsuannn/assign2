//You should implement your assign2 here.
PImage bg1, bg2, en, fi, hp, tr, s1, s2, e1, e2;
int x=640, z=0;//x for bg, z for enemy
float a=random(420);//enemy(z,a)
int fx=589, fy=300, speed=5;//fighter(x,y),speed
int blood=2;
float b=random(600), c=random(440);//treasure(b,c)

final int GAME_START = 0;
final int GAME_PLAYING = 1;
final int GAME_LOSE = 2;
int gameState = 0;

boolean up=false, down=false, left=false, right=false;

void setup () {
  size(640, 480) ;
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  en = loadImage("img/enemy.png");
  fi = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  tr = loadImage("img/treasure.png");
  s1 = loadImage("img/start1.png");
  s2 = loadImage("img/start2.png");
  e1 = loadImage("img/end1.png");
  e2 = loadImage("img/end2.png");
}

void draw() {
  switch(gameState) {
  case GAME_START :
    image(s1, 0, 0);
    if (mouseY>=380 && mouseY<=415) {
      if (mouseX>=210 &&mouseX<=455) {
        image(s2, 0, 0);
        if (mousePressed)
          gameState = GAME_PLAYING;
      }
    }
    break;

  case GAME_PLAYING :
    /* background */
    image(bg1, x%1280-640, 0);
    image(bg2, (x-640)%1280-640, 0);
    x++;

    /* fighter */
    image(fi, fx, fy);
    if (up)
      fy -= speed;
    if (down)
      fy += speed;
    if (left)
      fx -= speed;
    if (right)
      fx += speed;
    //boundary detection
    if (fx<=0)
      fx = 0;
    if (fx>=589)
      fx = 589;
    if (fy<=0)
      fy = 0;
    if (fy>=429)
      fy = 429;

    /* treasure */
    image(tr, b, c);
    if (fx+51>b && fy+51>c && fx<b+41 && fy<c+41) {
      if (blood<10)
        blood += 1;
      b = random(600);
      c = random(440);
    }

    /* enemy */
    z = (z+5)%640;
    if (z==0)
      a = random(420);

    //approach fighter
    if (a<fy) a += 2;
    else if (a>fy) a -= 2;
    image(en, z, a);

    //minus blood
    if (fx+51>z && fy+51>a && fx<z+61 && fy<a+61) {
      blood -= 2;
      if (blood<=0)
        gameState = GAME_LOSE;
      z = 0;
      a = random(420);
    }

    /* hp & line */
    noStroke();
    fill(255, 0, 0);
    if (blood>=0 && blood<=10)
      rect(26, 22, 20*blood, 25);
    image(hp, 20, 20);
    break;

  case GAME_LOSE :
    image(e1, 0, 0);
    if (mouseY>=315 && mouseY<=350) {
      if (mouseX>=210 &&mouseX<=436) {
        image(e2, 0, 0);
        if (mousePressed) {
          //initialize
          blood = 2;
          fx=589;
          fy=300;
          a=random(420);
          z=0;
          b=random(600);
          c=random(440);
          gameState = GAME_PLAYING;
        }
      }
    }
    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      up = true;
      break;
    case DOWN:
      down = true;
      break;
    case LEFT:
      left = true;
      break;
    case RIGHT:
      right = true;
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      up = false;
      break;
    case DOWN:
      down = false;
      break;
    case LEFT:
      left = false;
      break;
    case RIGHT:
      right = false;
      break;
    }
  }
}
