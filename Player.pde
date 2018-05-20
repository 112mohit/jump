class Player
{

  //declared static variable so that it can be shared in the class.  Final so that it can't be changed.
  static final float gravity = 0.25;   
  static final float bounceVel = 8;   
  static final float maxYVel = 12;    
  static final float maxXVel = 2;   

  float xVel, yVel;  
  int x, y;
  int w = 50, h = 45; //declaring w and h 
  Player(int x, int y) //paramatarised constructor
  {
    this.x = x;
    this.y = y;
  }

  void display()
  {
    fill(204, 0, 0);
    image(doodle, x, y, w, h); //image of the doodle
  }

  void move() //makes the doodle move 
  {
    x += xVel; //assigning x to x+ xVelocity 
    y += yVel; //assigning y to y+ xVelocity



    // makes the doodle come from other edge if it hits the edge 
    if (x > width-w) x = 0; //  right to left if x is greater than w idth - w, x = 0. Makes the doodle come from other side of the screen.
    if (x < 0) x = width-w; //left to right if x is less than 0 , x equals to width - w. Makes the doodle come from other side of the screen. 


    if (!gameOver)
    {
      if (leftPressed) xVel -= 0.50;  //if left key is pressed then the velocity of the player 
      else if (rightPressed) xVel += 0.50; //if right key is preseed then the velocity of the player 
      else
      {
        if (xVel > 0) xVel -= 0.50; //if left and right are not pressed then the velocity. 
        else  xVel = 0;    //makes the player bounce in centre only
      }
    }
    if (abs(xVel) < 0) xVel = 0;  //calculates the absolute value
    xVel = min(maxXVel, xVel);    //controls the velocity of the doodle left hand side
    xVel = max(-maxXVel, xVel);   //controls the velocity of the doodle right hand side


    yVel += gravity;  //gravity
    yVel = min(maxYVel, yVel);   //min returns the smallest value. returns the min value from the (maximum Y velocity and y Velocity)
    yVel = max(-maxYVel, yVel);  //max returns the largest value.
  }

  void collide(paddle player) 
  {

    if (x< player.x + player.w && x + w/2> player.x && y+h/2+h/4 <player.y + player.h && y + h> player.y) // intersection of doodle and the paddle when the player jumps on the paddle
    {

      if (yVel > 0) { //jump velocity
        // for bouncing after collide 
        yVel = -bounceVel;
      }
    }
  }


  void screenmove()
  {
    // above midpoint
    float aboveHeight = height * 0.5 -y; //height * 0.5 - y 
    if (aboveHeight > 0)
    {
      y += aboveHeight;
      for (int k=0; k<paddles.size(); k++) 
      {
        ((paddle)paddles.get(k)).y += aboveHeight;
      }
      if (millis() - startTime > 500) { 
        startTime = millis(); 
        score = score +1; //updating score every 500 milli sec
      }
    }
  }

  void removingpaddles() //removes the paddles at the bottom of the screen 
  {
    //looping through it 
    for (int k=paddles.size()-1; k>=0; k--) //decrementing
    {
      // scrolled off the bottom
      if (((paddle)paddles.get(k)).y > height)  //if paddle are less than height than it removes the paddle from the array list 
      {
        paddles.remove(k); //removes the paddle from the array list
      }
    }
  }

  void newpaddles() //get the new paddles 
  {
    if (paddles.size() < 7) //if paddles size is less than 7 
    {
      if (random(0, 10) < 5) paddles.add(new movingpaddle((int)random(100, width-80), -10, 70, 10)); //moving paddles //(-10- location, 70 width, 10 height)
      else paddles.add(new paddle((int)random(20, 200), -10, 70, 10)); // normal paddles at random location betweeen 20 and 200
    }
  }

void fire() {
  bullets.add(new Bullet(x, y));  //adding new bullet to an array
}

void play() {
  if (gameState==0) { //if user is in the instruction menu
    textSize(15);
    fill(255, 0, 0);
    text("LEFT and RIGHT to Move ", 120, 320);
    text("Press 'P' to pause", 120, 370);
    textSize(15);
    fill(255, 0, 0);
    text("Press 's' to Start game", 120, 300);
    text("Press 'space' to Shoot", 120, 350);
    if (keyPressed && key == 's') {
      gameState = 1;
    }
  }
}

void gameover() {
  if (gameState==2) { //if gameover
    textSize(20);
    text("GAME OVER!!", 100, 100);
    textSize(20);
    text("Press 'R' to restart", 75, 400);
    text("Your Score: " + score, 75, 250); //places players last score
    if (keyPressed && key == 'r') {
      gameState = 0;
      setup();
    }
  }
}
}