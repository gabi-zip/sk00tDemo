
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// lin (player) class !! ---------------------------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Lin {



  PVector pos;           // position of lin
  PVector vel;           // velocity of lin
  PVector gravity;       // gravity vector
  float w = 40;
  float h = 80;

  float lift = -35;          // jump height (negative value for upward force)

  boolean isDucking = false; // boolean tracking if Lin is ducking
  float duckSpeed = 8;       // downward speed when Lin is ducking
  float minY = 700;          // default resting y
  float maxDuckY = 750;      // maximum y-position lin can reach while ducking
  boolean canJump = true;    // boolean tracking if lin is allowed to jump



  Lin(float x, float y) {
    pos = new PVector(x, y);   // default position of x and y
    vel = new PVector(0, 0);   // default velocity as 0
    gravity = new PVector(0, 1.4);  // set gravity to affect the velocity
  }



  void update() {
    vel.add(gravity);        // apply gravity to the velocity
    pos.add(vel);            // update position based on velocity

    // apply ducking motion
    if (isDucking) { 
      pos.y += duckSpeed;                      // move Lin down while ducking
      if (pos.y > maxDuckY) pos.y = maxDuckY;  // limit the depth of ducking
    }

    // prevent falling below minY when not ducking
    if (!isDucking && pos.y >= minY) { 
      pos.y = minY;       // keep lin at the resting y
      vel.y = 0;          // stop vertical velocity when "landing"
      canJump = true;     // allow jumping again once lin "lands"
    }

    // prevent going above the screen (only needed during the first drafts/when you could jump iinfinitely, now makes everything when taken out so it stays lol,, my coconut.jpg)
    if (pos.y < h / 2) {    
      pos.y = h / 2;      // stops lin at the top of the screen
      vel.y = 0;          // stop vertical velocity
    }
  }



  void jump() {
    if (canJump) {       // only jump if allowed
      vel.y = lift;      // apply upward velocity to jump
      canJump = false;   // disable jumping until lin lands
    }
  }



  void display() {
    fill(255);
    noStroke();
    rect(pos.x - w / 2, pos.y - h / 2, w, h);  // draw lin as a rectangle centered at pos
  }



  boolean hits(Obstacle obs) {
    return obs.hits(pos, w, h);  // check if lin collides with an obstacle
  }
}
