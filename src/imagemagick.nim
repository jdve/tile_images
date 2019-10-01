import os
import osproc
import strformat
import terminal

proc error(msg: string) =
  styledWriteLine(stderr, fgRed, "Error: ", resetStyle, msg)

proc cmd(exe: string, args: varargs[string]): string =
  let cmd = findExe(exe, false)

  if cmd == "":
    error(fmt"Can't find {exe} in the current directory or in your PATH.  Please install ImageMagick 7.0 or greater.")
    quit(QuitFailure)

  let quoted = quoteShellCommand(cmd & @args)

  let (output, exitCode) = execCmdEx(quoted, {poStdErrToStdOut})

  if exitCode != 0:
    error(fmt"Failed to run command {quoted}")
    styledEcho(output)
    quit(QuitFailure)

  return output

proc montage*(args: varargs[string]): string = cmd("montage", args)
proc convert*(args: varargs[string]): string = cmd("convert", args)

