import algorithm
import files
import imagemagick
import math
import os
import paginate
import sequtils
import strformat
import strutils
import terminal

proc msg(file: string, msg: string) =
  styledEcho(fgGreen, file, resetStyle, ": " & msg)

proc tile(files: seq[string], output: string, geometry: string): string =
  ## Tile several image files into one image.
  var args: seq[string] = @[]
  let numTiles = int(ceil(sqrt(float(len(files)))))

  args.add(files)
  args.add([
    "-auto-orient",
    "-geometry", geometry,
    "-pointsize", "8",
    "-title", parentDir(absolutePath(files[0])),
    "-tile", fmt"{numTiles}x{numTiles}"
  ])

  args.add(output)

  return montage(args)

proc filenames(files: seq[string], output: string): string =
  ## Create an image rendering a textual list of file names.
  let baseNames = files.map(lastPathPart)

  discard convert(
    "-size", "1024x1024",
    "label:" & baseNames.join("\\n"),
    output)

proc pdf(files: seq[string], output: string): string =
  ## Combine several image files into a single PDF.
  var args: seq[string] = @[]

  args.add([
    "-density", "150",
    "-resize", "1225x1600>",
    "-extent", "1275x1650",
    "-background", "white",
    "-gravity", "center"
  ])

  args.add(files)
  args.add(output)

  return convert(args)

proc main(files: seq[string], numPerPage: int = 9) =
  if len(files) == 0:
    return

  let sortedFiles = sorted(files, system.cmp)
  let path = parentDir(sortedFiles[0])

  var toDelete: seq[string] = @[]
  var toPdf: seq[string] = @[]

  let outputAll = getUniqueFile(path, "tiled", ".jpg")
  msg(outputAll, "creating tile of all images")
  for f in sortedFiles:
    styledEcho("  " & f)
  discard tile(sortedFiles, outputAll, "256x256+4+4")
  toPdf.add(outputAll)

  let outputFiles = getUniqueFile(path, "tiled (all)", ".jpg")
  msg(outputFiles, "creating page with list of image names")
  discard filenames(sortedFiles, outputFiles)
  toDelete.add(outputFiles)
  toPdf.add(outputFiles)

  if len(sortedFiles) > numPerPage:
    var index = 1

    for page in paginate(files, numPerPage):
      let outputPage = getUniqueFile(path, fmt"tiled ({index})", ".jpg")

      msg(outputPage, "creating page of tiled images")
      for f in page:
        styledEcho("  " & f)

      discard tile(page, outputPage, "512x512+4+4")
      toDelete.add(outputPage)
      toPdf.add(outputPage)

      index = index + 1

  let outputPdf = getUniqueFile(path, "tiled", ".pdf")
  msg(outputPdf, "creating pdf")
  for f in toPdf:
    styledEcho("  " & f)
  discard pdf(toPdf, outputPdf)

  removeFiles(toDelete)

when isMainModule:
  system.addQuitProc(resetAttributes)

  import cligen
  dispatch(main, "tile_images",
    doc = """
      When using a set of images for language learning, it is often helpful to
      combine them into a single tiled image.  For example, this image can be
      printed to use during language sessions.  Or it can be attached as "cover
      art" to a recorded MP3 for listening drills.  This tool combines a given
      set of images into a single tiled image.  In addition, it creates a PDF
      containing both the single tiled image as well as the tiled images spread
      across multiple pages to faciliate better printing quality and a page
      containing the list of files included in the PDF for reference purposes.
    """,
    help = {
      "files": "input image files"
    })

