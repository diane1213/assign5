public Brick[] brick;
public Bar board;
Ball ball;

final int GAME_START = 0;
final int GAME_PLAYING =1;
final int GAME_WIN = 2;
final int GAME_LOSE =3;
int status;
int[] specialBrick;
boolean[] life = {
  true, true, true
};
int lifeCount = 3;

void setup() {
  size(640, 480);
  board = new Bar(80);
  brick = new Brick[50];
  specialBrick = new int[brick.length];
  ball = new Ball(width/2, height-50, 10, random(-5, 5));
  brickMaker();
}


void draw() {
  background(30);

  switch(status) {
  case GAME_START:
    printText();

    break;

  case GAME_PLAYING:
    drawLife();
    board.move();
    board.display();
    int brickCount=0;

    for (int i =0; i<brick.length; i++) {
      
      brick[i].display();
      if (brick[i].hit == true) {
        removeBrick(brick[i]);
        brickCount++;
      }
      if (specialBrick[i] == 1&& brick[i].hit == true&&brick[i].firstHit == true) {
        board.len-=50;
        brick[i].firstHit=false;
      }
      if (specialBrick[i] == 2&& brick[i].hit == true&&brick[i].firstHit == true) {
        board.len+=50;
        brick[i].firstHit = false;
      }
      if(brickCount == brick.length){
        status = GAME_WIN;
      }
    }
    
    ball.display();
    ball.move();
    if (ball.y>height&&ball.y<=height+ball.ySpeed) {
      lifeCount--;
    }

    if ( lifeCount <=0 ) {
      status = GAME_LOSE;
    }

    break;

  case GAME_WIN:
    printText();
    break;

  case GAME_LOSE:
    printText();
    break;
  }
}



void drawLife() { 
  fill(230, 74, 96);
  textSize(18);
  text("LIFE:", 25, 465);
  for ( int i= 0; i < lifeCount; i++) {
    if (life[i] == true) {
      fill(230, 74, 96);
      noStroke();
      ellipse( 78 + i*25, 459, 15, 15);
    } else {
      fill(50, 50, 50);
      noStroke();
      ellipse( 78 + i*25, 459, 15, 15);
    }
  }
}

void brickMaker() {

  for (int i = 0; i<specialBrick.length; i++) {
    specialBrick[i] = 0;
  }
  for (int i = 0; i<3; i++) {
    int R;
    int B;
    do {
      R = int(random(brick.length));
      B = int(random(brick.length));
    }
    while (specialBrick[R]!=0||specialBrick[B]!=0||R==B);
    specialBrick[R] = 1;
    specialBrick[B] = 2;
  }
  for (int i = 0; i<brick.length; i++) {
    int col = i%10;
    int row = i/10;
    if (specialBrick[i] == 0) {
      if (row==0) {
        brick[i]=new Brick(140 + col*40, 50+row*40, 54, 190, 147);
      } else {
        brick[i]=new Brick(140 + col*40, 50+row*40, 54+(255-54)/(5-row), 190+(255-190)/(5-row), 147+(255-147)/(5-row));
      }
    } else if (specialBrick[i] == 1 ) {
      brick[i]=new Brick(140 + col*40, 50+row*40, 209, 65, 83);
    } else {
      brick[i]=new Brick(140 + col*40, 50+row*40, 71, 91, 203);
    }
  }
}

void removeBrick(Brick brick) {
  brick.x = 1000;
  brick.y = 1000;
}

void reset() {
  for ( int i = 0; i <3; i++) {
    life[i] = true;
  }
  lifeCount = 3;
  brickMaker();
  ball.afterClick = false;
  board.len = 80;
}

void statusCtrl() {
  if (key == ENTER) {
    switch(status) {

    case GAME_START:
      status = GAME_PLAYING;
      break;

    case GAME_WIN:
      reset();
      status = GAME_START;
      break;

    case GAME_LOSE:
      reset();
      status = GAME_START;
      break;
    }
  }
}

void printText() {
  switch(status) {
  case GAME_START:
    fill(95, 194, 226);
    textSize(60);
    textAlign(CENTER);
    text("PING PONG", width/2, 240);

    textSize(20);
    textAlign(CENTER);
    text("Press ENTER to Start", width/2, 280);
    break;

  case GAME_WIN:
    fill(95, 194, 226);
    textSize(40);
    textAlign(CENTER);
    text("YOU WIN!!", width/2, 240);

    textSize(20);
    textAlign(CENTER);
    text("Press ENTER to Start", width/2, 280);
    break;

  case GAME_LOSE:
    fill(95, 194, 226);
    textSize(40);
    textAlign(CENTER);
    text("YOU SUCK!!", width/2, 240);

    textSize(20);
    textAlign(CENTER);
    text("Press ENTER to Start", width/2, 280);
    break;
  }
}

void keyPressed() {
  statusCtrl();
}

