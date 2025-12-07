
//----------------------------------------------------------------------------------------------------------------------------
//
// sk00t demo
// plan to fully update this over break, just excited I got the actual gameplay to work!!
// this is pretty much google dino game with different graphics and a ducking mechanic lol
//
//----------------------------------------------------------------------------------------------------------------------------



// variables !! --------------------------------------------------------------------------------------------------------------

Lin lin;  // Lin object (the player sqaure, the square does have a name and it is indeed Lin)

boolean isGameOver = false;     // track whether the game ended
boolean isGameStarted = false;  // track whether the game started
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();   // obstacles array
int score = 0;   // default score is 0

PImage bg;   // background image variable
PGraphics bgBuffer;   // buffer for pre-rendered scroll background so this can run,, this took way too long to figure out
float bgX = 0;   // background x coordinate
float bgSpeed = 5;   // speed at which the background scrolls
float scoreCommentX = 400;   // variable for the end-game score comments x coordinate
float scoreCommentY = 250;   // variable for the end game score comments y coordinate





// void setup !! -------------------------------------------------------------------------------------------------------------

void setup() {
  size(800, 800);
  lin = new Lin(200, 700);  // initialize Lin (player square) at x and y coordinates

  bg = loadImage("background.PNG"); // load background image
  bg.resize(width, height);         // resize to fit window

  bgBuffer = createGraphics(width * 2, height);   // create a buffer twice the width of the screen for the scroll background

  // draw the background twice onto the buffer for seamless looping
  bgBuffer.beginDraw();
  bgBuffer.image(bg, 0, 0);
  bgBuffer.image(bg, width, 0);
  bgBuffer.endDraw();
}





// void draw !! --------------------------------------------------------------------------------------------------------------

void draw() {


  if (!isGameStarted) {
    showTitleScreen();  // show the title screen if the game hasn't started
    return;
  }


  // draw the scroll background using the buffer
  bgX -= bgSpeed; // move left
  if (bgX <= -width) {
    bgX = 0; // reset when the first half scrolls off screen
  }


  // loads in the background with the buffer
  image(bgBuffer, bgX, 0);


  if (isGameOver) {
    showGameOverScreen();  // if the game is over, show the game over screen
    return;
  }


  // update and display Lin
  lin.update();    // update Lin's position based on gravity and velocity
  lin.display();   // show Lin in all his square-shaped glory


  // adding obstacles every 100 frames
  if (frameCount % 100 == 0) {
    float x = 900;  // spawn the obstacle far to the right of the screen


    // randomly decide whether to spawn a TopObstacle or BottomObstacle
    if (random(1) > 0.5) {
      obstacles.add(new TopObstacle(x));    // spawn TopObstacle
    } else {
      obstacles.add(new BottomObstacle(x)); // spawn BottomObstacle
    }
  }


  // update and display obstacles
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle obs = obstacles.get(i);
    obs.update();
    obs.display();


    if (obs.offscreen()) {
      obstacles.remove(i);
      score++;
    }


    // check for collision with obstacles
    if (lin.hits(obs)) {
      isGameOver = true;
    }
  }


  // display the score on the screen
  fill(255);
  textSize(45);
  text("Score: " + score, width / 2, 120);
}





// key inputs!! --------------------------------------------------------------------------------------------------------------

void keyPressed() {


  if (key == 'w') {
    // apply an upward force when Lin jumps
    lin.jump();  // make Lin jump
  }


  if (key == 's') {
    // start ducking when s is pressed
    lin.isDucking = true;
  }


  if (key == ENTER && isGameOver) {
    // restart the game when ENTER is pressed
    restartGame();
  }


  if (key == ENTER && !isGameStarted) {
    // start the game when ENTER is pressed on the title screen
    isGameStarted = true;
  }
}





// key released input for ducking !! -----------------------------------------------------------------------------------------
void keyReleased() {
  if (key == 's') {
    // stop ducking when s is released
    lin.isDucking = false;
  }
}





// custom functions!! --------------------------------------------------------------------------------------------------------

// the title screen
void showTitleScreen() {
  background(0);

  textAlign(CENTER, CENTER);
  fill(255, 80, 150);
  textSize(60);
  text("SK00T", width / 2, height / 2 - 50);

  fill(255);
  textSize(32);
  text("Press ENTER to Start", width / 2, height / 2 + 50);
}



// game over screen
void showGameOverScreen() {
  background(0);
  fill(255, 0, 0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width / 2, height / 2 - 40);

  textSize(24);
  fill(255);
  text("Score: " + score, width / 2, height / 2);
  text("Press ENTER to Restart", width / 2, height / 2 + 40);



  // silly comments that happen depending on your score
  if (score <= 2) {
    textSize(20);
    text("Nobody sucks THAT bad bro c'mon-", scoreCommentX, scoreCommentY);
  } else if (score > 2 && score <= 5) {
    text("Omg dude you really need to practice...", scoreCommentX, scoreCommentY);
  } else if (score > 5 && score <= 10) {
    text("Ok not bad!!", scoreCommentX, scoreCommentY);
  } else if (score > 10 && score <= 20) {
    text("Gettin' tech! :D", scoreCommentX, scoreCommentY);
  } else if (score > 20 && score <= 50) {
    text("Surprisingly good job!! Suspiciously so!!!", scoreCommentX, scoreCommentY);
  } else if (score > 50 && score <= 100) {
    text("Ok so now I KNOW you're cheating dude.", scoreCommentX, scoreCommentY);
  } else if (score > 100) {
    text("How on earth did you make it past 100??? D: ABSOLUTELY CRACKED", scoreCommentX, scoreCommentY);
  }
}



// handling how the game restart works
void restartGame() {
  isGameOver = false;
  score = 0;
  obstacles.clear();
  lin = new Lin(200, 700); // resets Lin to starting position
}



//----------------------------------------------------------------------------------------------------------------------------
