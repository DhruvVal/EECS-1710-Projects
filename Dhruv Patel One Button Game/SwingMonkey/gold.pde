

class Gold {
  
  final static float R = 20;
  
  float x, y;
  boolean taken;
  
  Gold(float x, float y) {
    this.x = x;
    this.y = y;
    this.taken = false;
  }
  
  void display() {
    if (!this.taken) {
      fill(YELLOW);
      imageMode(CENTER);
      image(bananaImage, this.x, this.y);
      imageMode(CORNER);
    }
  }
  
  boolean collision(Monkey monkey) {
    return dist(this.x, this.y, monkey.x, monkey.y) < R + Monkey.R;
  }
}
