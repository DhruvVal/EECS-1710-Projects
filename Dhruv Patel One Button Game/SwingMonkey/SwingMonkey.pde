// Constants
final int BLUE = #0b0940;
final int YELLOW = #d9cf1c;
final int BROWN = #6e4021;
final int GREEN = #488f1d;
final int RED = #ff0000;

final float GRAV_ACC = 0.2;
///////////////////////////
boolean state;

World world;
PImage background;
PImage middleground;
PImage bananaImage;
PImage monkeyImage;
PImage snakeImage;
PImage snakeSkinImage;

void setup() {
  size(1000, 700);
  state = false;
  
  background = loadImage("mountains.jpg");
  background.resize(1900, 700);
  middleground = loadImage("forest.png");
  middleground.resize(1500, height+100);
  
  bananaImage = loadImage("banana.png");
  bananaImage.resize(int(Gold.R * 2), int(Gold.R * 2));
  
  monkeyImage = loadImage("monkey.png");
  monkeyImage.resize(180, 120);
  
  snakeImage = loadImage("snake.png");
  snakeImage.resize(105, 72);
  
  snakeSkinImage = loadImage("snakeSkin.jpg");
  snakeSkinImage.resize(width, 50);
  
  world = new World();
}

void draw() {
  background(0);
  
  if(world.update(state)) {
    world = new World();
  }
  world.display();
  
  textSize(20);
  fill(255);
  String score = "Score: " + world.score;
  text(score, 30, textAscent() + 10);
} 







void keyPressed() {
  state = true;
}

void keyReleased() {
  state = false;
}
