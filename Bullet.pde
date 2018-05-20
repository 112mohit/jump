class Bullet {
  int x, y;
  int speed = 7;

  Bullet(int a, int b) { ////paramatarised constructor
    x = a;
    y = b;
  }

  void draw() {
    y -= speed; //moving up so substracts speed from y pos.
    ellipse(x, y, 4, 8);
    move.shoot(this); // calling the function from the move if the enemy dies from the bullet. current object of this class. 
  }  

}