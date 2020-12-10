public class Platform {
  private float w, h;
  private PVector location;
  private int speed;
  private PImage jump;
  private int mode;

  public Platform(float x, float y, float w, float h, int mode) { // Normal constructor
    this.mode=mode;
    this.w=w;
    this.h=h;
    location=new PVector(x, y);
    this.speed=int(random(1,3));
    if (this.speed==2){
      this.speed=-1;
    }
    jump=loadImage("images/jump"+mode+".png");
    jump.resize(int(w), int(h));
  }

  public void drawPlatform() {
      image(jump, location.x, location.y, w, h);
  }

  public void move() {
    if (mode==0) {
      speed=(int(random(-6,7)));
      if (location.x+speed>width-w) {
        speed=-speed;
      } else if (location.x+speed<0) {
        speed=-speed;
      }
      location.x+=speed;
    }
        else if (mode==2) {
      if (location.x+speed>width-w) {
        speed=-speed;
      } else if (location.x+speed<0) {
        speed=-speed;
      }
      location.x+=speed;
    }
  }


  boolean isTouching() {
    float ds=doodle.size;
    float dx=doodle.location.x;
    float dy=doodle.location.y;
    float px=this.location.x;
    float py=this.location.y;

    if (dx<px && dx+ds<px || dx>px+w && dx+ds>px+w) {// return false if its not on x axis ( completly off x)
      return false;
    }
    if (dy+ds<py && dy+ds<py+h || dy+ds>py && dy+ds>py+h) {// return false if its not on y axis (if sprites feet are touching platform)
      return false;
    }
    if (dy+ds-doodle.velocity.y >py) {// return false if its still in the block if it moves up (if doodle feet are inside of the platform when it changes direction)
      return false;
    }
    return true;
  }
}
