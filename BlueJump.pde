Doodle doodle; //<>// //<>// //<>// //<>//
ArrayList<Platform> plats= new ArrayList();       // Platforms
PImage image;                                     // background
PVector cs; //current score location
PVector gg; // game over location
PFont f; // a font
float w=65, h=16;    // platform size
float size=40;       // doodle size 40
float score=0.0;
boolean dead=false;  // if u died
boolean wait=false;  //its its waiting for imput
int level;
float cap=100; // cap 180

void setup() {
  frameRate(120);// 120 Defalt  :::::::::::::::::::::::::::::::::::::::::::::::::: FrameRate Debug ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  size(600, 1000);
  image =loadImage("images/background.PNG");
  image.resize(width, height);
  f= createFont("Corbel bold", 50, true);
  level=0;
  menu();
}

void draw() {
  background(image); // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Background Debug ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  gameplay();  // the main gameplay
}
void mouseClicked() {
  if (!wait) {
    return;
  };
  if (level==0) {
    if (mouseX>gg.x && mouseX <gg.x+165 && mouseY > gg.y+80 && mouseY < gg.y+80+45) {
      level=1;
      restart();
    } else if (mouseX>gg.x && mouseX <gg.x+191 && mouseY > gg.y+140 && mouseY < gg.y+140+45) {
      level=2;
      restart();
    }
  } else if (level==1) {
    if (mouseX>gg.x && mouseX <gg.x+135 && mouseY > gg.y+80 && mouseY < gg.y+80+45) {
      restart();
    } else if (mouseX>gg.x && mouseX <gg.x+75 && mouseY > gg.y+140 && mouseY < gg.y+140+45) {
      level=0;
      menu();
    }
  } else if (level==2) {
    if (mouseX>gg.x && mouseX <gg.x+135 && mouseY > gg.y+80 && mouseY < gg.y+80+45) {
      restart();
    } else if (mouseX>gg.x && mouseX <gg.x+75 && mouseY > gg.y+140 && mouseY < gg.y+140+45) {
      level=0;
      menu();
    }
  }
}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Game Menu  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void menu() {
  this.wait=true;
  this.dead=false;
  this.score=0;
  plats= new ArrayList();
  doodle=new Doodle(100, height-size, size);
  gg=new PVector(width/2-110, 300);        // game over text

  plats.add(new Platform(100-size/3, 800, w, h, 1));
} 

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Restart the game  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void restart() {
  this.wait=false;
  this.dead=false;
  this.score=0;
  plats= new ArrayList();
  doodle=new Doodle(width/2-size/2, height-size, size);

  cs=new PVector(190, 130);                 // text pos score
  gg=new PVector(width/2-110, height*2);    // game over text

  for (float i=height-h; i>0; i-=cap) {   // makes new platforms
    if (i==height-h) {
      plats.add(new Platform(width/2-w/2, i, w, h, 1));
    } else {
      plats.add(new Platform(random(0, width-w), random(i, -30), w, h, 1));
    }
  }
}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Changes Everything  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void gameplay() {
  drawThing(); // draw everything
  if (level==0) {
    doodle.changeY();
  } else {
    for (Platform p : plats) {
      p.move();
    }
    doodle.doMove();
  }

  if (doodle.velocity.y>0) {                 // blue falling
    ifBounce();
    ifDead();
  } else if (doodle.velocity.y<0) {          // blue rising
    if (doodle.location.y<height/2) {        // if sprite is at ubove half of screen
      ifCam();
      ifPlat();
    }
  }
}

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::   Draws  Everything  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void drawThing() {
  for (Platform p : plats) {            // draws all plat
    p.drawPlatform();
  }
  textFont(f);
  if (level==0) {
    textSize(50);
    text("BlueJump", gg.x, gg.y);       // draws text
    textSize(30);
    fill(255, 250, 205);
    rect(gg.x, gg.y+50+30, 165, 45);     
    rect(gg.x, gg.y+50+90, 191, 45);      
    fill(80);
    text("Casual Mode", gg.x, gg.y+80+30);        // draws text
    text("Advance Mode", gg.x, gg.y+80+90);       // draws text
  } else {
    fill(80);
    text(score, cs.x, cs.y);       // draws score
  }
  doodle.drawDoodle();             //draws sprite

  if (dead) {
    textSize(50);
    text("Game Over!", gg.x, gg.y);                   // draws text
    textSize(30);
    text("Your Score: "+score, gg.x, gg.y+50);        // draws text
    fill(255, 250, 205);
    rect(gg.x, gg.y+50+30, 135, 45);            // draws text
    rect(gg.x, gg.y+50+90, 75, 45);             // draws text
    fill(80);
    text("play again", gg.x, gg.y+80+30);       // draws text
    text("menu", gg.x, gg.y+80+90);             // draws text
  }
}


// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Makes sprite bounce  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void ifBounce() {
  for (Platform p : plats) {
    if (p.isTouching() ) {
      doodle.location.y=p.location.y-doodle.size; // change doodle to the top of the platform (prevent spirte from stucking in)
      doodle.doBounce();
    }
  }
}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Moves Camra  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void ifCam() {
  float ans=height/2-doodle.location.y;
  doodle.location.y+=ans;  // minus the sprites speed so it stays still
  for (Platform p : plats) {
    p.location.y+=ans;     // makes all the platform movedown relative to sprites speed.
  }
  score+=ans;              // the amount that the camra moves is the points.
}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Ends game  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void ifDead() {
  if (doodle.location.y+doodle.size>=height || dead) {
    dead=true;
    if (plats.size()>0) {
      ArrayList<Platform> ans=new ArrayList();
      for (Platform p : plats) {
        p.location.y-=10;
        if (p.location.y<=0-h) {
          ans.add(p);
        }
      }
      plats.removeAll(ans);
    }

    //  drawThing(); // draws the ending

    if (gg.y>height/2-50) {
      cs.y-=10;
      gg.y-=10;
    }
    if (doodle.location.y<height) {
      doodle.velocity.y=0;
      doodle.acceleration.y+=0.12;
      doodle.location.y-=10;
    } else if (doodle.location.y>height+size) {
      this.wait=true;
    }
  }
}

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  Recurse platforms  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void ifPlat() {
  ArrayList<Platform> ans= new ArrayList(); //sub
  ArrayList<Platform> anp= new ArrayList(); //add

  for (Platform p : plats) {
    if (p.location.y+p.h>=height) {
      ans.add(p);
      if (level==1) {
        anp.add(new Platform(random(0, width-w), random(0, -30), w, h, p.mode));
      } else if (level ==2) {
        int rand=int(random(1, 2));
        if (score>3000) {
          rand=int(random(1, 3));
        }
        if (score>6000) {
          rand=int(random(0, 3));
        }
        if (score>9000) {
          rand=2;
        }

        if (rand>=3) {
          rand=2;
        }

        anp.add(new Platform(random(0, width-w), random(0, -30), w, h, rand));
      }
    }
  }
  plats.removeAll(ans);
  plats.addAll(anp);
}

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  Recurse platforms  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
