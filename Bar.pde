class Bar {
  float x;
  float y;
  float len;
  boolean afterClick = false;

  void move() {
    x = width/2;
    x = mouseX;
    if ( x - len/2 < 0) {
      x = len/2;
    }
    if ( x + len/2 > width) {
      x = width - len/2;
    }
  }

  void display() {
    fill(255);
    rectMode(CENTER);
    rect(x, y, len, 10);
  }

  Bar(float len) {
    this.y = height-40;
    this.len = len;
  }
}
