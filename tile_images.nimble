# Package
version       = "0.1.0"
author        = "Jonathan Van Eenwyk"
description   = "For language learning, combine images representing a set of learning content into a tiled image"
license       = "MIT"
binDir        = "bin"
srcDir        = "src"
bin           = @["tile_images"]

# Dependencies
requires "nim >= 0.20.2", "cligen >= 0.9.38", "tempfile >= 0.1.7"

