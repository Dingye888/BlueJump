public class Doodle {
  private float size;                                   // Width and height of Doodle;
  private final float speed=6.5555555555, gravity=0.1;// Defalt bounce speed || Gravity pulling down
  private PVector location, velocity, acceleration;   // location(x,y) Velocity(vx,vy) Acceleration(ax,ay)
  private PImage blueLeft,blueRight;

  //Constructor
  public Doodle(float x, float y, float size) {
    this.size=size;
    location=    new PVector(x, y);  // Starting position
    velocity=    new PVector(0, -this.speed);               // Defalt speed (going up)
    acceleration=new PVector(0, this.gravity);              // Defalt speed (going up)
    blueLeft=loadImage("images/blueLeft.png");
    blueLeft.resize(int(size), int(size));
    blueRight=loadImage("images/blueRight.png");
    blueRight.resize(int(size),int( size));
  }

  //Draws Doodle *******************************************************************************************************************************
  public void drawDoodle() {
    if(velocity.x<=0){
          image(blueLeft,location.x, location.y, size, size);
    }
    else if( velocity.x>0){
      image(blueRight,location.x, location.y, size, size);
    }
  }

  //Make Doodle bounce  *******************************************************************************************************************************
  public void doBounce() {
    velocity.y=-speed;
  }
  public void doMove() {  //Moves Doodle   *******************************************************************************************************************************
    changeX();
    changeY();
  }

  //Change the acceleration of x  *******************************************************************************************************************************
  public void changeX() {
    if (mouseX>location.x+size/2) {
      velocity.x=(mouseX-(location.x+size/2))/30; //Mouse X-location
    } else if (mouseX<location.x+size/2) {
      velocity.x=-(location.x+size/2-mouseX)/30; //Mouse location-MouseX
    }  
    location.x+=velocity.x;
  }

  //Change the acceleration of x  *******************************************************************************************************************************
  public void changeY() {
    location.y+=velocity.y+=acceleration.y;  // also adds acceleration if it has any
  }
}
