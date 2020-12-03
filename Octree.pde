class Octree {
  Box boundary;
  ArrayList<Particle> particles;
  int capacity;
  boolean isDivided;

  Octree ulf, urf, ulb, urb, dlf, drf, dlb, drb;

  Octree(Box boundary, int n) {
    this.boundary = new Box(boundary);
    this.capacity = n;
    this.particles = new ArrayList<Particle>();
    this.isDivided = false;
  }

  void SubDivide() {
    float x = this.boundary.x;
    float y = this.boundary.y;
    float z = this.boundary.z;
    float w = this.boundary.w * 0.5f;
    float h = this.boundary.h * 0.5f;
    float d = this.boundary.d * 0.5f;

    Box b_ulf = new Box(x-w, y+h, z-d, w, h, d);
    Box b_urf = new Box(x+w, y+h, z-d, w, h, d);
    Box b_ulb = new Box(x-w, y+h, z+d, w, h, d);
    Box b_urb = new Box(x+w, y+h, z+d, w, h, d);
    this.ulf = new Octree(b_ulf, this.capacity);
    this.urf = new Octree(b_urf, this.capacity);
    this.ulb = new Octree(b_ulb, this.capacity);
    this.urb = new Octree(b_urb, this.capacity);

    Box b_dlf = new Box(x-w, y-h, z-d, w, h, d);
    Box b_drf = new Box(x+w, y-h, z-d, w, h, d);
    Box b_dlb = new Box(x-w, y-h, z+d, w, h, d);
    Box b_drb = new Box(x+w, y-h, z+d, w, h, d);
    this.dlf = new Octree(b_dlf, this.capacity);
    this.drf = new Octree(b_drf, this.capacity);
    this.dlb = new Octree(b_dlb, this.capacity);
    this.drb = new Octree(b_drb, this.capacity);

    isDivided = true;
  }

  boolean Insert(Particle p) {
    if (!this.boundary.Contains(p)) {
      return false;
    }

    if (particles.size() < this.capacity) {
      particles.add(p);
      return true;
    } else {
      if (!isDivided) {
        SubDivide();
      }
      if (ulf.Insert(p)) {
        return true;
      } else if (urf.Insert(p)) {
        return true;
      } else if (ulb.Insert(p)) {
        return true;
      } else if (urb.Insert(p)) {
        return true;
      } else if (dlf.Insert(p)) {
        return true;
      } else if (drf.Insert(p)) {
        return true;
      } else if (dlb.Insert(p)) {
        return true;
      } else if (drb.Insert(p)) {
        return true;
      }
    }
    return false;
  }

  ArrayList<Particle> Query(Box queryBoundary, ArrayList<Particle> found) {
    if (found == null) {
      found = new ArrayList<Particle>();
    }
    if (boundary.Intersects(queryBoundary)) {
      for (Particle p : particles) {
        if (queryBoundary.Contains(p)) { 
          found.add(p);
        }
      }
      if (isDivided) {
        found = ulf.Query(queryBoundary, found);
        found = urf.Query(queryBoundary, found);
        found = ulb.Query(queryBoundary, found);
        found = urb.Query(queryBoundary, found);

        found = dlf.Query(queryBoundary, found);
        found = drf.Query(queryBoundary, found);
        found = dlb.Query(queryBoundary, found);
        found = drb.Query(queryBoundary, found);
      }
    }
    return found;
  }

  void Show() {

    noFill();
    stroke(255, 20);

    pushMatrix();
    translate(boundary.x, boundary.y, boundary.z);
    box(boundary.w*2, boundary.h*2, boundary.d*2 );
    popMatrix();

    stroke(255, 200);
    for (Particle p : particles) {
      pushMatrix();
      translate(p.x, p.y, p.z);
      sphere(2.0f);
      popMatrix();
    }


    if (isDivided) {
      ulf.Show();
      urf.Show();
      ulb.Show();
      urb.Show();

      dlf.Show();
      drf.Show();
      dlb.Show();
      drb.Show();
    }
  }

  String toString() {
    String s = "";
    if (isDivided) {
      s += ulf.toString();
      s += urf.toString();
      s += ulb.toString();
      s += urb.toString();

      s += dlf.toString();
      s += drf.toString();
      s += dlb.toString();
      s += drb.toString();
    } else {
      s += particles.size();
    }
    return s;
  }
}
