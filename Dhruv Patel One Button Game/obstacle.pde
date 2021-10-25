

class Obstacle {
  
  float x, y, width, height;
  PImage image;
  
  Obstacle(float x, float y, float width, float height, PImage image) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.image = image;
  }
  
  void display() {
    noStroke();
    fill(RED);
    // rect(this.x, this.y, this.width, this.height);
    if (this.image != null) image(this.image, this.x, this.y);
  }
  
  boolean collision(Monkey monkey) {
    float[] x = new float[4];
    float[] y = new float[4];
    
    x[0] = this.x;
    y[0] = this.y;
    
    x[1] = this.x + this.width;
    y[1] = this.y;
    
    x[2] = this.x;
    y[2] = this.y + this.height;
    
    x[3] = this.x + this.width;
    y[3] = this.y + this.height;
    
    for (int i = 0; i < 4; i++) {
      if (dist(monkey.x, monkey.y, x[i], y[i]) < 10) return true;
    }
    
    if (monkey.x >= x[0] && monkey.x <= x[1] && monkey.y + Monkey.R > y[0] && monkey.y - Monkey.R < y[0]) return true;
    if (monkey.x >= x[2] && monkey.x <= x[3] && monkey.y - Monkey.R < y[2] && monkey.y + Monkey.R > y[2]) return true;
    if (monkey.y >= y[1] && monkey.y <= y[3] && monkey.x - Monkey.R < x[1] && monkey.x + Monkey.R > x[1]) return true;
    if (monkey.y >= y[0] && monkey.y <= y[2] && monkey.x + Monkey.R > x[0] && monkey.x - Monkey.R < x[0]) return true;
    
    return false;
  }
}
