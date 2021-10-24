

class Monkey {
  final static float R = 15;
  
  float x, y;
  float velX, velY;
  
  Monkey(float x, float y) {
    this.x = x;
    this.y = y;
    this.velX = 0;
    this.velY = 0;
  }
  
  void display() {
    fill(BROWN);
    noStroke();
    ellipse(this.x, this.y, R*2, R*2);
  }
  
  void update() {
    // this.x += this.velX;
    this.y += this.velY;
    
    this.velY += GRAV_ACC;
  }
  
  void handleJump(Trampoline[] trampolines, int nTrampolines) {
    for (int i = 0; i < nTrampolines; i++) {
      Trampoline tramp = trampolines[i];
      if (this.x >= tramp.x && this.x <= tramp.x + Trampoline.TRAMP_WIDTH && this.y + R > tramp.y && this.y - R < tramp.y) {
        this.y = tramp.y - R;
        this.velY = -this.velY + 0.5;
      }
    }
  }
  
  void grapple(Branch branch) {
    strokeWeight(2);
    stroke(BROWN);
    line(this.x, this.y, branch.x, branch.y);
    
    float angle = atan2(this.y - branch.y, this.x - branch.x);
    float speed = sqrt(pow(this.velX, 2) + pow(this.velY, 2)); 
    
    this.velX = cos(angle - PI / 2) * speed;
    this.velY = sin(angle - PI / 2) * speed;
  }
}
