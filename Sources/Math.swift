// Math module for core vector and matrix operations.
#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

extension Float {

  /** Degrees to radians */
  func toRadians() -> Float {
    return Float(M_PI) * self / 180.0
  }

  func clamp(lower: Float, upper: Float) -> Float {
    return max(min(self, upper), lower)
  }
}

/**
 * 3x1 real vector type
 */
struct Vec3f: Equatable {
  let x, y, z: Float
}

extension Vec3f {
  static func zero() -> Vec3f {
    return Vec3f(x: 0.0, y: 0.0, z: 0.0)
  }

  func dot(rhs: Vec3f) -> Float {
    return x * rhs.x + y * rhs.y + z * rhs.z
  }

  /** Dot product, clamped to 0 */
  func dot0(rhs: Vec3f) -> Float {
    return max(dot(rhs), 0.0)
  }

  func cross(rhs: Vec3f) -> Vec3f {
    return Vec3f(
      x: y * rhs.z - z * rhs.y,
      y: z * rhs.x - x * rhs.z,
      z: x * rhs.y - y * rhs.x)
  }
  
  func pointMul(rhs: Vec3f) -> Vec3f {
    return Vec3f(
      x: x * rhs.x,
      y: y * rhs.y,
      z: z * rhs.z)
  }
  
  func scale(rhs: Float) -> Vec3f {
    return Vec3f(
      x: x * rhs,
      y: y * rhs,
      z: z * rhs)
  }
  
  func magnitudeSquared() -> Float {
    return self.dot(self)
  }
  
  func magnitude() -> Float {
    return sqrtf(magnitudeSquared())
  }
  
  func norm() -> Vec3f {
    return scale(1.0 / magnitude())
  }
  
  /**
   * Compute a partial determinant using and b as the first two columns
   * of a 3 column matrix.  Returns a vector which can be dot-product
   * multiplied by the third column to give the determinant scalar value.
   */
  func partialDeterminant(b: Vec3f) -> Vec3f {
    let a = self
    return Vec3f(
      x: a.y*b.z - a.z*b.y,
      y: a.z*b.x - a.x*b.z,
      z: a.x*b.y - a.y*b.x)
  }
}

func ==(a: Vec3f, b: Vec3f) -> Bool {
  return a.x == b.x && a.y == b.y && a.z == b.z
}

func +(lhs: Vec3f, rhs: Vec3f) -> Vec3f {
  return Vec3f(
    x: lhs.x + rhs.x,
    y: lhs.y + rhs.y,
    z: lhs.z + rhs.z)
}

func -(lhs: Vec3f, rhs: Vec3f) -> Vec3f {
  return Vec3f(
    x: lhs.x - rhs.x,
    y: lhs.y - rhs.y,
    z: lhs.z - rhs.z)
}

/**
 * 4x1 real vector type
 */
struct Vec4f: Equatable {
    let x, y, z, w: Float
}

extension Vec4f {
  init(v: Vec3f) {
    x = v.x
    y = v.y
    z = v.z
    w = 1.0
  }

  static func zero() -> Vec4f {
    return Vec4f(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
  }
  
  func dot(rhs: Vec4f) -> Float {
    return x * rhs.x + y * rhs.y + z * rhs.z + w * rhs.w
  }
  
  func dot3(rhs: Vec3f) -> Float {
    return x * rhs.x + y * rhs.y + z * rhs.z
  }
  
  func pointMul(rhs: Vec4f) -> Vec4f {
    return Vec4f(
      x: x * rhs.x,
      y: y * rhs.y,
      z: z * rhs.z,
      w: w * rhs.w)
  }
  
  func scale(s: Float) -> Vec4f {
    return Vec4f(
      x: x * s,
      y: y * s,
      z: z * s,
      w: w * s)
  }
  
  func magnitudeSquared() -> Float {
    return self.dot(self)
  }
  
  func magnitude() -> Float {
    return sqrtf(magnitudeSquared())
  }
  
  func norm() -> Vec4f {
    return scale(1.0 / magnitude())
  }
}

func ==(a: Vec4f, b: Vec4f) -> Bool {
  return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w
}

func +(lhs: Vec4f, rhs: Vec4f) -> Vec4f {
  return Vec4f(
    x: lhs.x + rhs.x,
    y: lhs.y + rhs.y,
    z: lhs.z + rhs.z,
    w: lhs.w + rhs.w)
}

func -(lhs: Vec4f, rhs: Vec4f) -> Vec4f {
  return Vec4f(
    x: lhs.x - rhs.x,
    y: lhs.y - rhs.y,
    z: lhs.z - rhs.z,
    w: lhs.w - rhs.w)
}

/**
 * 4x4 Row Matrix
 */
struct Mat4f: Equatable {
  let r1, r2, r3, r4: Vec4f
}

extension Mat4f {
  static func identity() -> Mat4f {
    return Mat4f(
      r1: Vec4f(x: 1.0, y: 0.0, z: 0.0, w: 0.0),
      r2: Vec4f(x: 0.0, y: 1.0, z: 0.0, w: 0.0),
      r3: Vec4f(x: 0.0, y: 0.0, z: 1.0, w: 0.0),
      r4: Vec4f(x: 0.0, y: 0.0, z: 0.0, w: 1.0))
  }

