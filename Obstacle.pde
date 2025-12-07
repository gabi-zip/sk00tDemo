
//---------------------------------------------------------------------------------------------------------------------------------------

// obstacle parent class !! -------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------------------



class Obstacle {
  PVector pos;        // position
  float w = 50;       // width of obstacle
  int speed = 13;     // obstacle vmovement speed

  Obstacle(float x) {
    pos = new PVector(x, 0);
  }

  // move obstacle left
  void update() {
    pos.x -= speed;
  }

  // check if off screen
  boolean offscreen() {
    return pos.x < -w;
  }

  // generic collision function
  boolean hits(PVector playerPos, float playerW, float playerH) {
    // get bounding info from subclass
    float top = getTop();
    float bottom = getBottom();
    float left = pos.x;
    float right = pos.x + w;

    // rectangle collision
    return (playerPos.x + playerW / 2 > left &&
      playerPos.x - playerW / 2 < right &&
      playerPos.y - playerH / 2 < bottom &&
      playerPos.y + playerH / 2 > top);
  }

  // top and bottom boundaries
  float getTop() {
    return 0;
  }

  float getBottom() {
    return height;
  }

  void display() {
    // overridden by subclasses
  }
}
