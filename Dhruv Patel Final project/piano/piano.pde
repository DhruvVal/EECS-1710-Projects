import processing.sound.*;

final int WHITE = #FFFFFF;
final int BLACK = #000000;
final int GREY = #C8C8C8;
final int DARK_GREY = #484848;
final int YELLOW = #FFFF00;
final int RED = #FF0000;

final int nWhiteKeys = 21;
final int nBlackKeys = 15;

final char[] whiteKeyButtons = {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', ' '};
final char[] blackKeyButtons = {'2', '3', '5', '6', '7', '9', '0', 's', 'd', 'f', 'h', 'j', 'l', ';', char(39)};
final float[] whiteKeyFrequencies = {261.6256, 293.6648, 329.6276, 349.2282, 391.9954, 440.0000, 493.8833, 523.2511, 587.3295, 659.2551, 698.4565, 783.9909, 880.0000, 
                                    987.7666, 1046.502, 1174.659, 1318.510, 1396.913, 1567.982, 1760.000, 1975.533};
final float[] blackKeyFrequencies = {277.1826, 311.1270, 369.9944, 415.3047, 466.1638, 554.3653, 622.2540, 739.9888, 830.6094, 932.3275, 1108.731, 1244.508, 1479.978, 1661.219, 1864.655};


PianoKey[] whiteKeys;
PianoKey[] blackKeys;

PianoKey[] allKeys;

Wave w;

PImage noteImage;

void setup() {
  size(1200, 800);
  
  initKeys();
  w = new Wave();
  noteImage = loadImage("note.png");
  noteImage.resize(50, 50);
}

void draw() {
  background(GREY);
  
  float mouseSpeed = dist(mouseX, mouseY, pmouseX, pmouseY);
  
  for (int i = 0; i < allKeys.length; i++) {
    allKeys[i].display();
    allKeys[i].update(mouseSpeed);
  }
 
  w.display();
  w.update(getFrequencies(), getAmplitudes(), mouseSpeed);
  
}


float[] getFrequencies() {
  float[] frequencies = new float[Wave.MAX_WAVES];
  int index = 0;
  
  for (int i = 0; i < allKeys.length && index < Wave.MAX_WAVES; i++) {
    if (allKeys[i].getAmplitude() > 0) {
      frequencies[index] = allKeys[i].getFrequency();
      index++;
    }
  }
  
  float[] arrayResized = new float[index];
  for (int i = 0; i < index; i++) {
    arrayResized[i] = frequencies[i];
  }
  
  return arrayResized;
}

float[] getAmplitudes() {
  float[] amplitudes = new float[Wave.MAX_WAVES];
  int index = 0;
  
  for (int i = 0; i < allKeys.length && index < Wave.MAX_WAVES; i++) {
    if (allKeys[i].getAmplitude() > 0) {
      amplitudes[index] = allKeys[i].getAmplitude();
      index++;
    }
  }
  
  float[] arrayResized = new float[index];
  for (int i = 0; i < index; i++) {
    arrayResized[i] = amplitudes[i];
  }
  
  return arrayResized;
}



void initKeys() {
  whiteKeys = new PianoKey[nWhiteKeys];
  blackKeys = new PianoKey[nBlackKeys];
  allKeys = new PianoKey[nWhiteKeys + nBlackKeys];
  
  int j = 0;
  for (int i = 0; i < nWhiteKeys; i++) {
    whiteKeys[i] = new PianoKey(whiteKeyButtons[i], whiteKeyFrequencies[i], (width / float(nWhiteKeys)) * i, height * 0.75, width / float(nWhiteKeys), height * 0.25, WHITE, GREY);
    allKeys[i] = whiteKeys[i];
    
    if (i == 2 || i == 6 || i == 9 || i == 13 || i == 16 || i == 20) continue;
    
    blackKeys[j] = new PianoKey(blackKeyButtons[j], blackKeyFrequencies[j], (width / float(nWhiteKeys)) * (i + 0.75), height * 0.75, (width / float(nWhiteKeys)) / 2, height * 0.15, BLACK, GREY);
    allKeys[nWhiteKeys + j] = blackKeys[j];
    j++;
  }
}

color invertColor(color c) {
  return color(255 - red(c), 255 - green(c), 255 - blue(c));
}

void keyPressed() {
  for (int i = 0; i < allKeys.length; i++) {
    if (allKeys[i].isButton(key)) allKeys[i].press();
  }
}

void keyReleased() {
  for (int i = 0; i < allKeys.length; i++) {
    if (allKeys[i].isButton(key)) allKeys[i].release();
  }
}
