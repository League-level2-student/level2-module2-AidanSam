//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int x;
int y;

// Add a constructor with parameters to initialize each variable.
Segment(int x,int y){
  this.x = x;
  this.y = y;
}
}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
ArrayList<Segment> tail = new ArrayList<Segment>();
int foodX;
int foodY;
int headX;
int headY;
int direction = UP;
int eaten = 0;

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
size(500,500);
frameRate(20);
headX = ((int)random(50)*10);
headY = ((int)random(50)*10);
head = new Segment(headX,headY);
dropFood();
}

void dropFood() {
  //Set the food in a new random location
 foodX = ((int)random(50)*10);
 foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0,0,255);
  drawFood();
  move();
  drawSnake();
  eat();
  
}

void drawFood() {
  //Draw the food
  fill(255,0,0);
  rect(foodX,foodY,10,10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(0,255,0);
  rect(head.x, head.y, 10,10);
  manageTail();
  
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
for(Segment s:tail){
  fill(0,255,0);
  rect(s.x,s.y,10,10);
}
}

void manageTail() {
  checkTailCollision();
  drawTail();
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  Segment seg = new Segment(head.x, head.y);
  tail.add(seg);
  tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(Segment s:tail){
    if(s.x == head.x && s.y == head.y){
     tail = new ArrayList<Segment>();
     eaten = 1;
     tail.add( new Segment(head.x, head.y));
     return;
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      direction = UP;
    }
    if (keyCode == DOWN) {
      direction = DOWN;
    }
    if (keyCode == LEFT) {
      direction = LEFT;
    }
    if (keyCode == RIGHT) {
      direction = RIGHT;
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
  
  switch(direction) {
  case UP:
    head.y -=10;
    break;
  case DOWN:
head.y +=10;
    break;
  case LEFT:
head.x -= 10;
    break;
  case RIGHT:
head.x +=10;
    break;
  }
checkBoundaries();
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.x>500){
  head.x=0; 
 }
 if(head.x<0){
  head.x=500; 
 }
 if(head.y>500){
  head.y=0; 
 }
 if(head.y<0){
  head.y=500; 
 }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
if(head.x==foodX){
  if(head.y==foodY){
  dropFood();
  eaten+=1;
  tail.add( new Segment(head.x, head.y));
  }
}
}
