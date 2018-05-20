class Enemy {

  int x;
  int y;
  boolean active = true;  //to check if enemy is active or not 

  Enemy(int a, int b) {   //paramaterised constructor
    x = a;
    y = b;
  }
  void draw() { //drawing the enemy
    if (active) {
      image(monster, x, y, 30, 30); //enemy image and the location 
    }
  }
  boolean shoot(Bullet bullet) {
    if (bullet.x > x-20 && bullet.x < x+30   //intersection of the hit with bullet 
      && bullet.y > y-20 && bullet.y <y+30)
    {
      die();
      return true; // if shoot then returns true. 
    }
    return false; // if doesn't shoot then returns false.
   
  }


  void die() {
    active = false; //if enemy dies then active becomes false 
  }
}