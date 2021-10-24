

class World {
  
  private Monkey monkey;
  private boolean grappled;
  private Branch branchNearest;
  
  private Trampoline[] trampolines;
  private int nTrampolines = 1;
  
  private Branch[] branches;
  private int nBranches = 3;
  
  private Obstacle top;
  private Obstacle bottom;
  
  private Obstacle[] obstacles;
  private int nObstacles = 1;
  
  private Gold[] gold;
  private int nGold = 1;
  
  private int score = 0;
  
  World() {
    this.monkey = new Monkey(100, 150);
    this.grappled = false;
    
    this.trampolines = new Trampoline[1];
    this.trampolines[0] = new Trampoline(50, 400);
    
    this.branches = new Branch[this.nBranches];
    this.branches[0] = new Branch(width * 1/4);
    this.branches[1] = new Branch(width * 3/4);
    this.branches[2] = new Branch(width * 5/4);
    
    this.branchNearest = this.getNearest();
    
    this.top = new Obstacle(0, 100, width, 5);
    this.bottom = new Obstacle(0, height - 5, width, 5);
    
    this.obstacles = new Obstacle[this.nObstacles];
    this.obstacles[0] = new Obstacle(width / 2, random(height / 2, height / 1.1), 100, 15);
    
    this.gold = new Gold[nGold];
    this.gold[0] = new Gold(this.obstacles[0].x + this.obstacles[0].width / 2, this.obstacles[0].y - 150);
  }
  
  boolean update(boolean state) {
    this.monkey.update();
    this.monkey.handleJump(this.trampolines, this.nTrampolines);
    
    if (!grappled) this.branchNearest = this.getNearest();
    
    if (state) {
      this.monkey.grapple(branchNearest);
      this.grappled = true;
    } else {
      this.grappled = false;
    }
    
    for (int i = 0; i < this.nTrampolines; i++) {
      this.trampolines[i].x -= this.monkey.velX;
    }
    
    for (int i = 0; i < this.nBranches; i++) {
      this.branches[i].x -= this.monkey.velX;
      if (this.branches[i].x < -width / 2) this.branches[i] = new Branch(width);
    }
    
    for (int i = 0; i < this.nObstacles; i++) {
      this.obstacles[i].x -= this.monkey.velX;
      if (this.obstacles[i].collision(this.monkey)) return true;
      if (this.obstacles[i].x < -this.obstacles[i].width) this.obstacles[i] = new Obstacle(width, random(height / 2, height / 1.1), 100, 15);
      
      this.gold[i].x -= this.monkey.velX;
      if (this.gold[i].collision(this.monkey) && !this.gold[i].taken) {
        this.score++;
        this.gold[i].taken = true;
      }
      if (this.gold[i].x < -Gold.R) this.gold[i] = new Gold(this.obstacles[i].x + this.obstacles[i].width / 2, this.obstacles[i].y - 150);
    }

    
    if (this.top.collision(this.monkey)) return true;
    if (this.bottom.collision(this.monkey)) return true;
    
    return false;
  }
  
  void display() {
    this.monkey.display();
    
    for (int i = 0; i < this.nTrampolines; i++) {
      this.trampolines[i].display();
    }
    
    for (int i = 0; i < this.nBranches; i++) {
      this.branches[i].display();
    }
    
    for (int i = 0; i < this.nObstacles; i++) {
      this.obstacles[i].display();
    }
    
    for (int i = 0; i < this.nGold; i++) {
      this.gold[i].display();
    }
    
    this.top.display();
    this.bottom.display();
  }
  
  Branch getNearest() {
    float min = width;
    Branch nearest = null;
    for (int i = 0; i < this.nBranches; i++) {
      if (this.branches[i].x >= this.monkey.x) {
        float dist = dist(this.monkey.x, this.monkey.y, this.branches[i].x, this.branches[i].y);
        if (dist < min) {
          min = dist;
          nearest = this.branches[i];
        }
      }
    }
    return nearest;
  }
}
