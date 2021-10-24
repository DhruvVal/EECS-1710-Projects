

class Branch {
  
  final static float Y_MIN = 10;
  final static float Y_MAX = 100;
  final static float R = 15;
  
  float x, y;
  
  Branch(float x) {
    this.x = x;
    this.y = random(Y_MIN, Y_MAX);
  }
  
  void display() {
    fill(GREEN);
    ellipse(this.x, this.y, R, R);
  }
}
