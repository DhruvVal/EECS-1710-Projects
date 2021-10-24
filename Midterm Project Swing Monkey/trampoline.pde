

class Trampoline {
  final static float TRAMP_WIDTH = 100;
  final static float TRAMP_HEIGHT = 10;
  
  float x, y;
  
  Trampoline(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    fill(YELLOW);
    noStroke();
    rect(this.x, this.y, TRAMP_WIDTH, TRAMP_HEIGHT, 10);
  }
  
}
