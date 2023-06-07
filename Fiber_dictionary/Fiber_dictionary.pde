import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import java.util.ArrayList;
import processing.sound.*;
import ddf.minim.*;

Capture video;
OpenCV opencv;
PImage credit;
PFont f1,f2;
ArrayList<PImage> img;
int text_alpha = 3 , text_delta = 3;
ArrayList<AudioPlayer> sound;
Minim minim;
Button mute_button;
Button bgm_button;
boolean sound_play = true;
boolean sound_loop = false;
int bgm_number;
AudioPlayer sun_music;
AudioPlayer water_music;
AudioPlayer wind_music;
AudioPlayer correct_music;
AudioPlayer wrong_music;


ArrayList<Rectangle> right_x;
ArrayList<Rectangle> left_o;
ArrayList<Problem> problems;

int background_count = 0;

int solve_count = 0;
int problem_count = 0;
float percentage_x = 0;
float percentage_o = 0;
boolean opening_screen = false;
boolean select_screen = false;
boolean information_screen = false;
boolean webcam_screen = false;
boolean answer_x = false;
boolean answer_o = true;
boolean answer_check;
boolean credit_screen = true;
boolean sun_check = false;
boolean wind_check = false;
boolean water_check = false;
ArrayList<Clothes> cloth_array;
Button acrylic;
Button cotton;
Button goretex;
Button linen;
Button nylon;
Button poly;
Button wool;
Button leather;
Button webcam_button;
Button select_screen_to_opening_screen;
Button water;
Button sun;
Button wind;
Button original;
String x;
String o;
Cloth cloth = null;
Button information_screen_to_select_screen;
PFont f;
void setup(){
  size(1280, 720);
  credit = loadImage("credit.png");
  f1 = createFont("Jalnan",30);
  f2 = createFont("Jalnan",50);
  bgm_number = 1;
  textAlign(CENTER);
  img = new ArrayList<PImage>();
  sound = new ArrayList<AudioPlayer>();
  for(int i = 0; i<=6;i++){
    img.add(loadImage("img"+i+".jpg"));
  }
  for(int i = 0; i<=3;i++){
    minim = new Minim(this);
    AudioPlayer sound_file = minim.loadFile("soundfile"+i+".mp3");
    sound.add(sound_file);
  }
  mute_button = new Button(width*7/8, height*7/8, 64);
  bgm_button = new Button(width / 8, height*7/8, 64);
   cloth_array = new ArrayList<Clothes>();
    cloth_array.add(new Clothes(120,105,175,175,175, 1,1,1));
  cloth_array.add(new Clothes(440,105,175,175,175, 2,2,2));
  cloth_array.add(new Clothes(760,105,175,175,175, 1,1,1));
  cloth_array.add(new Clothes(1080,105,175,175,175, 2,2,2));
  cloth_array.add(new Clothes(120,410,175,175,175, 1,1,2));
  cloth_array.add(new Clothes(440,410,175,175,175, 1,1,2));
  cloth_array.add(new Clothes(760,410,175,175,175, 2,2,1));
  cloth_array.add(new Clothes(1080,410,175,175,175, 2,1,2));
  acrylic = new Button(160, 260, 75);
  cotton = new Button(480, 260, 75);
  goretex = new Button(800, 260, 75);
  linen = new Button(1120, 260, 75);
  nylon = new Button(160, 570, 75);
  poly = new Button(480, 570, 75);
  wool = new Button(800, 570, 75);
  leather = new Button(1120, 570, 75);
  opening_screen = true;
  webcam_button = new Button(width/2, height-50, 100);
  right_x = new ArrayList<Rectangle>();
  left_o = new ArrayList<Rectangle>();
  video = new Capture(this, 1280, 720, "pipeline:autovideosrc");
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  f = createFont("Georgia", 16);
  problems = new ArrayList<Problem>();
  problems.add(new Problem("polyester remains strong even when wet.", true));
  problems.add(new Problem("Nylon does not discolor very well.", false));
  problems.add(new Problem("Lether is easily damaged by heat.", false));
  problems.add(new Problem("Goretex has excellent waterproof and windproof functions.", true));
  problems.add(new Problem("Wool has less creses and less lint.", true));
  information_screen_to_select_screen = new Button(width-100, 100, 100);
  select_screen_to_opening_screen = new Button(100, height-50, 100);
  sun = new Button(width-400, height-50, 100);
  water = new Button(width-250, height-50, 100);
  wind = new Button(width-100, height-50, 100);
  original = new Button(width-500, height-50, 50);
  sun_music = minim.loadFile("sun.mp3");
  water_music = minim.loadFile("water.mp3");
  wind_music = minim.loadFile("wind.mp3");
  correct_music = minim.loadFile("correct.mp3");
  wrong_music = minim.loadFile("wrong.mp3");
}

