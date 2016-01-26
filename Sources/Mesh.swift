import Foundation

struct Vec3f {
  let x, y, z: Float
}

func readVertex(s: String) -> Vec3f {
  //
  return Vec3f(x: 0 ,y: 0 ,z: 0)
}

struct Face {
  let a, b, c: Int
}

extension Face {
  init(s: String) {
    let v = s.componentsSeparatedByCharactersInSet(
      NSCharacterSet.whitespaceCharacterSet())
      .flatMap { Int($0) }
      .map { $0 - 1 }
    a = v[0]
    b = v[1]
    c = v[2]
  }
}

class Mesh {
  let vertices: [Vec3f]
  let faces: [Face]

  init?(path: String) {
    guard let smf = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding) else {
      vertices = []
      faces = []
      return nil
    }

    let lines = smf.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())

    vertices = lines
      .filter { $0.hasPrefix("v") }
      .map(readVertex)

    faces = lines
      .filter({ $0.hasPrefix("f") })
      .map(Face.init)
  }

}