

class Parallax {
  
  final static float BACK_RATE = 0.1;
  final static float MID_RATE = 1;
  
  private PImage back, mid;
  private float backX_1, midX_1, backX_2, midX_2;
  
  Parallax(PImage back, PImage mid) {
    this.back = back;
    this.mid = mid;
    this.backX_1 = 0;
    this.midX_1 = 0;
    this.backX_2 = back.width;
    this.midX_2 = mid.width;
  }
  
  void update(float dX) {
    this.backX_1 -= dX * BACK_RATE;
    this.midX_1 -= dX * MID_RATE;
    this.backX_2 -= dX * BACK_RATE;
    this.midX_2 -= dX * MID_RATE;
    
    if (floor(backX_1) < -this.back.width) backX_1 += 2*this.back.width;
    if (floor(backX_2) < -this.back.width) backX_2 += 2*this.back.width;
    if (floor(midX_1) < -this.mid.width) midX_1 += 2*this.mid.width;
    if (floor(midX_2) < -this.mid.width) midX_2 += 2*this.mid.width;
  }
  
  void display() {
    tint(100, 100, 100);
    image(this.back, floor(this.backX_1), 0);
    image(this.back, floor(this.backX_2), 0);
    image(this.mid, floor(this.midX_1), 0);
    image(this.mid, floor(this.midX_2), 0);
    noTint();
  }
}
