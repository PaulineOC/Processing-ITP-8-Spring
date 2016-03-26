class Shape {
  //shape color: 
  int r;
  int g;
  int b;

  //shape size
  int shape_width;
  int shape_height;
  int shape_size;

  //shape position
  int x;
  int y; 

  //shape speed
  float velocity_x;
  float velocity_y;

  //Images:
  PImage sun;
  PImage snow;
  PImage bird;

  //for rain: 
  int radius;

  //Constuctor 2: for SNOW + SUN + RAIN
  Shape (int type) {
    switch(type)
    {
    case 1: 
      sun = loadImage("Sun.png"); 
      shape_width = 50; 
      shape_height=50;
      x = (int)random(width); 
      y = 0 - shape_height;  
      velocity_y=(int)random(1, 9);
      break;
    case 2: 
      snow = loadImage ("snowflake.png");
      shape_width = 50; 
      shape_height=50; 
      x = (int)random(width); 
      y = 0 - shape_height; 
      velocity_y = (int)random(1, 9);
      break;
    case 3: 
      radius = 8;
      x = (int)random(width); 
      y= -r*4;
      velocity_y = (int)random(1, 9); 
      shape_height = r*4;
      break;
    }
  }

Shape(int type, int _x, int _y){
      bird = loadImage("Bird.png");
      shape_width=75;
      shape_height=75;
      x = _x;
      y = _y;
}

  void drawshape(int type) {
    stroke(0, 0, 255);
    fill(0, 0, 255);
    switch (type) {
    case 0: 
      image(bird, x, y);
      break;
    case 1: 
      image(sun, x, y);
      break;
    case 2: 
      image(snow, x, y);
      break;
    case 3: 
      for (int i = 2; i < radius; i++ ) {
        ellipse(x, y + i*4, i*2, i*2);
      }
      break;
    }
  }



  //MOVING shape: 
  //for "INPUTS"
  void self_move(int input_x, int input_y,int _type) {
    x=input_x;
    y=input_y;
    this.drawshape(_type);
  }

  void moveWeather(int type) {
    y+=velocity_y;
    this.drawshape(type);
  }

  boolean checkBoundaries() {
    boolean out_of_bounds = false;
    //BOTTOM
    if (y>(height+(1.25*shape_height))) {
      out_of_bounds = true;
    }
    return out_of_bounds;
  }

 void reset_position(){
   y = 0 - shape_height;
   x = (int)random(width);
 }

  //Getter Methods for collision detection 
  int get_X_Position() {
    return x;
  }
  int get_Y_Position() {
    return y;
  }
  int get_shape_Height() {
    return shape_height;
  }

  int get_shape_Width() {
    return shape_width;
  }


  //COLLISION
  boolean check_Collision(Shape temporary) {
    boolean signal = false;
    int temp_x = temporary.get_X_Position();
    int temp_y = temporary.get_Y_Position();
    int temp_shape_height = temporary.get_shape_Height();
    int temp_shape_width = temporary.get_shape_Width();

    if (x < (temp_x + temp_shape_width) && (x+shape_width) > (temp_x )) {   
      if (y < (temp_y + temp_shape_height) && (y+shape_height) > (temp_y )) {
        signal = true;
      }
      else {
        signal = false;
      }
    }
    return signal;
  }
}// End of shape class