void draw(){
  background(255);
  bgmPlay();   
  //screen transition
  if(opening_screen){//Opening screen implement
    if(background_count == (img.size()-1)*60){
      background_count = 0;
    }else{
      background_count++;
    }
    background(img.get(background_count/60));
    //Title 
    fadeInandOut();
    textFont(f1);
    fill(0,0,0,text_alpha);
    for(int x = -1; x < 2; x++){
    for(int y = -1; y < 2; y++){
      text("Press any Key",width/2+x,height*12/16+y);
    }  
    text("Press any Key",width/2+x,height*12/16);
    text("Press any Key",width/2,height*12/16+x);
}
    fill(255,255,255,text_alpha);
    text("Press any Key",width/2,height*12/16);
    textFont(f2);
    fill(0);
    for(int x = -1; x < 2; x++){
    for(int y = -1; y < 2; y++){
      text("Fiber Dictionary",width/2+x,height*5/16+y);
    }  
    text("Fiber Dictionary",width/2+x,height*5/16);
    text("Fiber Dictionary",width/2,height*5/16+x);
}
    fill(255,255,255,255);
    text("Fiber Dictionary", width /2, height*5/16);
    
    //sound ON/OFF
    
    mute_button.display(mouseX, mouseY);
    bgm_button.display(mouseX, mouseY);
    fill(0,0,0);
    textAlign(CENTER,CENTER);
    text(""+bgm_number+"" , width / 8, height*7/8-1);
    if(sound_play){
    sound.get(bgm_number).unmute();
    textFont(f2);
    text("♬",width*7/8-1, height*7/8-1);
    }else{
    textFont(f1);
    sound.get(bgm_number).mute();
    text("||",width*7/8+1, height*7/8-1);
  }
       if(credit_screen){
      image(credit, 0, 0, 1280, 720);
    }
  }
  else if(select_screen){ //select screen implement
    background(200, 80, 100);
    for(int i =0 ; i < cloth_array.size(); i++){
       cloth_array.get(i).display();
     }
    acrylic.display(mouseX, mouseY);
    cotton.display(mouseX, mouseY);
    goretex.display(mouseX, mouseY);
    linen.display(mouseX, mouseY);
    nylon.display(mouseX, mouseY);
    poly.display(mouseX, mouseY);
    wool.display(mouseX, mouseY);
    leather.display(mouseX, mouseY);
    webcam_button.display(mouseX, mouseY);
    select_screen_to_opening_screen.display(mouseX, mouseY);
    sun.display(mouseX, mouseY);
    wind.display(mouseX, mouseY);
    water.display(mouseX, mouseY);
    original.display(mouseX, mouseY);
    fill(0);
    textFont(f,20);
    text("Quiz", width/2, height-50);
    text("Acrylic", 160, 260);
    text("Cotton", 480, 260);
    text("Goretex", 800, 260);
    text("Linen", 1120, 260);
    text("Nylon", 160, 570);
    text("Poly", 480, 570);
    text("Wool", 800, 570);
    text("Leather", 1120, 570);
    textFont(f,32);
    text("Back",100, height-50);
    text("sun", width-400, height-50);
    text("water", width-250, height-50);
    text("wind", width-100, height-50);
  }
  else if(information_screen == true){//information screen implement
     background(255);
     cloth.clothDraw();
     information_screen_to_select_screen.display(mouseX, mouseY);
     fill(0);
     textFont(f,32);
     text("Back",width-100, 100);
  }
  else if(webcam_screen == true){//webcam quiz screen implement
    if(problem_count < problems.size()){
    textAlign(CENTER);
    image(video, 0, 0);
    video.start();
    opencv.loadImage(video);
    textFont(f, 64);
    fill(0, 255, 0);
    text("O", 200, 100);
    fill(255, 0, 0);
    text("X", width-200, 100);
    textFont(f, 32);
    fill(0);
    text(problems.get(problem_count).problem, width/2, 100);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
   if(percentage_x < 100 && percentage_o < 100){
        for (int i = 0; i < faces.length; i++) {
          println(faces[i].x);
          rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
          if(faces[i].x < (width/5)+200 && left_o.size() <= 180){ // if you choose O, the percentage of O is increasing.
            left_o.add(faces[i]);
            left_o.add(faces[i]);
            left_o.add(faces[i]);
            left_o.add(faces[i]);
            left_o.add(faces[i]);
          }
          if(faces[i].x > width-(width/5)-200 && right_x.size() <= 180){ // if you choose X, the percentage of X is increasing.
            right_x.add(faces[i]);
            right_x.add(faces[i]);
            right_x.add(faces[i]);
            right_x.add(faces[i]);
            right_x.add(faces[i]);
          }
        }
  percentage_x = right_x.size();
  x = ""+(int)percentage_x+"%";
  percentage_o = left_o.size();
  o = ""+(int)percentage_o+"%";
  stroke(0);
  fill(255, 0, 0, map(percentage_x, 0, 100, 0, 191));
  rect(width-(width/5)-200, 0, (width/5)+200, height);
  fill(0, 128, 0, map(percentage_o, 0, 100, 0, 191));
  rect(0, 0, width/5+200, height);
  fill(0);
  textFont(f, 16);
  text(x, width-200, 200);
  text(o, 200, 200);
    }
  else if(percentage_x >= 100 || percentage_o >= 100){//if you choose clearly O or X
    video.stop();
    background(255);
    if(percentage_x >= 100){
      answer_check = problems.get(problem_count).checkAnswer(answer_x); //check that the answer is X
    }
    else{
      answer_check = problems.get(problem_count).checkAnswer(answer_o); //check that the answer is O
    }
    //check answer
    if(answer_check){//if you are right
      correct_music.play();
      correct_music.rewind();
      noFill(); //drawing O
      strokeWeight(80);
      stroke(0,255,0);
      ellipse(640,360,600,600);
      problem_count += 1;
      solve_count += 1;
    }
    else{//if you are wrong
      wrong_music.play();
      wrong_music.rewind();
      fill(255,0,0);//drawing X
      stroke(255,0,0);
      quad(200,100,width-300,height-100,width-200,height-100,300,100);
      quad(200,height-100,300,height-100,width-200,100,width-300,100);
      problem_count += 1;
    }
      left_o.clear();
      right_x.clear();
      percentage_x = 0;
      percentage_o = 0;
      answer_check = false;
  }
    }
   if(problem_count == 5){
    webcam_screen = false;
    select_screen = true;
    problem_count = 0;
  }
  }
  
}

