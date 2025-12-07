
//------------------------------------------------------------------------------------------------------------------------------------------

// top obstacle child class !! -------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------------------



class TopObstacle extends Obstacle {


  float bottomY;
  String shapeType;  // stores the type of shape (either "rect" or "circle")



  TopObstacle(float x) {
    super(x);           // call the parent Obstacle class constructor with the x position
    bottomY = 700;      // set the bottom y position of the obstacle to 700
    pos.y = 0;          // set the top position of the obstacle to 0 (top of the screen)
    shapeType = random(1) > 0.5 ? "rect" : "circle";   // randomly choose shape type (rectangle or circle)
  }



  // override boundaries for collision
  float getTop() {
    return 0;           // return the top edge (always at the top of the screen)
  }



  float getBottom() {
    return bottomY;     // return the bottom edge position (set to 700)
  }



  void display() {
    fill(0, 255, 0);    // set the color to green for the obstacle
    noStroke();         // disable the outline of the shape

    if (shapeType.equals("rect")) {  // if the shape is a rectangle
      rect(pos.x, pos.y, w, bottomY);  // draw a rectangle with width w and height bottomY
    } else {  // if the shape is a circle
      ellipse(pos.x + w / 2, bottomY / 2, w, bottomY);  // draw a circle with width w and height bottomY
    }
  }
}
