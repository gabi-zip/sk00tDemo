
//---------------------------------------------------------------------------------------------------------------------------------------------

// bottom obstacle child class !! -------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------------------------



class BottomObstacle extends Obstacle {
  float obstacleHeight;  // stores the height of the bottom obstacle



  BottomObstacle(float x) {
    super(x);                         // call the parent Obstacle class constructor with the x position
    obstacleHeight = 300;
    pos.y = height - obstacleHeight;  // position the obstacle near the bottom of the screen
  }



  float getTop() {
    return pos.y;       // return the y position of the top edge of the obstacle
  }

  float getBottom() {
    return height;      // return the bottom of the screen height
  }



  void display() {
    fill(255, 0, 0);
    noStroke();                             
    rect(pos.x, pos.y, w, obstacleHeight);  // draw a rectangle with width w and height obstacleHeight
  }
}
