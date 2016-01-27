import XCTest

class MathTests: XCTestCase {

  func testRadians() {
    XCTAssertEqual(Float(360).toRadians(), Float(M_PI) * 2.0)
  }

  func testVec3f() {
    let u = Vec3f(x: 1.0, y: 2.0, z: 3.0)
    let v = Vec3f(x: 4.0, y: 5.0, z: 6.0)
    XCTAssertEqual(u + v, Vec3f(x: 5.0, y: 7.0, z: 9.0))
    XCTAssertEqual(u - v, Vec3f(x: -3.0, y: -3.0, z: -3.0))
    XCTAssertEqual(Vec3f.zero(), Vec3f(x: 0.0, y: 0.0, z: 0.0))
    XCTAssertEqual(u.cross(v), Vec3f(x: -3.0, y: 6.0, z: -3.0))
    XCTAssertEqual(u.pointMul(v), Vec3f(x: 4.0, y: 10.0, z: 18.0))
    XCTAssertEqual(u.dot(v), 32.0)
    XCTAssertEqual(u.scale(3.0), Vec3f(x: 3.0, y: 6.0, z: 9.0))
    XCTAssertEqual(u.magnitudeSquared(), 14.0)
    XCTAssertEqual(u.magnitude(), 3.7416575)
    XCTAssertEqual(u.norm(), Vec3f(x: 0.26726124, y: 0.5345225, z: 0.8017837))
  }

  func testVec4f() {
    let u = Vec4f(x: 1.0, y: 2.0, z: 3.0, w: 4.0)
    let v = Vec4f(x: 5.0, y: 6.0, z: 7.0, w: 8.0)
    XCTAssertEqual(u + v, Vec4f(x: 6.0, y: 8.0, z: 10.0, w: 12.0))
    XCTAssertEqual(u - v, Vec4f(x: -4.0, y: -4.0, z: -4.0, w: -4.0))
    XCTAssertEqual(Vec4f.zero(), Vec4f(x: 0.0, y: 0.0, z: 0.0, w: 0.0))
    XCTAssertEqual(u.pointMul(v), Vec4f(x: 5.0, y: 12.0, z: 21.0, w: 32.0))
    XCTAssertEqual(u.dot(v), 70.0)
    XCTAssertEqual(u.scale(3.0), Vec4f(x: 3.0, y: 6.0, z: 9.0, w: 12.0))
    XCTAssertEqual(u.magnitudeSquared(), 30.0)
    XCTAssertEqual(u.magnitude(), 5.477225575)
    XCTAssertEqual(u.norm(), Vec4f(x: 0.1825741858, y: 0.3651483717, z: 0.5477225575, w: 0.7302967433))
  }

  func testMat4f() {
    let A = Mat4f(
      r1: Vec4f(x: 1.0, y: 2.0, z: 3.0, w: 4.0),
      r2: Vec4f(x: 5.0, y: 6.0, z: 7.0, w: 8.0),
      r3: Vec4f(x: 9.0, y: 10.0, z: 11.0, w: 12.0),
      r4: Vec4f(x: 13.0, y: 14.0, z: 15.0, w: 16.0))
    let B = Mat4f(
      r1: Vec4f(x: 17.0, y: 18.0, z: 19.0, w: 20.0),
      r2: Vec4f(x: 21.0, y: 22.0, z: 23.0, w: 24.0),
      r3: Vec4f(x: 25.0, y: 26.0, z: 27.0, w: 28.0),
      r4: Vec4f(x: 29.0, y: 30.0, z: 31.0, w: 23.0))
    let C = Mat4f(
      r1: Vec4f(x: 250.0, y: 260.0, z: 270.0, w: 244.0),
      r2: Vec4f(x: 618.0, y: 644.0, z: 670.0, w: 624.0),
      r3: Vec4f(x: 986.0, y: 1028.0, z: 1070.0, w: 1004.0),
      r4: Vec4f(x: 1354.0, y: 1412.0, z: 1470.0, w: 1384.0))
    XCTAssertEqual(A * B, C)
  }
}