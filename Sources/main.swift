import Foundation

func main(args: [String]) {
  if args.count < 3 {
    print("Usage: raylang-swift <model.smf> <image.png>")
    return
  }

  let path = args[1]
  guard let mesh = Mesh(path: path) else {
    print("Unable to read smf file: \(path)")
    return
  }
  print("vertices: \(mesh.vertices.count) faces: \(mesh.faces.count)")

  let image = args[2]
  writeImage(image)
  print("Wrote image: \(image)")
}

main(Process.arguments)
