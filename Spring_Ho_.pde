import processing.video.Capture;
Capture cam;// 
int threshold = 20; 
int aveX;
int aveY;
float objectR =255;
float objectG = 0;
float objectB = 0;



Shape self;
ArrayList<Shape> sun;
ArrayList<Shape> rain;
ArrayList<Shape> snow;

PFont text;
PImage spring;

int count;

boolean start;
boolean win;

void setup() {
  size(1280, 720);
  println(Capture.list());
  cam = new Capture(this, width, height);
  cam.start();

  //GAME STUFF:
  spring = loadImage("spring.jpg");
  self = new Shape(0, width-aveX, height-aveX);
  sun = new ArrayList<Shape>();
  for (int i=0;i<30; i++) {
    sun.add(new Shape(1));
  }

  rain = new ArrayList<Shape>(); 
  for (int i=0;i<40; i++) {
    rain.add(new Shape(3));
  }
  snow = new ArrayList<Shape>();
  for (int i=0;i<20; i++) {
    snow.add(new Shape(2));
  }
  count = 0;

  text = loadFont("HanziPenSC-W5-48.vlw");
  //win = loadImage;

  start = false;
  win = false;
}
void draw() {
  if (cam.available()) {
    cam.read();
    int totalFoundPixels= 0;  //we are going to find the average location of change pixes so
    int sumX = 0;  //we will need the sum of all the x find, the sum of all the y find and the total finds
    int sumY = 0;
    //enter into the classic nested for statements of computer vision
    for (int row = 0; row < cam.height; row++) {
      for (int col = 0; col < cam.width; col++) {
        //the pixels file into the room long line you use this simple formula to find what row and column the sit in 

        int offset = row * cam.width + col;
        //pull out the same pixel from the current frame 
        int thisColor = cam.pixels[offset];

        //pull out the individual colors for both pixels
        float r = red(thisColor);
        float g = green(thisColor);
        float b = blue(thisColor);

        //in a color "space" you find the distance between color the same whay you would in a cartesian space, phythag or dist in processing
        float diff = dist(r, g, b, objectR, objectG, objectB);

        if (diff < threshold) {  //if it is close enough in size, add it to the average
          sumX = sumX + col;
          sumY= sumY + row;
          totalFoundPixels++;
          //if (debug) cam.pixels[offset] = 0xff000000;//debugging
        }
      }
    }
    if (totalFoundPixels > 0) {
      aveX = sumX/totalFoundPixels;
      aveY = sumY/totalFoundPixels;
    }

    if (start==false && win == false) {
      image(cam, 0, 0);
      textFont(text, 32);
      text("Mouse click to begin tracking. Then press '1' to begin the game!", 250, 100);
      self.self_move(width-aveX, aveY, 0); 
    }
    else if (start == true && win == false) {//begin game
      background(70, 130, 180);
      //GAME CODE:
      if (count < 10) {
        //40 rain, 20 snow
        //MOVE WEATHER: 
        for (int i=0;i<snow.size()-1; i++) {
          snow.get(i).moveWeather(2);
          if (snow.get(i).checkBoundaries()) {
            snow.get(i).reset_position();
          }
        }
        for (int i=0;i<rain.size()-1; i++) {
          rain.get(i).moveWeather(3);
          if (rain.get(i).checkBoundaries()) {
            rain.get(i).reset_position();
          }
        }
        for (int i=0;i<sun.size()-1; i++) {
          sun.get(i).moveWeather(1);
          if (sun.get(i).checkBoundaries()) {
            sun.get(i).reset_position();
          }
          if (sun.get(i).check_Collision(self)) {
            count++;
            System.out.println(count);
            sun.remove(i);
          }
        }
        self.self_move(width-aveX,aveY, 0);
      }//end of score 1 (count < 10)
      
      else if (count < 15 && count >= 10) { //other score:
      System.out.println("2");
        background(133, 228, 247);
        //30 rain, 10 snow
        for (int i = 0; i<rain.size()-10; i++) {
          rain.remove(i);
        }
        for (int i = 0; i<snow.size()-10; i++) {
          snow.remove(i);
        }
        //MOVE WEATHER:
        for (int i=0;i<snow.size()-1; i++) {
          snow.get(i).moveWeather(2);
          if (snow.get(i).checkBoundaries()) {
            snow.get(i).reset_position();
          }
        }
        for (int i=0;i<rain.size()-1; i++) {
          rain.get(i).moveWeather(3);
          if (rain.get(i).checkBoundaries()) {
            rain.get(i).reset_position();
          }
        }

        for (int i=0;i<sun.size()-1; i++) {
          sun.get(i).moveWeather(1);
          if (sun.get(i).checkBoundaries()) {
            sun.get(i).reset_position();
          }
          if (sun.get(i).check_Collision(self)) {
            count++;
            sun.remove(i);
          }
        }
        self.self_move(width-aveX, aveY, 0);
      }// End of Score 

      else if (count <  20 && count >= 15) { //other score
      System.out.println("3");
        background(131, 205, 247);
        //25 rain drops, 5 snow
        for (int i = 0; i<rain.size()-4; i++) {
          rain.remove(i);
        }
      
        for (int i = 0; i<snow.size()-4; i++) {
          snow.remove(i);
          if (snow.get(i).checkBoundaries()) {
            snow.get(i).reset_position();
          }
        }
        for (int i=0;i<rain.size()-1; i++) {
          rain.get(i).moveWeather(3);
          if (rain.get(i).checkBoundaries()) {
            rain.get(i).reset_position();
          }
        }
          
        for (int j=0;j<snow.size()-1; j++) {
          snow.get(j).moveWeather(2);
          if (snow.get(j).checkBoundaries()) {
            snow.get(j).reset_position();
          }
        }
      
        for (int i=0;i<sun.size()-1; i++) {
          sun.get(i).moveWeather(1);
          if (sun.get(i).checkBoundaries()) {
            sun.get(i).reset_position();
          }
          if (sun.get(i).check_Collision(self)) {
            count++;
            sun.remove(i);
          }
        }
        self.self_move(width-aveX, aveY, 0); 
      } //End of Score

      else if (count >= 20 && count < 29) { //other score: 
      System.out.println("4");
        //15 RAIN DROPS
        background(135, 206, 250);
        for (int i = 0; i<rain.size()-4; i++) {
          rain.remove(i);
        }
        snow.clear();
        System.out.println("This is count "+ count);
        //MOVE WEATHER:
        for (int i=0;i<rain.size()-1; i++) {
          rain.get(i).moveWeather(3);
          if (rain.get(i).checkBoundaries()) {
            rain.get(i).reset_position();
          }
        }
        for (int i=0;i<sun.size()-1; i++) {
          sun.get(i).moveWeather(1);
          if (sun.get(i).checkBoundaries()) {
            sun.get(i).reset_position();
          }
          if (sun.get(i).check_Collision(self)) {
            count++;
            sun.remove(i);
          }
        }
        self.self_move(width-aveX, height-aveY, 0);
      } //End of Score
      
      else if (count == 29) {
        System.out.println("5");
         win = true;
         start = false;
        self.self_move(width-aveX, height-aveY, 0);
      }
    }//END OF GAME START
    else if(win == true && start == false){
      sun.clear();
      rain.clear();
      background(0, 191, 255);
      image(spring, 0, 0);
      textFont(text, 32);
      text("Happy Spring! Enjoy the warmth.", 500, 100);
      self.self_move(width-aveX, height-aveY, 0);
    }
       }//End of camera available
  }//End of draw
  void mousePressed() {
    //if they click, use that picture for the new thing to follow
    int offset = mouseY * cam.width + mouseX;
    
    int foundColor = cam.pixels[offset];

    //pull out the individual colors for both pixels
    objectR = red(foundColor);
    objectG = green(foundColor);
    objectB = blue(foundColor);
  }
  void keyPressed() {
    if (key == '1') {
      println("Start the game");
      start = true;
    }
  }

