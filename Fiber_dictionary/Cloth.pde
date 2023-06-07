class Cloth{//Collect common parts and classify them to produce various clothes from an OOP perspective
  PImage back = loadImage("background.jpg");
  PImage fabric;
  PImage clothes;
  PFont f;
  String cloth_fabric;
  String[] explain;
  Cloth(String cloth_fabric, String[] explain){
  this.cloth_fabric = cloth_fabric;
  this.explain = explain;
  f = loadFont("MaiandraGD-Regular-48.vlw");
  if(cloth_fabric == "Acrylic"){
     fabric = loadImage("acrylic.png"); 
     clothes = loadImage("knit.png");
   }
   else if(cloth_fabric == "Cotton"){
    fabric = loadImage("cotton.png"); 
    clothes = loadImage("hoodi.png");
   }
   else if(cloth_fabric == "Goretex"){
     fabric = loadImage("goretex.png"); 
    clothes = loadImage("bamak.png");
   }
   else if(cloth_fabric == "Linen"){
     fabric = loadImage("linen.png"); 
    clothes = loadImage("shirts.png");
   }
   else if(cloth_fabric == "Nylon"){
     fabric = loadImage("nylon.png"); 
    clothes = loadImage("anorak.png");
   }
   else if(cloth_fabric == "Poly"){
    fabric = loadImage("poly.png"); 
    clothes = loadImage("bbogeul.png");
   }
   else if(cloth_fabric == "Wool"){
    fabric = loadImage("wool.png"); 
    clothes = loadImage("coat.png");
   }
   else if(cloth_fabric == "Leather"){
    fabric = loadImage("leather.png"); 
    clothes = loadImage("leatherjacket.png");
   }
  }
  void clothDraw(){//Fuction to draw information screen
    int i = 0;
    background(255);
    textFont(f, 30);
    fill(0);
    image(back, 0,0,width,height);
    image(clothes, 140, 130, 500, 500);
    image(fabric, 90, 150, 140, 140);
    text(cloth_fabric, 100, 50);
    for(i = 0; i < explain.length; i++){
      text(explain[i], 900, 180+70*i);
    }
  }
}
