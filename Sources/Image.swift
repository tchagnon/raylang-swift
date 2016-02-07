import CPNG

#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

/** Temporary function to encapsulate PNG writing */
func writeImage(filename: String) {
  let fp = fopen(filename, "wb")
  if fp == nil {
    print("Unable to open file for writing")
    return
  }
  defer {
    fclose(fp)
  }

  var png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil)
  if png_ptr == nil {
    print("Unable to create write struct")
    return
  }

  var info_ptr = png_create_info_struct(png_ptr)
  if info_ptr == nil {
    png_destroy_write_struct(&png_ptr, nil)
    return
  }
  defer {
    png_destroy_write_struct(&png_ptr, &info_ptr)
  }

  let width = 512
  let height = 512
  let bit_depth = 8
  png_set_IHDR(png_ptr, info_ptr,
    UInt32(width), UInt32(height), Int32(bit_depth),
    PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
    PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT)


  var rows = [[UInt8]](count: height, repeatedValue: [UInt8](count: width*3, repeatedValue: 0))

  for i in 0..<height {
    for j in 0..<width {
      rows[i][j*3 + 0] = UInt8(255 * Double(j)/Double(width))
      rows[i][j*3 + 1] = UInt8(255 * Double(i)/Double(width))
      rows[i][j*3 + 2] = UInt8(255 * Double(i+j)/Double(width+height))
    }
  }

  var row_pointers = [UnsafeMutablePointer<UInt8>](count: height, repeatedValue: nil)
  for i in 0..<height {
    row_pointers[i] = UnsafeMutablePointer<UInt8>(rows[i])
  }

  png_set_rows(png_ptr, info_ptr, &row_pointers)

  png_init_io(png_ptr, fp)
  png_write_png(png_ptr, info_ptr, PNG_TRANSFORM_IDENTITY, nil)
}