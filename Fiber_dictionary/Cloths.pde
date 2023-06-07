class Clothes{ //Clothes is java class for drawing cloth.
  float x,y;
  int r,g,b;
  int reset_rgb;
  int speed_wet, speed_discoloration, speed_dry;
  boolean bool_dry = false;
  int init_rgb;
  
  Clothes(float x_, float y_, int r_,int g_,int b_,int w , int d , int breath){
    x = x_;
    y = y_;
    init_rgb = 120;
    reset_rgb = r_;
    r = r_;
    g = g_;
    b = b_;
    speed_wet = w;
    speed_discoloration = d;
    speed_dry = breath;
  }
  
  void display(){//Fuction to display cloth
    stroke(0);
    fill(r,g,b);
    quad(x-15,y-90, x-65,y-45 ,x-35,y+10 ,x-20,y-9);
    quad(x+95,y-90,x+145,y-45,x+115,y+10,x+100,y-9);
    quad(x-15,y-90,x-25,y+90,x+105,y+90,x+95,y-90);
    fill(255);
    bezier(x,y-90,x+5,y-45,x+75,y-40, x+80,y-90);
  }
  
  void clothes_wet(){//Function to show wetness of clothes
    r -= speed_wet;
    g -= speed_wet;
    b -= speed_wet;
  }
  
  void clothes_discoloration(){//Function to show discoloration of clothes
    r += speed_discoloration;
    g += speed_discoloration;
  }
  
  void clothes_dry(){//Function to show the breathability of clothes
    if(!bool_dry){
      r = init_rgb;
      g = init_rgb;
      b = init_rgb;
      bool_dry = true;
    }
    r += speed_wet;
    g += speed_wet;
    b += speed_wet;
    if( r >= reset_rgb){
      bool_dry = false;
    }
  }
  
  void clothes_reset(){//Function to initialize the clothes state
    r = reset_rgb;
    g = reset_rgb;
    b = reset_rgb;
  }
}
