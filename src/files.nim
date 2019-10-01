import os
import tempfile

proc getTempFile*(ext: string): string =
  ## Return a new temp file name.
  var (fp, filename) = mkstemp(suffix=ext)
  fp.close()

  return filename

proc getUniqueFile*(dir: string, name: string, ext: string): string =
  ## Return a new file name with an added number (if needed) to ensure that it doesn't exist.
  var new = joinPath(dir, name & ext)
  var count = 2

  while fileExists(new):
    new = joinPath(dir, name & " (" & $count & ")" & ext)
    count = count + 1

  return new

proc removeFiles*(files: seq[string]) =
  ## Remove a list of files.
  for file in files:
    removeFile(file)

