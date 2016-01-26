import Foundation

func main(args: [String]) {
  if args.count < 2 {
    print("Usage: raylang-swift <model.smf>")
    return
  }

  print("cwd: " + NSFileManager.defaultManager().currentDirectoryPath)

  let path = args[1]
  guard let mesh = Mesh(path: path) else {
    print("Unable to read smf file: \(path)")
    return
  }
  
  print("vertices: \(mesh.vertices.count) faces: \(mesh.faces.count)")
}

main(Process.arguments)
