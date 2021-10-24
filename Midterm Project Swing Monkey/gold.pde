

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
      ellipse(this.x, this.y, 2*R, 2*R);
    }
  }
  
  boolean collision(Monkey monkey) {
    return dist(this.x, this.y, monkey.x, monkey.y) < R + Monkey.R;
  }
}
