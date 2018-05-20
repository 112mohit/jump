class paddle
{
   int x, y, w, h;
   float xvel, yvel;

  paddle(int x, int y, int w, int h) //paramatrised constructor
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display()
  {
    image(green, x, y, w, h); //displaying the paddles
  }

  void move() //makes the paddle move
  {
    x += xvel; // x= x+xVelocity
  }
}

class movingpaddle extends paddle { //subclass of the class paddle

  int speed = 3;  //speed of the moving paddle 
  movingpaddle(int x, int y, int w, int h) //parameters of the moving paddle 
  {
    super(x, y, w, h); //calls the constructor of the parent class paddle 
    this.xvel = speed; 
  }

  void move()
  {
    super.move(); //moving paddle 
    if ( (x+w > width - 10) || (x < 10) ) //moving paddle area 
    {
      xvel *= -1; // velocity of the moving paddle after touching the edge
    }
  }
}