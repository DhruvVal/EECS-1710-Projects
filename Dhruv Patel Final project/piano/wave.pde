
class Wave {
  final static float X_SPACE = 1;
  final static int MAX_WAVES = 10;
  final static float MAX_FREQUENCY = 3000;
  final static float SPACE = 4;
  
  float yOrigin = 100;

  float maxAmplitude = 20;
  float[] dx = new float[MAX_WAVES];
  float[] y;
  float theta = 0;
  
  Wave() {
    this.y = new float[floor(width / X_SPACE)];
  }
  
  void display() {
    noStroke();
    fill(RED);
    
    for (int x = 0; x < y.length; x++) {
      circle(x * X_SPACE, this.yOrigin + y[x], 8);
    }
  }
  
  void update(float[] frequencies, float[] amplitudes, float mouseSpeed) {
    for (int i = 0; i < frequencies.length; i++) {
      dx[i] = (TWO_PI / (MAX_FREQUENCY - frequencies[i] + mouseSpeed)) * SPACE;
    }
    
    for (int i = 0; i < y.length; i++) {
      y[i] = 0;
    }
    
    theta -= 0.1;
    float x = theta;
    
    for (int j = 0; j < frequencies.length; j++) {
      x += theta;
      for (int i = 0; i < y.length; i++) {
        if (j % 2 == 0)  y[i] += sin(x)*maxAmplitude*amplitudes[j];
        else y[i] += cos(x)*maxAmplitude*amplitudes[j];
        x+=dx[j] * 10;
      }
    }
  }
  
}
