/* REFERENCES

* Lecture videos by Marco
* Videos by Marco on vimeo
* lecture Notes 
* Space Invaders example code and video by Marco 
* Processing.org/references for references
* foundation year notes and examples 
* feedback from friends 
* For score- http://processing.flosscience.com/processing-for-android/macul-2012/keeping-score-and-ending-the-game
* Goldoverflow for pause state 
* classes submission programm for the character to move from on edge to other edge. 
* For static- https://processing.org/reference/static.html 
* For final- https://processing.org/reference/final.html
* For boolean- https://www.youtube.com/watch?v=wsI6N9hfW7E
* For .this - https://www.youtube.com/watch?v=ZxhZLoL_HZo
* for array loops - https://www.youtube.com/watch?v=Wy8vIVoAxT4
* For gamestate- http://www.sci.brooklyn.cuny.edu/~sklar/teaching/s09/cis3.5/hw/labIII.3.pdf
* Images used from - https://www.cs.duke.edu/courses/fall10/cps108/code/src/vooga/games/doodlejump/resources/images/

How To play- 

Use LEFT and RIGHT arrow to moe left and right. 
S to start the game and P to pause the game 
Space to fir the bullet
The character jumps automatically. 


*/


Player player;
Move move;
ArrayList paddles;
boolean leftPressed, rightPressed;
int score = 0;
int dropCount;
boolean gameOver;
PImage bg;
PImage green;
PImage doodle;
PImage monster;
boolean pause = false;
int gameState;
float startTime = 0;
//Bullet [] bullets = {};  //empty array of bullet. 
ArrayList bullets = new ArrayList();
ArrayList enemys = new ArrayList();


void setup()
{
  size(320, 480); //size of the screen 
  bg = loadImage("bg.jpg"); //background image
  green = loadImage("green.png"); //paddle image
  doodle = loadImage("doodle.png"); //doodle image
  monster = loadImage("monster.png"); //enemy image
  score = 0;
  dropCount = 0;
  gameOver = false;
  player = new Player(160, 240); //displaying the player at the middle of the screen 
  move = new Move (5);  // number of enemies 
  paddles = new ArrayList(); //new array list paddles 
  paddles.add(new movingpaddle(20, 80, 70, 8));
  paddles.add(new paddle(100, 420, 100, 8));
  paddles.add(new paddle((int)random(40, 180), 320, 100, 8)); //x loc y loc width and height  y location reducing by 100 everytime 
  paddles.add(new paddle((int)random(40, 180), 220, 100, 8));
  paddles.add(new paddle((int)random(40, 180), 120, 100, 8));
  paddles.add(new paddle((int)random(40, 180), 20, 100, 8));
}


void draw()
{ 

  background(bg);
  if (gameState==1) {
  text("Score: " + score, 20, 20);
  }
  player.display();
  if (!pause) {
    player.play(); //calling from the class player 
    player.gameover(); //calling from the calss player

     //looping through bullets to draw them 
      for (int i = 0; i < bullets.size(); i++) {
        Bullet bullet = (Bullet) bullets.get(i);
        bullet.draw(); //calling the draw function from class bullet
      }
 

    if (gameState==1) {
      move.draw();

      for (int k=0; k<paddles.size(); k++)  //for loop checking for paddles and updating it. 
      {

        player.collide((paddle)paddles.get(k));
        ((paddle)paddles.get(k)).display();  //displaying the paddles 
        ((paddle)paddles.get(k)).move();   // moving the paddles
      }
      player.display(); //displaying the player 
      player.move();  //moving the player


      player.screenmove(); //calling the function from the class player
      player.removingpaddles(); //calling the function from the class player
      player.newpaddles(); //calling the function from the class player

      if (paddlesBelow() == 0) gameOver=true;  
      if (gameOver)dropCount++;
      if (dropCount > 10 ) gameState=2; // distance when the player falls // and what to after the fall
    }
  }
}

int paddlesBelow()  //if the doodle doesn't jump on the paddle if its equal to 0 then game over
{
  int count = 0;

  for (int k=0; k<paddles.size(); k++) //paddles.size gets the length of the list 
  {
    if (((paddle)paddles.get(k)).y >= player.y) count++; //paddles.get gets the particular entry of the list 
  }

  return count;
}



void keyPressed()
{

  
  if (keyCode == RIGHT) rightPressed = true; 
  if (keyCode == LEFT) leftPressed = true; 

  if (key == 'p') {     //if p i pressed then pause the game
    pause = !pause;
  }
  if (key == ' ')
  {
    player.fire();
  }
}

void keyReleased()
{
  if (keyCode == RIGHT) rightPressed = false;
  if (keyCode == LEFT) leftPressed = false; 
}