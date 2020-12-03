import peasy.*;
PeasyCam cam;

Octree octree;

float xVal, yVal, zVal = 0;
boolean isCtrlDown = false;

void setup() {
  size(800, 500, P3D);
  hint(ENABLE_DEPTH_TEST);
  hint(ENABLE_DEPTH_SORT);
  cam = new PeasyCam(this, 500);
  sphereDetail(1);

  Box boundary = new Box(0, 0, 0, 300, 200, 200);
  octree = new Octree(boundary, 4);

  int range = 150;
  for (int i=0; i<0; i++) {
    float x = random(-range, range); 
    float y = random(-range, range); 
    float z = random(-range, range); 
    Particle p = new Particle(x, y, z);
    octree.Insert(p);
  }
}
void draw() {
  background(51);

  octree.Show();

  if (mousePressed && isCtrlDown) {
    Particle p = new Particle(mouseX - 250, mouseY-250, 50.0f);
    octree.Insert(p);
  } 
  if (isCtrlDown) {
    Box range = new Box(mouseX - 250, mouseY - 250, 0, 50, 50, 50);
    pushMatrix();
    translate(mouseX - 250, mouseY - 250, 0);
    box(50*2, 50*2, 50*2);
    popMatrix();

    ArrayList<Particle> queryParticle = new ArrayList<Particle>();
    queryParticle = octree.Query(range, queryParticle);

    stroke(0, 200, 0);
    for (Particle p : queryParticle) {
      pushMatrix();
      translate(p.x, p.y, p.z);
      sphere(2.0f);
      popMatrix();
    }
  }
  if (isCtrlDown) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }

  stroke(255);
  pushMatrix();
  translate(mouseX - 250, mouseY-250, 50.0f);
  sphere(5);
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == CONTROL) {
      isCtrlDown = true;
    }
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == CONTROL) {
      isCtrlDown = false;
    }
  }
}
