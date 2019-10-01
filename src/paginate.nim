import math

proc paginate*(files: openArray[string], numPerPage: int): seq[seq[string]] =
  let numFiles = len(files)
  let numPages = int(ceil(float(numFiles) / float(numPerPage)))

  for page in 0..<numPages:
    let fromIndex = page * numPerPage
    let toIndex = min((page + 1) * numPerPage, numFiles)

    result.add(files[fromIndex..<toIndex])

