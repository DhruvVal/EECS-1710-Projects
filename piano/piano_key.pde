

class PianoKey {
  
  private char inputKey;
  private float x, y;
  private float width, height;
  private color c, cPressed;
  private boolean pressed;
  private SinOsc oscilator;
  private float frequency;
  private float amplitude;
  
  PianoKey(char inputKey, float frequency, float x, float y, float width, float height, color c, color cPressed) {
    this.inputKey = inputKey;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.c = c;
    this.cPressed = cPressed;
    this.pressed = false;
    
    this.oscilator = new SinOsc(piano.this);
    this.oscilator.amp(0);
    this.oscilator.freq(frequency);
    this.frequency = frequency;
    this.amplitude = 0;
  }
  
  void display() {
    if (!this.pressed) fill(this.c);
    else fill(this.cPressed);
    stroke(BLACK);
    strokeWeight(4);
    rect(this.x, this.y, this.width, this.height);
    
    textSize(24);
    textAlign(CENTER);
    fill(invertColor(this.c));
    text(inputKey, this.x + this.width / 2, this.y + this.height / 5);
    
    if (this.amplitude > 0) {
      imageMode(CENTER);
      tint(255, 255 * this.amplitude);
      image(noteImage, this.x + this.width / 2, this.y - 300 * this.amplitude);
    }
  }
  
  void update(float mouseSpeed) {
    if (this.amplitude > 0) {
      this.amplitude -= 0.01;
      this.oscilator.amp(this.amplitude);
      this.oscilator.freq(this.frequency + mouseSpeed);
    }
    else {
      this.oscilator.stop();
    }
  }
  
  void press() {
    if (!this.pressed) {
      this.amplitude = 1;
      this.oscilator.play();
      this.pressed = true;
    }
  }
  
  void release() {
    this.pressed = false;
  }
  
  boolean isButton(char button) {
    return this.inputKey == button;
  }
  
  boolean isPressed() {
    return this.pressed;
  }
  
  float getFrequency() {
    return this.frequency;
  }
  
  float getAmplitude() {
    return this.amplitude;
  }
}
