
PImage baseImage;
float initialSize = 100;
float baseImageWidth = initialSize;
float baseImageHeight = initialSize;

PImage targetImages[];
int targetIndex;

String baseImagePath = "beetlejuice.png";
String[] targetImagePaths = {"barack-obama.jpg", "brad-pitt.jpg", "donald.jpg", "eminem.jpg", "johnny-depp.jpg"};
int[] shuffle;
int nImages = 5;

int stage = 0; // 0 -> rules, 1 -> in-game, 2 -> score
boolean guessMade = false;

int score = 0;

void setup() {
  size(1300, 900);
  // noLoop();
  
  baseImage = loadImage(baseImagePath);
  baseImage.resize(floor(baseImageWidth), floor(baseImageHeight));
  
  targetImages = new PImage[nImages];
  for (int i = 0; i < nImages; i++) {
    targetImages[i] = loadImage(targetImagePaths[i]);
    targetImages[i].resize(900, 900);
  }
  targetIndex = 0;
}

void draw() {
  if (guessMade) {
    if (mousePressed) {
      if (targetIndex < nImages - 1) {
        baseImageWidth = initialSize;
        baseImageHeight = initialSize;
        baseImage = loadImage(baseImagePath);
        baseImage.resize(floor(baseImageWidth), floor(baseImageHeight));
        targetIndex++;
        guessMade = false;
      } else {
        guessMade = false;
        stage = 2;
      }
    }
  } else if (stage == 0) {
      background(0);
      textAlign(CENTER);
      textSize(30);
      text("Guess the celebrity as fast\nas possible by pressing 1-5, as follows:", width / 2, height / 2 - 50);
      text("Barack Obama - 1", width / 2, height / 2 + 50);
      text("Brad Pitt - 2", width / 2, height / 2 + 100);
      text("Donald Trump - 3", width / 2, height / 2 + 150);
      text("Eminem - 4", width / 2, height / 2 + 200);
      text("Johnny Depp - 5", width / 2, height / 2 + 250);
      text("Press any key to begin...", width / 2, height - 100);
      
      if (keyPressed) {
        stage = 1;
        score = 0;
        
        shuffle = new int[nImages];
        for (int i = 0; i < nImages; i++) {
          shuffle[i] = i;
        }
        for (int i = 0; i < nImages; i++) {
          int j = floor(random(0, nImages));
          int temp = shuffle[j];
          shuffle[j] = shuffle[i];
          shuffle[i] = temp;
        }
      }
    } else if (stage == 1) {
      background(0);
      drawGrid();
      // saveFrame();
      
      if (baseImageWidth > 1.1) baseImageWidth -= 0.1;
      if (baseImageHeight > 1.1) baseImageHeight -= 0.1;
      
      baseImage = loadImage(baseImagePath);
      baseImage.resize(floor(baseImageWidth), floor(baseImageHeight));
      
      fill(255);
      textSize(24);
      textAlign(CORNER);
      text("Guess the image with \nthe following keys:", 1000, 50);
      text("Barack Obama - 1", 1000, 200);
      text("Brad Pitt - 2", 1000, 200 + 24);
      text("Donald Trump - 3", 1000, 200 + 48);
      text("Eminem - 4", 1000, 200 + 72);
      text("Johnny Depp - 5", 1000, 200 + 96);
      
      if (keyPressed && !guessMade) {
        if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5') {
          if (int(key) - int('1') == shuffle[targetIndex]) {
            textAlign(CENTER);
            textSize(36);
            text("You guessed right!\nClick mouse to continue!", width / 2, height / 2);
            guessMade = true;
            score += baseImageWidth;
          }
          else {
            textAlign(CENTER);
            textSize(36);
            text("You guessed wrong!\nClick mouse to continue!", width / 2, height / 2);
            guessMade = true;
          }
        }
      }
  } else if (stage == 2) {
    background(0);
    textAlign(CENTER);
    textSize(30);
    text("Game completed. Score: " + str(score), width / 2, height / 2 - 50);
    text("Press any key to play again...", width / 2, height - 100);
    if (keyPressed) {
      stage = 1;
      score = 0;
      targetIndex = 0;
    
      shuffle = new int[nImages];
      for (int i = 0; i < nImages; i++) {
        shuffle[i] = i;
      }
      for (int i = 0; i < nImages; i++) {
        int j = floor(random(0, nImages));
        int temp = shuffle[j];
        shuffle[j] = shuffle[i];
        shuffle[i] = temp;
      }
    }
  }
}

color getTint(int x, int y) {
  int r = 0;
  int g = 0;
  int b = 0;
  int nColors = 0;
  
  for (int i = 0; i < baseImageHeight && y + i < targetImages[shuffle[targetIndex]].height; i++) {
    for (int j = 0; j < baseImageWidth && x + j < targetImages[shuffle[targetIndex]].width; j++) {
      color c = targetImages[shuffle[targetIndex]].get(x + j, y + i);
      r += red(c);
      g += green(c);
      b += blue(c);
      nColors++;
    }
  }
  
  return color(r / nColors, g / nColors, b / nColors);
}

void drawGrid() {
  for (int y = 0; y < targetImages[shuffle[targetIndex]].height; y+=baseImageHeight) {
    for (int x = 0; x < targetImages[shuffle[targetIndex]].width; x+=baseImageWidth) {
      tint(getTint(x, y));
      image(baseImage, x, y);
    }
  }
}

//void keyPressed() {
//  if (key == '+') {
//    baseImageWidth++;
//    baseImageHeight++;
//  }
//  else if (key == '-') {
//    baseImageWidth--;
//    baseImageHeight--;
//  }
  
//  baseImageWidth = constrain(baseImageWidth, 1, width);
//  baseImageHeight = constrain(baseImageHeight, 1, height);
//}
