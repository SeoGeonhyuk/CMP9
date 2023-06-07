class Button { //Button class is java class for making Button.
  float x;
  float y;
  float r;
  
  Button(float x_, float y_, float r_){
    x = x_;
    y = y_;
    r = r_;
  }
  
  boolean isHit(float mx, float my) {
    if(dist(mx, my, x, y) < r) {
      return true;
    }
    else{
      return false;
    }
  }
  
  void display(float mx, float my) {
    if(isHit(mx, my)){
      fill(100);
    }
    else{
      fill(175);
    }
    stroke(0);
    strokeWeight(4);
    ellipse(x,y,r,r);
  }
}
