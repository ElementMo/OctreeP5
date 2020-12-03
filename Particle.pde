class Particle {
  float x, y, z;
  Particle(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  String toString() {
    String s = "x: " + x + " y: " + y + " z: " + z;
    return s;
  }
}
