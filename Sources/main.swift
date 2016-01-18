import Foundation

func main(args: [String]) {
  if args.count < 2 {
    print("Usage: raylang-swift <model.smf>")
    return
  }

  print("cwd: " + NSFileManager.defaultManager().currentDirectoryPath)

  let path = args[1]
  guard let smf = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding) else {
    print("Unable to read file: \(path)")
    return
  }

  let lines = smf.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
  let vertices  = lines.filter({ $0.hasPrefix("v") })
  let faces     = lines.filter({ $0.hasPrefix("f") })

  print("vertices: \(vertices.count) faces: \(faces.count)")
}

main(Process.arguments)
