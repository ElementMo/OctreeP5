class Box {
  float x, y, z;
  float w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
  Box(Box other) {
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
    this.w = other.w;
    this.h = other.h;
    this.d = other.d;
  }

  boolean Contains(Particle p) {
    return (
      p.x >= x - w &&
      p.x <= x + w &&
      p.y >= y - h &&
      p.y <= y + h &&
      p.z >= z - d &&
      p.z <= z + d);
  }

  boolean Intersects(Box range) {
    return !(
      range.x - range.w > x + w ||
      range.x + range.w < x - w ||
      range.y - range.h > y + h ||
      range.y + range.h < y - h ||
      range.z - range.d > z + d ||
      range.z + range.d < z - d);
  }
}
