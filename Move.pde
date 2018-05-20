class Move {
  float speedX=2; //speed variable 
  float speedY=10; //speed variable 

  Enemy [] enemys; //array of enemy

  Move(int numberofEnemys) {
    enemys = new Enemy[numberofEnemys]; 
    for (int i = 0; i < enemys.length; i++) //adding the enemys to the array starting from 0 to the end. 
    {
      enemys[i] = new Enemy(int(random(10,100)), int(random(40,180)));  //location of enemy
    }
  }

  void draw() {
    for (Enemy enemy : enemys)
    {
      enemy.x += speedX; //makes the enemy move on the X axis. 
      enemy.draw(); //drawing enemy from class enemy
    }

    if (enemys[0].x < 0 || enemys[enemys.length-1].x > width-20) {  //if the first enemy has hit the edge and the last enemy has hit the right edge
      speedX = -speedX; //moving opposite 
      for (Enemy enemy : enemys)
      {
        enemy.y += speedY; //when hits the edge it moves down on the y axis
      }
    }
  }


  void shoot(Bullet bullet) //loops through all the enemies 
  {
    for (Enemy enemy : enemys)
    {
      if (enemy.shoot(bullet)) {
        //score = score +2;
        return; // if shoot by bullet then it ends
      }
    }
  }
}