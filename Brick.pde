class Brick {
  float x;
  float y;
  float bWidth;
  float bHeight;
  boolean hit = false;
  boolean firstHit = true;
  int R;
  int G;
  int B;
  void display() {
    fill(R, G, B);
    rectMode(CENTER);
    rect(x, y, bWidth, bHeight, 5);
  }

  Brick(float x, float y,int R, int G, int B) {
    this.x = x;
    this.y = y;
    this.R = R;
    this.G = G;
    this.B = B;
    bWidth = 30;
    bHeight =30;
  }
}