void mousePressed(){//Handling mouse clicks in context
  if(mouseButton == LEFT){
   if(mute_button.isHit(mouseX, mouseY) && opening_screen){
    if(sound_play){
    sound_play = false;
    }else{
    sound_play = true;
    }
  }
  
  else if(bgm_button.isHit(mouseX,mouseY) && opening_screen){
    bgm_number++;
    sound.get(bgm_number-1).pause();
    if(bgm_number > sound.size()-1){
      bgm_number = 1;
      sound_loop = true;
  }
  }
  else if(opening_screen && credit_screen){
    credit_screen = false;
  }
   else if(opening_screen){
    opening_screen = false;
    select_screen = true;
    }
  if(webcam_button.isHit(mouseX, mouseY) && select_screen){
    //웹캠 시작
    select_screen = false;
    webcam_screen = true;
  }
  if(acrylic.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Acrylic", new String[]{     "-a synthetic fiber, a type of plastic resin", 
     "-a popular alternative to wool",
     "-warm, soft and cheap prices",
     "-very little discoloration",
     "-produces static electricity easily",
     "-has a lot of fuzz"
    });
    select_screen = false;
    information_screen = true;
  }
  if(cotton.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Cotton", new String[]{     "-a natural fiber extracted from cotton", 
     "-has less static electricity",
     "-less damage when washing with water",
     "-a soft touch",
     "-creases easily",
     "-susceptible to germs, fungi, and insects"
    });
    select_screen = false;
    information_screen = true;
  }
   if(goretex.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Goretex", new String[]{     "-a synthetic fiber made by heating Teflon", 
     "-uses a thin film called a membrane",
     "-excellent waterproof and windproof",
     "-releases moisture in the form of a gas",
     "-the functions deteriorates over time",
     "-also used in the military industry, medicine,", 
     "and semiconductors"
    });
    select_screen = false;
    information_screen = true;
   }
   if(linen.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Linen", new String[]{    "-a natural fiber made from flax's shell stalk", 
     "-high breathability",
     "-Eco-friendly and non-irritating to the skin",
     "-light and soft",
     "-creases a lot",
     "-vulnerable to sunlight"
    });
    select_screen = false;
    information_screen = true;
   }
   if(nylon.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Nylon", new String[]{   "-synthetic fiber that uses oil as a raw material", 
     "-the highest elasticity and strength",
     "-resistant to germs and pests",
     "-discolors easily",
     "-has a lot of lint"
    });
    select_screen = false;
    information_screen = true;
   }
   if(poly.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Poly", new String[]{   "-a synthetic fiber, a polymer compound with ", 
     "an ester group as a linking group",
     "-cheap because it can be mass-produced",
     "-not easily creases",
     "-remains strong even when wet",
     "-poor absorption and produces static electricity"
    });
    select_screen = false;
    information_screen = true;
   }
   if(wool.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Wool", new String[]{   "-a natural fiber made of wool from sheeps,", 
     "cashmere:goats, alpaca:camels, angora:rabbits",
     "-less creses and less lint",
     "-soft,warm and elastic",
     "-needs dry clean"
    });
    select_screen = false;
    information_screen = true;
   }
   if(leather.isHit(mouseX, mouseY) && select_screen){
    cloth = new Cloth("Leather", new String[]{   "-a natural fiber used to skin animals", 
     "-gives off a luxurious and sophisticated feel",
     "-durable and breathable",
     "-has good heat absorption",
     "-easily damaged when touched by water"
    });
    select_screen = false;
    information_screen = true;
   }
  if(select_screen_to_opening_screen.isHit(mouseX, mouseY) && select_screen){
    select_screen = false;
    opening_screen = true;
  }
  if(information_screen_to_select_screen.isHit(mouseX, mouseY) && information_screen){
    information_screen = false;
    select_screen = true;
    cloth = null;
  }
  if(sun.isHit(mouseX, mouseY) && select_screen){
      sun_music.play();
      sun_music.rewind();
      cloth_array.get(0).clothes_discoloration();
      cloth_array.get(1).clothes_discoloration();
      cloth_array.get(2).clothes_discoloration();
      cloth_array.get(3).clothes_discoloration();
      cloth_array.get(4).clothes_discoloration();
      cloth_array.get(5).clothes_discoloration();
      cloth_array.get(6).clothes_discoloration();
      cloth_array.get(7).clothes_discoloration();
  }
  if(wind.isHit(mouseX, mouseY) && select_screen){
      wind_music.play();
      wind_music.rewind();
      cloth_array.get(0).clothes_dry();
      cloth_array.get(1).clothes_dry();
      cloth_array.get(2).clothes_dry();
      cloth_array.get(3).clothes_dry();
      cloth_array.get(4).clothes_dry();
      cloth_array.get(5).clothes_dry();
      cloth_array.get(6).clothes_dry();
      cloth_array.get(7).clothes_dry();
  }
  if(water.isHit(mouseX, mouseY) && select_screen){
      water_music.play();
      water_music.rewind();
      cloth_array.get(0).clothes_wet();
      cloth_array.get(1).clothes_wet();
      cloth_array.get(2).clothes_wet();
      cloth_array.get(3).clothes_wet();
      cloth_array.get(4).clothes_wet();
      cloth_array.get(5).clothes_wet();
      cloth_array.get(6).clothes_wet();
      cloth_array.get(7).clothes_wet();
  }
  if(original.isHit(mouseX, mouseY) && select_screen){
    cloth_array.get(0).clothes_reset();
      cloth_array.get(1).clothes_reset();
      cloth_array.get(2).clothes_reset();
      cloth_array.get(3).clothes_reset();
      cloth_array.get(4).clothes_reset();
      cloth_array.get(5).clothes_reset();
      cloth_array.get(6).clothes_reset();
      cloth_array.get(7).clothes_reset();
  }
}  
}

void keyPressed(){//Handling keyboard press in context
  if(opening_screen == true){
  opening_screen = false;  
  sound.get(0).play();
  select_screen = true;
  }
}

void captureEvent(Capture c) {
  c.read();
  
}

void fadeInandOut() {
  if (text_alpha == 0 || text_alpha == 255) {
    text_delta= -text_delta;
  }
  text_alpha += text_delta;
}

void bgmPlay(){
  sound.get(bgm_number).play();
  
  if(!sound.get(bgm_number).isPlaying()){
    bgm_number++;
    }
    if(sound_loop){
      for(int i = 1 ; i<=sound.size()-1; i++){
    sound.get(i).rewind();
      }
    sound_loop = false;
    }
}