  // Construct a translation matrix
  static func translate(v: Vec3f) -> Mat4f {
    return Mat4f(
      r1: Vec4f(x: 1.0, y: 0.0, z: 0.0, w: v.x),
      r2: Vec4f(x: 0.0, y: 1.0, z: 0.0, w: v.y),
      r3: Vec4f(x: 0.0, y: 0.0, z: 1.0, w: v.z),
      r4: Vec4f(x: 0.0, y: 0.0, z: 0.0, w: 1.0))
  }
  
  // Construct a scaling matrix
  static func scale(v: Vec3f) -> Mat4f {
    return Mat4f(
      r1: Vec4f(x: v.x, y: 0.0, z: 0.0, w: 0.0),
      r2: Vec4f(x: 0.0, y: v.y, z: 0.0, w: 0.0),
      r3: Vec4f(x: 0.0, y: 0.0, z: v.z, w: 0.0),
      r4: Vec4f(x: 0.0, y: 0.0, z: 0.0, w: 1.0))
  }
  
  // Construct a rotation matrix
  static func rotate(v: Vec3f, angle: Float) -> Mat4f {
    let r = angle.toRadians()
    let c = cosf(r)
    let s = sinf(r)
    let (x, y, z) = (v.x, v.y, v.z)
    let (x2, y2, z2) = (x*x, y*x, z*z)
    return Mat4f(
      r1: Vec4f(x: x2+(1.0-x2)*c,     y: x*y*(1.0-c)-z*s,  z: x*z*(1.0-c)+y*s,  w: 0.0),
      r2: Vec4f(x: x*y*(1.0-c)+z*s,   y: y2+(1.0-y2)*c,    z: y*z*(1.0-c)-x*s,  w: 0.0),
      r3: Vec4f(x: x*z*(1.0-c)-y*s,   y: y*z*(1.0-c)+x*s,  z: z2+(1.0-z2)*c,    w: 0.0),
      r4: Vec4f(x: 0.0, y: 0.0, z: 0.0, w: 1.0))
  }
  
  func transpose() -> Mat4f {
    return Mat4f(
      r1: Vec4f(x: r1.x, y: r2.x, z: r3.x, w: r4.x),
      r2: Vec4f(x: r1.y, y: r2.y, z: r3.y, w: r4.y),
      r3: Vec4f(x: r1.z, y: r2.z, z: r3.z, w: r4.z),
      r4: Vec4f(x: r1.w, y: r2.w, z: r3.w, w: r4.w))
  }

  func transformPoint(point: Vec3f) -> Vec3f {
    let p = self * Vec4f(v: point)
    let w = p.w
    return Vec3f(x: p.x/w, y: p.y/w, z: p.z/w)
  }
  
  func transformDirection(v: Vec3f) -> Vec3f {
    return Vec3f(x: r1.dot3(v), y: r2.dot3(v), z: r3.dot3(v))
  }

}

func ==(a: Mat4f, b: Mat4f) -> Bool {
  return a.r1 == b.r1 && a.r2 == b.r2 && a.r3 == b.r3 && a.r4 == b.r4
}

func *(A: Mat4f, x: Vec4f) -> Vec4f {
  return Vec4f(x: A.r1.dot(x), y: A.r2.dot(x), z: A.r3.dot(x), w: A.r4.dot(x))
}

func *(A: Mat4f, B: Mat4f) -> Mat4f {
  let t = B.transpose()
  return Mat4f(r1: A*t.r1, r2: A*t.r2, r3: A*t.r3, r4: A*t.r4)
    .transpose()
}