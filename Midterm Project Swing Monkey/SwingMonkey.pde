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

void setup() {
  size(1000, 700);
  state = false;
  
  world = new World();
}

void draw() {
  background(BLUE);
  
  textSize(20);
  fill(255);
  String score = "Score: " + world.score;
  text(score, 30, textAscent() + 10);
  
  if(world.update(state)) world = new World();
  world.display();
} 




void keyPressed() {
  state = true;
}

void keyReleased() {
  state = false;
}
