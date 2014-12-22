class Ball {
  float x;
  float y;
  float size;
  float xSpeed;
  float ySpeed;
  boolean afterClick = false;

  void move() {
    if (mouseButton == RIGHT) {
      afterClick = true;
    }
    if (afterClick == true) {
      x += xSpeed;
      y += ySpeed;
      for (int i=0; i<brick.length; i++) {
        if (isHit(x, y, size, brick[i].x, brick[i].y, brick[i].bWidth, brick[i].bHeight) == true) {
          ySpeed *= -1;
          brick[i].hit = true;
        }
      }
      if (isHit(x, y, size, board.x, board.y, board.len, 10) == true) {
        ySpeed *=-1;
        xSpeed = (this.x-board.x)/board.len*8;
      }
      if ( x < size/2 || x + size/2 >width) {
        xSpeed *= -1;
      }
      if ( y < size/2) {
        ySpeed *= -1;
      }
      if (y>800) {        
        afterClick = false;
        y=2000;
        ySpeed*=-1;
        xSpeed= random(-5,5);
        board.len = 80;
      }
    } else {
      x=board.x;
      y=board.y-size-5;
    }
  }


  void display() {
    fill(255);
    noStroke();
    ellipse( x, y, size, size);
  }

  boolean isHit(
  float circleX, 
  float circleY, 
  float radius, 
  float rectangleX, 
  float rectangleY, 
  float rectangleWidth, 
  float rectangleHeight)
  {
    float circleTop = circleY-radius;
    float circleLeft = circleX-radius;
    float circleRight = circleX+radius;
    float circleBottom = circleY+radius;
    float rectAX = rectangleX-rectangleWidth/2;
    float rectAY = rectangleY-rectangleHeight/2;
    float rectBX = rectAX;
    float rectBY = rectangleY+rectangleHeight/2;
    float rectCX = rectangleX+rectangleWidth/2;
    float rectCY = rectBY;
    float rectDX = rectCX;
    float rectDY = rectAY;
    boolean colision=false;
    if (circleX >= rectBX && circleX<= rectCX && circleTop<=rectCY && circleTop>=rectAY) { 
      colision = true;
    }
    if (circleX >= rectAX && circleX<= rectDX && circleBottom>=rectAY && circleBottom<=rectCY) { 
      colision = true;
    }

    if (circleY>=rectAY && circleY<= rectBY && circleRight>=rectAX && circleRight<=rectCX) { 
      colision = true;
    }
    if (circleY>=rectDY && circleY<= rectCY && circleLeft>=rectAX && circleLeft<=rectCX) { 
      colision = true;
    }
    return colision;
  } 

  Ball(float x, float y, float size, float xSpeed) {
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    ySpeed = -5;
    this.size = size;
  }
}
